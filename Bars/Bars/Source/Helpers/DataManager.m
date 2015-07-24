//
//  DataManager.m
//  Bars
//
//  Created by Djuro Alfirevic on 7/23/15.
//  Copyright (c) 2015 Djuro Alfirevic. All rights reserved.
//

#import "DataManager.h"
#import "WebServiceManager.h"
#import "DBBar.h"
#import "AppDelegate.h"
#import "JSONNullChecker.h"

@interface DataManager()
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (assign, nonatomic) BOOL dataFetched;
@end

@implementation DataManager

#pragma mark - Properties

- (void)setUserLocation:(CLLocation *)userLocation
{
    _userLocation = userLocation;
    
    if ([[WebServiceManager sharedInstance] hasInternetConnection] && !self.dataFetched) {
        [[WebServiceManager sharedInstance] requestBarsNearLocation:self.userLocation
                                                withCompletionBlock:^(BOOL success, NSError *error)
         {
             if (success) {
                 self.dataFetched = YES;
                 
                 if ([self.delegate respondsToSelector:@selector(dataManagerPreparedData)]) {
                     [self.delegate dataManagerPreparedData];
                 }
             }
         }];
    } else {
        if ([self.delegate respondsToSelector:@selector(dataManagerPreparedData)]) {
            [self.delegate dataManagerPreparedData];
        }
    }
}

- (NSManagedObjectContext *)managedObjectContext
{
    if (!_managedObjectContext) {
        AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        _managedObjectContext = appDelegate.managedObjectContext;
    }
    
    return _managedObjectContext;
}

#pragma mark - Public API

+ (DataManager *)sharedInstance
{
    static DataManager *sharedManager;
    
    @synchronized(self) {
        if (sharedManager == nil) {
            sharedManager = [[DataManager alloc] init];
        }
    }
    
    return sharedManager;
}

- (void)parseDictionary:(NSDictionary *)dictionary
{
    for (NSDictionary *barDictionary in dictionary) {
        [self createBarFromDictionary:barDictionary];
    }
}

- (NSArray *)bars
{
    return [self cachedBars];
}

#pragma mark - Private API

- (BOOL)barAlreadyAddedByID:(NSString *)barID
{
    NSArray *bars = [self cachedBars];
    if (bars == nil) return NO;
    
    for (DBBar *bar in bars) {
        if ([barID isEqualToString:bar.barID]) {
            return YES;
        }
    }
    
    return NO;
}

- (void)createBarFromDictionary:(NSDictionary *)dictionary
{
    if ([self barAlreadyAddedByID:[JSONNullChecker parseSTRING:dictionary[@"id"]]]) return;
    
    DBBar *dbBar = (DBBar *)[NSEntityDescription insertNewObjectForEntityForName:@"DBBar"
                                                          inManagedObjectContext:self.managedObjectContext];
    
    dbBar.barID = [JSONNullChecker parseSTRING:dictionary[@"id"]];
    dbBar.name = [JSONNullChecker parseSTRING:dictionary[@"name"]];
    dbBar.city = [JSONNullChecker parseSTRING:dictionary[@"location"][@"city"]];
    dbBar.latitude = [NSNumber numberWithFloat:[JSONNullChecker parseFLOAT:dictionary[@"location"][@"lat"]]];
    dbBar.longitude = [NSNumber numberWithFloat:[JSONNullChecker parseFLOAT:dictionary[@"location"][@"lng"]]];
    dbBar.checkinsCount = [NSNumber numberWithInt:[JSONNullChecker parseINT:dictionary[@"stats"][@"checkinsCount"]]];
    
    [self.managedObjectContext save:nil];
}

- (NSArray *)cachedBars
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"DBBar" inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entityDescription];
    
    NSSortDescriptor *checkinsDescriptor = [[NSSortDescriptor alloc] initWithKey:@"checkinsCount" ascending:NO];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:checkinsDescriptor, nil];
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    NSError *error;
    NSMutableArray *resultsArray = [[self.managedObjectContext executeFetchRequest:fetchRequest error:&error] mutableCopy];
    
    if (resultsArray == nil) NSLog(@"Error fetching DBBars.");
    
    return resultsArray;
}

@end
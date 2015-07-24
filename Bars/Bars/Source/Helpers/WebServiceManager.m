//
//  WebServiceManager.m
//  Bars
//
//  Created by Djuro Alfirevic on 7/23/15.
//  Copyright (c) 2015 Djuro Alfirevic. All rights reserved.
//

#import "WebServiceManager.h"
#import "DataManager.h"
#import "Reachability.h"

@interface WebServiceManager()
@property (copy, nonatomic) NSString *accessCode;
@end

@implementation WebServiceManager

#pragma mark - Public API

+ (WebServiceManager *)sharedInstance
{
    static WebServiceManager *sharedManager;
    
    @synchronized(self)	{
        if (sharedManager == nil) {
            sharedManager = [[WebServiceManager alloc] init];
        }
    }
	
	return sharedManager;
}

- (BOOL)hasInternetConnection
{
	Reachability *reach		= [Reachability reachabilityForInternetConnection];
	NetworkStatus status	= [reach currentReachabilityStatus];
	
	if (status == NotReachable) {
		return NO;
	}
	
	return YES;
}

- (void)requestBarsNearLocation:(CLLocation *)location
            withCompletionBlock:(void(^)(BOOL success, NSError *error))completion
{
    if (![self hasInternetConnection]) {
        if (completion){
            completion(NO, nil);
        }
        return;
    }
    
    NSString *url = [NSString stringWithFormat:@"%@/venues/search?client_id=%@&client_secret=%@&v=%@&ll=%.2f,%.2f&categoryId=%@",
                     kApiURL,
                     kClientID,
                     kClientSecret,
                     @"20130815",
                     location.coordinate.latitude,
                     location.coordinate.longitude,
                     @"4bf58dd8d48988d116941735"]; // Bars categoryID (Foursquare Category Archive - https://developer.foursquare.com/categorytree)
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:url
      parameters:nil
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             NSData *data = [operation.responseString dataUsingEncoding:NSUTF8StringEncoding];
             NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
             
             // Parsing...
             if (dictionary) {
                 NSLog(@"%@", dictionary[@"response"][@"venues"]);
                 [[DataManager sharedInstance] parseDictionary:dictionary[@"response"][@"venues"]];
             }
             
             [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
             
             if (completion){
                 completion(YES, nil);
             }
         }
         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
             
             if (completion){
                 completion(NO, error);
             }
         }];
}

@end
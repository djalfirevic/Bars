//
//  DataManager.h
//  Bars
//
//  Created by Djuro Alfirevic on 7/23/15.
//  Copyright (c) 2015 Djuro Alfirevic. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@protocol DataManagerDelegate <NSObject>
@optional
- (void)dataManagerPreparedData;
@end

#define kCachingEnabled YES

@interface DataManager : NSObject
@property (strong, nonatomic) CLLocation *userLocation;
@property (weak, nonatomic) id<DataManagerDelegate> delegate;

+ (id)sharedInstance;
- (void)parseDictionary:(NSDictionary *)dictionary;
- (NSArray *)bars;
@end
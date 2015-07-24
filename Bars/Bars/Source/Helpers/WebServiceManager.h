//
//  WebServiceManager.h
//  Bars
//
//  Created by Djuro Alfirevic on 7/23/15.
//  Copyright (c) 2015 Djuro Alfirevic. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "AFNetworking.h"

typedef void (^WebServiceCompletionHandler)(BOOL success, NSDictionary *dictionary, NSError *error);

@interface WebServiceManager : NSObject
+ (id)sharedInstance;
- (BOOL)hasInternetConnection;
- (void)requestBarsNearLocation:(CLLocation *)location
            withCompletionBlock:(void(^)(BOOL success, NSError *error))completion;
@end
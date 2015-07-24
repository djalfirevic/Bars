//
//  JSONNullChecker.h
//  Bars
//
//  Created by Djuro Alfirevic on 7/23/15.
//  Copyright (c) 2015 Djuro Alfirevic. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JSONNullChecker : NSObject
+ (NSString *)parseSTRING:(id)object;
+ (BOOL)parseBOOL:(id)object;
+ (int)parseINT:(id)object;
+ (long long)parseLONG:(id)object;
+ (float)parseFLOAT:(id)object;
@end
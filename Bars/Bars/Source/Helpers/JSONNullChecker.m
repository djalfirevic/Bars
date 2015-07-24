//
//  JSONNullChecker.m
//  Bars
//
//  Created by Djuro Alfirevic on 7/23/15.
//  Copyright (c) 2015 Djuro Alfirevic. All rights reserved.
//

#import "JSONNullChecker.h"

@implementation JSONNullChecker

#pragma mark - Public API

+ (NSString *)parseSTRING:(id)object
{
    if (object == nil) return @"";
    
    return [object isKindOfClass:[NSNull class]] ? @"" : object;
}

+ (BOOL)parseBOOL:(id)object
{
    return [object isKindOfClass:[NSNull class]] ? NO : [object boolValue];
}

+ (int)parseINT:(id)object
{
    if ([object isKindOfClass:[NSArray class]] && ((NSArray *)object).count > 0){
        object = [(NSArray *)object objectAtIndex:0];
    }
    
    return [object isKindOfClass:[NSNull class]] ? 0 : [object intValue];
}

+ (long long)parseLONG:(id)object
{
    return [object isKindOfClass:[NSNull class]] ? 0 : [object longLongValue];
}

+ (float)parseFLOAT:(id)object
{
    return [object isKindOfClass:[NSNull class]] ? 0.0 : [object floatValue];
}

@end
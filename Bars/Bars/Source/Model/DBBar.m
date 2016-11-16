//
//  DBBar.m
//  Bars
//
//  Created by Djuro Alfirevic on 7/24/15.
//  Copyright (c) 2015 Djuro Alfirevic. All rights reserved.
//

#import "DBBar.h"

@implementation DBBar
@dynamic barID;
@dynamic name;
@dynamic city;
@dynamic latitude;
@dynamic longitude;
@dynamic checkinsCount;

#pragma mark - MKAnnotation

- (NSString *)title {
    return self.name;
}

- (NSString *)subtitle {
    return [NSString stringWithFormat:@"Checkins No. - %d", [self.checkinsCount intValue]];
}

- (CLLocationCoordinate2D)coordinate {
    return CLLocationCoordinate2DMake([self.latitude floatValue], [self.longitude floatValue]);
}

@end

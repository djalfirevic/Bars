//
//  DBBar.h
//  Bars
//
//  Created by Djuro Alfirevic on 7/24/15.
//  Copyright (c) 2015 Djuro Alfirevic. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import <MapKit/MapKit.h>

@interface DBBar : NSManagedObject <MKAnnotation>
@property (strong, nonatomic) NSString *barID;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *city;
@property (strong, nonatomic) NSNumber *latitude;
@property (strong, nonatomic) NSNumber *longitude;
@property (strong, nonatomic) NSNumber *checkinsCount;
@end
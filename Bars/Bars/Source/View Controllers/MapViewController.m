//
//  MapViewController.m
//  Bars
//
//  Created by Djuro Alfirevic on 7/23/15.
//  Copyright (c) 2015 Djuro Alfirevic. All rights reserved.
//

#import "MapViewController.h"
#import "WebServiceManager.h"
#import "DBBar.h"
#import <MapKit/MapKit.h>

@interface MapViewController() <MKMapViewDelegate, DataManagerDelegate>
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (assign, nonatomic) BOOL mapZoomed;
@end

@implementation MapViewController

#pragma mark - Private API

- (void)addAnnotations {
    for (DBBar *bar in [self.dataManager bars]) {
        [self.mapView addAnnotation:bar];
    }
}

- (void)zoomMapAtLocation:(CLLocation *)location {
    if (!self.mapZoomed) {
        [self.mapView setRegion:MKCoordinateRegionMake(location.coordinate, MKCoordinateSpanMake(0.05f, 0.05f))
                       animated:YES];
        
        self.mapZoomed = YES;
    }
}

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataManager.delegate = self;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

#pragma mark - DataManagerDelegate

- (void)dataManagerPreparedData {
    [self addAnnotations];
    [self zoomMapAtLocation:self.dataManager.userLocation];
}

@end

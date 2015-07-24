//
//  BaseViewController.m
//  Bars
//
//  Created by Djuro Alfirevic on 7/24/15.
//  Copyright (c) 2015 Djuro Alfirevic. All rights reserved.
//

#import "BaseViewController.h"

@implementation BaseViewController

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.dataManager = [DataManager sharedInstance];
}

@end
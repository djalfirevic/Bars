//
//  BaseViewController.h
//  Bars
//
//  Created by Djuro Alfirevic on 7/24/15.
//  Copyright (c) 2015 Djuro Alfirevic. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataManager.h"

@interface BaseViewController : UIViewController <DataManagerDelegate>
@property (strong, nonatomic) DataManager *dataManager;
@end
//
//  ListViewController.m
//  Bars
//
//  Created by Djuro Alfirevic on 7/23/15.
//  Copyright (c) 2015 Djuro Alfirevic. All rights reserved.
//

#import "ListViewController.h"
#import "DBBar.h"

@interface ListViewController() <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *itemsArray;
@end

@implementation ListViewController

#pragma mark - Properties

- (NSArray *)itemsArray
{
    if (!_itemsArray) {
        _itemsArray = [self.dataManager bars];
    }
    
    return _itemsArray;
}

#pragma mark - Actions

- (IBAction)closeButtonTapped
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}

#pragma mark - View lifecycle

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.itemsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BarCell" forIndexPath:indexPath];
    
    DBBar *bar = [self.itemsArray objectAtIndex:indexPath.row];
    
    cell.textLabel.text = [bar title];
    cell.detailTextLabel.text = [bar subtitle];
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
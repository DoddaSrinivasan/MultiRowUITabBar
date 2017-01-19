//
//  DSViewController.m
//  MultiRowUITabBar
//
//  Created by Dodda Srinivasan on 09/02/2016.
//  Copyright (c) 2016 Dodda Srinivasan. All rights reserved.
//

#import "DSTabViewController.h"
#import "ViewController.h"

@interface DSTabViewController (){
    NSArray *_tabTitles;
    NSArray *_tabImages;
}

@end

@implementation DSTabViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    _tabTitles = @[@"One", @"Two", @"Three", @"Four", @"Five", @"Six", @"Seven", @"Eight", @"Nine", @"Ten"];
    [self setupTabBar];
}

-(NSUInteger)numberOfMenuItems{
    return _tabTitles.count;
}

-(void)setMenuItem:(DSMenuItem *)menuItem forIndex:(NSUInteger)index{
    menuItem.uiLblMenuItem.text = _tabTitles[index];
}

-(UITabBarItem *)tabBarItemForIndex:(NSUInteger)index{
    return [[UITabBarItem alloc] initWithTitle:_tabTitles[index] image:nil tag:index];
}

-(UIViewController *)viewControllerForIndex:(NSUInteger)index{
    ViewController *controller = [ViewController controller];
    [controller initLabel:_tabTitles[index]];
    return controller;
}

@end

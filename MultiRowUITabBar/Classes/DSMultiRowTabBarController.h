//
//  MultiRowTabBarController.h
//  MultiRowTabBar
//
//  Created by Srinivasan Dodda on 22/03/16.
//  Copyright © 2016 Srinivasan Dodda. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DSMenu.h"

@class DSMenuTheme;
@interface DSMultiRowTabBarController : UITabBarController <UITabBarControllerDelegate, DSMenuViewDelegate>

@property (strong, nonatomic) DSMenuTheme *theme;

-(void)setupTabBar;

-(NSUInteger)numberOfMenuItems;
-(void)setMenuItem:(DSMenuItem *)menuItem forIndex:(NSUInteger)index;

-(UITabBarItem *)tabBarItemForIndex:(NSUInteger)index;
-(UIViewController *)viewControllerForIndex:(NSUInteger)index;

@end

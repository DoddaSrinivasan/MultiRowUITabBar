//
//  DSViewController.m
//  MultiRowUITabBar
//
//  Created by Dodda Srinivasan on 09/02/2016.
//  Copyright (c) 2016 Dodda Srinivasan. All rights reserved.
//

#import "DSTabViewController.h"
#import "ViewController.h"
#import "DSMenuTheme.h"

@interface DSTabViewController (){
    NSArray *_tabTitles;
}

@end

@implementation DSTabViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    _tabTitles = @[@"ONE", @"TWO", @"THREE", @"FOUR", @"FIVE", @"SIX", @"SEVEN"];
    [self styleTabBar];
    
    [self setupTabBar];
    
    self.theme.overlayColor = [UIColor colorWithWhite:0 alpha:0.5];
    self.theme.noOfTabsInRowForIPhone = 4;
}

- (void)styleTabBar {
    CGRect tabBarItemRect = CGRectMake(0, 0, self.tabBar.frame.size.width / 4.0, 60);
    
    UIGraphicsBeginImageContext(tabBarItemRect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [[UIColor whiteColor] CGColor]);
    CGContextFillRect(context, tabBarItemRect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    [[UITabBar appearance] setTintColor:[UIColor blueColor]];
    [[UITabBar appearance] setUnselectedItemTintColor:[UIColor blackColor]];
    [[UITabBar appearance] setSelectionIndicatorImage:image];
    [[UITabBar appearance] setBackgroundImage:image];
    
    NSDictionary *tabbarItemTitleAttributesNormal = @{
                                                      NSForegroundColorAttributeName : [UIColor blackColor],
                                                      NSFontAttributeName : [UIFont systemFontOfSize:10],
                                                      };
    
    NSDictionary *tabbarItemTitleAttributesSelected = @{
                                                        NSForegroundColorAttributeName : [UIColor redColor],
                                                        NSFontAttributeName : [UIFont boldSystemFontOfSize:12]
                                                        };
    
    [[UITabBarItem appearance] setTitleTextAttributes:tabbarItemTitleAttributesNormal
                                             forState:UIControlStateNormal];
    
    [[UITabBarItem appearance] setTitleTextAttributes:tabbarItemTitleAttributesSelected
                                             forState:UIControlStateSelected];
    
    [UITabBarItem appearance].titlePositionAdjustment = UIOffsetMake(0, -2);
}

-(NSUInteger)numberOfMenuItems{
    return _tabTitles.count;
}

-(void)setMenuItem:(DSMenuItem *)menuItem forIndex:(NSUInteger)index{
    menuItem.uiLblMenuItem.text = _tabTitles[index];
    menuItem.imgMenuItem.image = [UIImage imageNamed:@"flight"];
    menuItem.constraintLabelBottom.constant = 3;
    menuItem.constraintImageBottom.constant = 15;
}

-(UITabBarItem *)tabBarItemForIndex:(NSUInteger)index{
    UIImage *image = [UIImage imageNamed:@"flight"];
    UITabBarItem *tabBarItem = [[UITabBarItem alloc] initWithTitle:_tabTitles[index]
                                         image:image
                                           tag:index];
    tabBarItem.image = [tabBarItem.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    return tabBarItem;
}


-(UIViewController *)viewControllerForIndex:(NSUInteger)index{
    ViewController *controller = [ViewController controller];
    [controller initLabel:_tabTitles[index]];
    return [[UINavigationController alloc] initWithRootViewController:controller];
}

@end

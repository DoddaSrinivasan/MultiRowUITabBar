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
}

@end

@implementation DSTabViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    _tabTitles = @[@"ONE", @"TWO", @"THREE", @"FOUR", @"FIVE", @"SIX", @"SEVEN"];
    [self setupTabBar];
    [self styleTabBar];
    
    self.menuItemHeight = 60;
}

- (void)styleTabBar {
    CGRect tabBarItemRect = CGRectMake(0, 0, self.tabBar.frame.size.width / 5.0, 60);
    
    UIGraphicsBeginImageContext(tabBarItemRect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [[UIColor whiteColor] CGColor]);
    CGContextFillRect(context, tabBarItemRect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    [[UITabBar appearance] setTintColor:[UIColor redColor]];
    [[UITabBar appearance] setSelectionIndicatorImage:image];
    [[UITabBar appearance] setBackgroundImage:image];
    
    NSDictionary *tabbarItemTitleAttributesNormal = @{
                                                      NSForegroundColorAttributeName : [UIColor grayColor],
                                                      NSFontAttributeName : [UIFont systemFontOfSize:10]
                                                      };
    
    NSDictionary *tabbarItemTitleAttributesSelected = @{
                                                        NSForegroundColorAttributeName : [UIColor redColor],
                                                        NSFontAttributeName : [UIFont systemFontOfSize:10]
                                                        };
    
    [[UITabBarItem appearance] setTitleTextAttributes:tabbarItemTitleAttributesNormal forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:tabbarItemTitleAttributesSelected forState:UIControlStateSelected];
    [UITabBarItem appearance].titlePositionAdjustment = UIOffsetMake(0, -2);
    
    CGSize size = CGSizeMake(1, 5);
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    CGContextRef shadowContext = UIGraphicsGetCurrentContext();
    CGColorSpaceRef colorspace = CGColorSpaceCreateDeviceRGB();
    size_t gradientNumberOfLocations = 2;
    CGFloat gradientLocations[2] = {0.0, 1.0};
    CGFloat color = 88.0 / 255;
    CGFloat gradientComponents[8] = {color, color, color, 0.01, color, color, color, 0.3};
    CGGradientRef gradient = CGGradientCreateWithColorComponents(colorspace, gradientComponents, gradientLocations, gradientNumberOfLocations);
    CGContextDrawLinearGradient(shadowContext, gradient, CGPointMake(0, 0), CGPointMake(0, size.height), 0);
    UIImage *shadowImage = UIGraphicsGetImageFromCurrentImageContext();
    CGGradientRelease(gradient);
    CGColorSpaceRelease(colorspace);
    UIGraphicsEndImageContext();
    [[UITabBar appearance] setShadowImage:shadowImage];
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
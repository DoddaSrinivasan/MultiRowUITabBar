//
//  MultiRowTabBarController.h
//  MultiRowTabBar
//
//  Created by Srinivasan Dodda on 22/03/16.
//  Copyright © 2016 Srinivasan Dodda. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MRMenu.h"

@interface MultiRowTabBarController : UITabBarController <UITabBarControllerDelegate, MRMenuViewDelegate>

@property (strong, nonatomic) UIColor *menuBackGroundColor;

@property (strong, nonatomic) UIColor *menuOverLayBackGroundColor;

@property (strong, nonatomic) UIColor *menuItemBackGroundColor;

@property (strong, nonatomic) UIColor *menuItemSelectdBackGroundColor;

@property (strong, nonatomic) NSString *moreButtonText;

@property (strong, nonatomic) NSString *closeButtonText;

@property NSUInteger menuItemHeight;

@property NSUInteger noOfTabsInRowForIPhone;

@property NSUInteger noOfTabsInRowForIPad;

-(void)setUpTabBarForIndex:(int)index;
-(void)setupMenu;

@end

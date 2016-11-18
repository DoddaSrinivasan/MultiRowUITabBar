//
//  MultiRowTabBarController.h
//  MultiRowTabBar
//
//  Created by Srinivasan Dodda on 22/03/16.
//  Copyright © 2016 Srinivasan Dodda. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DSMenu.h"

@interface DSMultiRowTabBarController : UITabBarController <UITabBarControllerDelegate, DSMenuViewDelegate>

@property NSUInteger menuItemHeight;

@property NSUInteger noOfTabsInRowForIPhone;
@property NSUInteger noOfTabsInRowForIPad;

-(void)setupTabBar;

@end

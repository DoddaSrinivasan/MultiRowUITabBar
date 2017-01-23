//
//  DSMenuTheme.m
//  Pods
//
//  Created by Srinivasan Dodda on 23/01/17.
//
//

#import "DSMenuTheme.h"

const int DEFAULT_IPHONE_TABS = 5;
const int DEFAULT_IPAD_TABS = 5;
const CGFloat DEFAULT_MENU_ITEM_HEIGHT = 55.0;

@implementation DSMenuTheme

-(id)init{
    if(self == [super init]){
        [self setDefaults];
    }
    return self;
}

-(void)setDefaults{
    self.noOfTabsInRowForIPad = DEFAULT_IPAD_TABS;
    self.noOfTabsInRowForIPhone = DEFAULT_IPHONE_TABS;
    self.menuItemHeight = DEFAULT_MENU_ITEM_HEIGHT;
    
    _menuBackgroundColor = [UIColor whiteColor];
    _menuItemBackgroundColor = [UIColor whiteColor];
    _menuItemSelectedBackgroundColor = [UIColor whiteColor];
    _overlayColor = [UIColor colorWithWhite:0 alpha:0.5];
    _closeText = @"CLOSE";
}


-(UIColor *)tintColor{
    return [UITabBar appearance].unselectedItemTintColor;
}

-(UIColor *)selectedTintColor{
    return [UITabBar appearance].tintColor;
}

-(UIFont *)normalFont{
    NSDictionary *attributes = [[UITabBarItem appearance] titleTextAttributesForState:UIControlStateNormal];
    return [attributes objectForKey:NSFontAttributeName];
}

-(UIFont *)selectedFont{
    NSDictionary *attributes = [[UITabBarItem appearance] titleTextAttributesForState:UIControlStateSelected];
    return [attributes objectForKey:NSFontAttributeName];
}

-(UIColor *)textColor{
    NSDictionary *attributes = [[UITabBarItem appearance] titleTextAttributesForState:UIControlStateNormal];
    return [attributes objectForKey:NSForegroundColorAttributeName];
}

-(UIColor *)selectedTextColor{
    NSDictionary *attributes = [[UITabBarItem appearance] titleTextAttributesForState:UIControlStateSelected];
    return [attributes objectForKey:NSForegroundColorAttributeName];
}

@end

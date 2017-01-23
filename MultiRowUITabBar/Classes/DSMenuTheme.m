//
//  DSMenuTheme.m
//  Pods
//
//  Created by Srinivasan Dodda on 23/01/17.
//
//

#import "DSMenuTheme.h"

@implementation DSMenuTheme


-(UIColor *)tintColor{
    return [UITabBar appearance].unselectedItemTintColor;
}

-(UIColor *)selectedTintColor{
    return [UITabBar appearance].tintColor;
}

-(UIColor *)menuBackgroundColor{
    return [UIColor whiteColor];
}

-(UIColor *)menuItemBackgroundColor{
    return [UIColor whiteColor];
}

-(UIColor *)menuItemSelectedBackgroundColor{
    return [UIColor whiteColor];
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

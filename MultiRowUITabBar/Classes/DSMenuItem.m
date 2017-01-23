//
//  BLRMenuItem.m
//  BLR Airport
//
//  Created by Srinivasan Dodda on 15/03/16.
//  Copyright © 2016 Thoughtworks. All rights reserved.
//

#import "DSMenuItem.h"
#import "DSMenuTheme.h"

@implementation DSMenuItem

-(void)styleCellFor:(DSMenuTheme *)theme andActive:(BOOL)isActive{
    self.uiLblMenuItem.textColor = isActive ? theme.selectedTextColor : theme.textColor;
    self.imgMenuItem.image = [self.imgMenuItem.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    
    [self.imgMenuItem setTintColor:isActive ? theme.selectedTintColor : theme.tintColor];
    self.backgroundColor = isActive ? theme.menuItemSelectedBackgroundColor : theme.menuItemBackgroundColor;
}

@end

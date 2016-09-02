//
//  BLRMenuItem.m
//  BLR Airport
//
//  Created by Srinivasan Dodda on 15/03/16.
//  Copyright © 2016 Thoughtworks. All rights reserved.
//

#import "DSMenuItem.h"

@implementation DSMenuItem

-(void)initWith:(NSDictionary *)menuItem{
    [self.imgMenuItem setImage:[UIImage imageNamed:[menuItem valueForKey:@"imageName"]]];
    self.uiLblMenuItem.text = [menuItem valueForKey:@"name"];
}

@end

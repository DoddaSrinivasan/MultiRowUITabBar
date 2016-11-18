//
//  Menu.h
//  BLR Airport
//
//  Created by Srinivasan Dodda on 15/03/16.
//  Copyright © 2016 Thoughtworks. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DSMenuItem.h"

@protocol DSMenuViewDelegate <NSObject>
    -(void)hideMenu;
    -(void)selectTab:(int)index;

    -(NSInteger)numberOfMenuItems;
    -(void)setMenuItem:(DSMenuItem *)menuItem forIndex:(NSUInteger)index;
@end


@interface DSMenu : UIView <UICollectionViewDelegate, UICollectionViewDataSource>

@property BOOL isShown;
@property(nonatomic) NSObject <DSMenuViewDelegate> *delegate;

-(void)registerNib:(UINib *)nib withReuseIdentifier:(NSString *)reuseIdentifier;
-(void)setColumns:(int)columns;
-(void)setMenuItemHeight:(int)height;
-(void)reloadData;
@end

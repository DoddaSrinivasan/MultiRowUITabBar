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
    -(void)selectTab:(int)index;

    -(NSInteger)numberOfMenuItems;
    -(void)setMenuItem:(DSMenuItem *)menuItem forIndex:(NSUInteger)index;
@end

IB_DESIGNABLE
@interface DSMenu : UIView <UICollectionViewDelegate, UICollectionViewDataSource>

@property (assign) int selectedIndex;
@property (strong, nonatomic) IBInspectable UIColor *overlayColor;
@property (strong, nonatomic) IBInspectable UIColor *menuBackgroundColor;
@property (strong, nonatomic) IBInspectable UIColor *selectedBackgroundColor;
@property (strong, nonatomic) IBInspectable UIColor *selectedTint;
@property (strong, nonatomic) IBInspectable UIColor *normalTint;
@property (strong, nonatomic) IBInspectable NSString *closeText;

@property BOOL isShown;
@property(nonatomic) NSObject <DSMenuViewDelegate> *delegate;

-(void)registerNib:(UINib *)nib withReuseIdentifier:(NSString *)reuseIdentifier;
-(void)setColumns:(int)columns;
-(void)setMenuItemHeight:(int)height;
-(void)reloadData;

-(void)showMenu:(CGRect)frame;
-(void)hideMenuByChangingIndex:(BOOL)shouldChange;

@end

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
    -(UIColor *)menuItemColor;
    -(UIColor *)menuSelectedItemColor;
    -(NSString *)closeButtonText;
    -(NSInteger)numberOfMenuItems;
    -(void)setMenuItem:(DSMenuItem *)menuItem forIndex:(NSUInteger)index;
@end


@interface DSMenu : UIView <UICollectionViewDelegate, UICollectionViewDataSource>

@property (strong, nonatomic) UIColor *menuItemBackGroundColor;
@property (strong, nonatomic) UIColor *menuItemSelectdBackGroundColor;
@property int columns;
@property int menuItemHeight;

- (IBAction)clickedOut:(id)sender;
- (IBAction)closeMenu:(id)sender;

@property (weak, nonatomic) IBOutlet UICollectionView *menuCollectionView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintMenuHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintCloseWidth;
@property (weak, nonatomic) IBOutlet UIView *viewShadow;

@property BOOL isShown;
@property int selectedIndex;

@property(nonatomic) NSObject <DSMenuViewDelegate> *delegate;

@end

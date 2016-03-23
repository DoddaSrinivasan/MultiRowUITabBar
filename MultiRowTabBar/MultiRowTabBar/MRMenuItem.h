//
//  BLRMenuItem.h
//  BLR Airport
//
//  Created by Srinivasan Dodda on 15/03/16.
//  Copyright © 2016 Thoughtworks. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MRMenuItem : UICollectionViewCell

@property (strong, nonatomic) UIColor *menuItemBackGroundColor;

@property (strong, nonatomic) UIColor *menuItemSelectdBackGroundColor;

@property (strong, nonatomic) NSString *closeButtonText;

@property (weak, nonatomic) IBOutlet UIImageView *imgMenuItem;
@property (weak, nonatomic) IBOutlet UILabel *uiLblMenuItem;

-(void)initWith:(NSDictionary *)menuItem;

@end

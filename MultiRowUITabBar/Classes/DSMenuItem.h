//
//  BLRMenuItem.h
//  BLR Airport
//
//  Created by Srinivasan Dodda on 15/03/16.
//  Copyright © 2016 Thoughtworks. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DSMenuItem : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imgMenuItem;
@property (weak, nonatomic) IBOutlet UILabel *uiLblMenuItem;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintLabelBottom;
@property (weak, nonatomic) IBOutlet UIView *bottomDivider;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintImageHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintImageBottom;

@end

//
//  DSMenuTheme.h
//  Pods
//
//  Created by Srinivasan Dodda on 23/01/17.
//
//

#import <UIKit/UIKit.h>

@interface DSMenuTheme : NSObject

@property (assign) NSInteger noOfTabsInRowForIPhone;
@property (assign) NSInteger noOfTabsInRowForIPad;
@property (assign) CGFloat menuItemHeight;

@property (strong, nonatomic) UIColor *tintColor;
@property (strong, nonatomic) UIColor *selectedTintColor;

@property (strong, nonatomic) UIColor *menuBackgroundColor;

@property (strong, nonatomic) UIColor *menuItemBackgroundColor;
@property (strong, nonatomic) UIColor *menuItemSelectedBackgroundColor;

@property (strong, nonatomic) UIFont *normalFont;
@property (strong, nonatomic) UIFont *selectedFont;

@property (strong, nonatomic) UIColor *textColor;
@property (strong, nonatomic) UIColor *selectedTextColor;

@property (strong, nonatomic) UIColor *overlayColor;
@property (strong, nonatomic) NSString *closeText;

@end

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

@property (strong, nonatomic) UIColor *menuBackgroundColor;

@property (strong, nonatomic) UIColor *menuItemBackgroundColor;
@property (strong, nonatomic) UIColor *menuItemSelectedBackgroundColor;

@property (strong, nonatomic) UIColor *overlayColor;
@property (strong, nonatomic) NSString *closeText;
@property (strong, nonatomic) NSString *menuText;


-(UIColor *)tintColor;
-(UIColor *)selectedTintColor;

-(UIFont *)normalFont;
-(UIFont *)selectedFont;

-(UIColor *)textColor;
-(UIColor *)selectedTextColor;

@end

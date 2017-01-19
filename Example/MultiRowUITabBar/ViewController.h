//
//  ViewController.h
//  MultiRowUITabBar
//
//  Created by Srinivasan Dodda on 19/01/17.
//  Copyright © 2017 Dodda Srinivasan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

+(ViewController *)controller;

-(void)initLabel:(NSString *)title;

@property (weak, nonatomic) IBOutlet UILabel *lblTitle;

@end

//
//  ViewController.m
//  MultiRowUITabBar
//
//  Created by Srinivasan Dodda on 19/01/17.
//  Copyright © 2017 Dodda Srinivasan. All rights reserved.
//

#import "ViewController.h"

@interface ViewController (){
    NSString *_vcName;
}

@end

@implementation ViewController

+(ViewController *)controller{
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    ViewController *controller = (ViewController *)[storyBoard instantiateViewControllerWithIdentifier:@"ViewController"];
    return controller;
}

-(void)viewDidLoad{
    [super viewDidLoad];
    _lblTitle.text = _vcName;
}

-(void)initLabel:(NSString *)title{
    _vcName = [NSString stringWithString:title];
}

@end

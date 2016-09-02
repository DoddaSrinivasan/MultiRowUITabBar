//
//  MultiRowTabBarController.m
//  MultiRowTabBar
//
//  Created by Srinivasan Dodda on 22/03/16.
//  Copyright © 2016 Srinivasan Dodda. All rights reserved.
//

#import "DSMultiRowTabBarController.h"
#define IDIOM    UI_USER_INTERFACE_IDIOM()
#define IPAD     UIUserInterfaceIdiomPad

@interface DSMultiRowTabBarController ()

@property (strong, nonatomic) DSMenu *menu;
@property (nonatomic) NSUInteger shouldSelectIndex;

@end

@implementation DSMultiRowTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupDefaults];
    [self setDelegate:self];
    [self setupMenu];
}

-(void)setupDefaults{
    self.menuBackGroundColor = [UIColor whiteColor];
    self.menuOverLayBackGroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.6];
    self.menuItemBackGroundColor = [UIColor whiteColor];
    self.menuItemSelectdBackGroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:0.0 alpha:0.5];
    self.closeButtonText = @"LESS";
    self.moreButtonText = @"MORE";
    self.noOfTabsInRowForIPhone = 5;
    self.noOfTabsInRowForIPad = 8;
    self.menuItemHeight = 55;
}

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{
    if(self.viewControllers.count <= [self numberOfTabsPerRow]){
        return YES;
    }
    if (viewController == [self.viewControllers objectAtIndex:([self numberOfTabsPerRow]-1)] && !self.menu.isShown)
    {
        [self showMenu];
        return NO;
    }
    [self hideMenu];
    return YES;
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    int index = (int)[self.viewControllers indexOfObject:viewController];
    if(index < ([self numberOfTabsPerRow] - 1)){
        [self syncMenu];
    }
}


#pragma mark - menu methods
-(void)setupMenu {
    self.menu = [[[NSBundle mainBundle] loadNibNamed:@"DSMenu" owner:self options:nil] objectAtIndex:0];
    [self.menu.menuCollectionView registerNib:[UINib nibWithNibName:@"DSMenuItem" bundle:nil] forCellWithReuseIdentifier:@"DSMenuItem"];
    
    //Add code to set up menu items in expandable menu
    [self.menu setBackgroundColor:[self menuOverLayBackGroundColor]];
    [self.menu.menuCollectionView setBackgroundColor:[self menuBackGroundColor]];
    self.menu.columns = [self numberOfTabsPerRow];
    self.menu.menuItemHeight = [self menuItemheight];
    
    self.menu.delegate = self;
    self.menu.hidden = YES;
    [self syncMenu];
    
    float columns = (self.viewControllers.count+1)/(float)[self numberOfTabsPerRow];
    columns = columns > (int)columns ? (int)columns + 1 : columns;
    self.menu.constraintMenuHeight.constant = columns*[self menuItemheight];
    CGRect frame = self.view.frame;
    frame.size.height = 0;
    self.menu.frame = frame;
    [self.menu removeFromSuperview];
    [self.view addSubview:self.menu];
}

-(void)showMenu{
    self.menu.frame = self.view.frame;
    self.menu.hidden = NO;
    [self.menu.menuCollectionView reloadData];
}

-(void)hideMenu{
    self.menu.hidden = YES;
    CGRect frame = self.view.frame;
    frame.size.height = 0;
    self.menu.frame = frame;
}

-(void)selectTab:(int)index{
    if(index >= [self numberOfTabsPerRow]){
        NSMutableArray *existingViewControllers = [[self viewControllers] mutableCopy];
        [existingViewControllers replaceObjectAtIndex:([self numberOfTabsPerRow] - 1) withObject:[self.viewControllers objectAtIndex:index]];
        [self setViewControllers:existingViewControllers animated:NO];
        self.selectedIndex = [self numberOfTabsPerRow] -1;
    }else{
        self.selectedIndex = index;
    }
    self.shouldSelectIndex = index;
    [self syncMenu];
    [self hideMenu];
}


-(void)syncMenu{
    self.menu.selectedIndex = (int)self.shouldSelectIndex;
    [self.menu.menuCollectionView reloadData];
}

#pragma mark - UI Configurable methods

-(UIColor *)menuItemColor{
    return self.menuItemBackGroundColor;
}

-(UIColor *)menuSelectedItemColor{
    return self.menuItemSelectdBackGroundColor;
}

-(NSString *)closeButtonText{
    return self.closeButtonText;
}

-(UIColor *)menuBackGroundColor{
    return self.menuBackGroundColor;
}

-(UIColor *)menuOverLayBackGroundColor{
    return self.menuOverLayBackGroundColor;
}

-(UIColor *)menuItemSelectdBackGroundColor{
    return self.menuItemSelectdBackGroundColor;
}

-(UIColor *)menuItemBackGroundColor{
    return self.menuItemBackGroundColor;
}

-(NSString *)moreButtontext{
    return self.moreButtonText;
}

-(int)numberOfTabsPerRow{
    if(IDIOM == IPAD){
        return (int)self.noOfTabsInRowForIPad > 8 ? 8 : (int)self.noOfTabsInRowForIPad;
    }
    return (int)self.noOfTabsInRowForIPhone > 5 ? 5 : (int)self.noOfTabsInRowForIPhone;
}

-(int)menuItemheight{
    return (int)self.menuItemHeight;
}

-(int)maxTabsForDevice{
    if(IDIOM == IPAD){
        return 8;
    }
    return 5;
}

@end

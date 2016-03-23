//
//  MultiRowTabBarController.m
//  MultiRowTabBar
//
//  Created by Srinivasan Dodda on 22/03/16.
//  Copyright © 2016 Srinivasan Dodda. All rights reserved.
//

#import "MultiRowTabBarController.h"
#define IDIOM    UI_USER_INTERFACE_IDIOM()
#define IPAD     UIUserInterfaceIdiomPad

@interface MultiRowTabBarController ()

@property (strong, nonatomic) MRMenu *menu;
@property (nonatomic) NSUInteger shouldSelectIndex;
@property (strong, nonatomic) NSArray *menuItems;

@end

@implementation MultiRowTabBarController

-(id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    self.menuBackGroundColor = [UIColor whiteColor];
    self.menuOverLayBackGroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.6];
    self.menuItemBackGroundColor = [UIColor whiteColor];
    self.menuItemSelectdBackGroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:0.0 alpha:0.5];
    self.closeButtonText = @"LESS";
    self.moreButtonText = @"MORE";
    self.noOfTabsInRowForIPhone = 5;
    self.noOfTabsInRowForIPad = 8;
    self.menuItemHeight = 55;
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)setUpTabBarForIndex:(int)index{
    self.menuItems = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle]
                                                             pathForResource:@"TabBarItems"
                                                             ofType:@"plist"]];
    
    [self setViewControllers:[self controllersForIndex:index]];
}

- (NSArray *)controllersForIndex:(int)index{
    NSMutableArray *controllers = [[NSMutableArray alloc] init];
    int maxIndex = self.menuItems.count > [self getNumberOfTabs] ? [self getNumberOfTabs] : (int)self.menuItems.count;
    for (int i =0; i < maxIndex; i++) {
        UITabBarItem *tabBarItem = [self getTabBarItem:i];
        UIViewController *navViewController;
        if(i < ([self getNumberOfTabs] - 1)){
            navViewController = [self getControllerFor:i];
        }
        
        if(i == ([self getNumberOfTabs] - 1)){
            if(index >= ([self getNumberOfTabs] - 1)){
                navViewController = [self getControllerFor:index];
            }else{
                navViewController = [self getControllerFor:i];
            }
        }
        
        navViewController.tabBarItem = tabBarItem;
        [controllers addObject:navViewController];
    }
    return controllers;
}

- (UITabBarItem *)getTabBarItem:(int)index {
    NSDictionary *tabBarItemDetails = [self.menuItems objectAtIndex:index];
    NSString *tabBarItemTitle = tabBarItemDetails[@"name"];
    if(index >= ([self getNumberOfTabs]-1) && self.menuItems.count > [self getNumberOfTabs]){
        tabBarItemTitle = [self getMoreButtontext];
    }
    UITabBarItem *tabBarItem = [[UITabBarItem alloc] initWithTitle:tabBarItemTitle
                                                             image:[UIImage imageNamed:tabBarItemDetails[@"icon"]]
                                                               tag:0];
    tabBarItem.image = [tabBarItem.image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    return tabBarItem;
}

- (UIViewController *)getControllerForTabBarItem:(NSDictionary *)tabBarItemDetails {
    NSString *storyboardName = tabBarItemDetails[@"storyboardName"];
    NSString *controllerId = tabBarItemDetails[@"controllerId"];
    UIViewController *viewController = [self viewControllerInStoryboard:storyboardName withId:controllerId];
    return viewController;
}

-(UIViewController *)getControllerFor:(int)index{
    UIViewController *viewController = [self getControllerForTabBarItem:[self.menuItems objectAtIndex:index]];
    viewController.tabBarItem = [self getTabBarItem:index];
    return viewController;
}

-(UIViewController *)viewControllerInStoryboard:(NSString *)storyboardname withId:(NSString *)controllerId{
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:storyboardname bundle:[NSBundle mainBundle]];
    return [storyBoard instantiateViewControllerWithIdentifier:controllerId];
}

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{
    if(self.menuItems.count <= [self getNumberOfTabs]){
        return YES;
    }
    if (viewController == [self.viewControllers objectAtIndex:([self getNumberOfTabs]-1)] && !self.menu.isShown)
    {
        [self showMenu];
        return NO;
    }
    [self hideMenu];
    return YES;
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    int index = (int)[self.viewControllers indexOfObject:viewController];
    if(index < ([self getNumberOfTabs] - 1)){
        [self syncMenu];
    }
}


#pragma mark - menu methods
-(void)setupMenu {
    
    self.menu = [[[NSBundle mainBundle] loadNibNamed:@"MRMenu" owner:self options:nil] objectAtIndex:0];
    [self.menu.menuCollectionView registerNib:[UINib nibWithNibName:@"MRMenuItem" bundle:nil] forCellWithReuseIdentifier:@"MRMenuItem"];
    
    self.menu.menuItems = self.menuItems;
    [self.menu setBackgroundColor:[self getMenuOverLayBackGroundColor]];
    [self.menu.menuCollectionView setBackgroundColor:[self getMenuBackGroundColor]];
    self.menu.columns = [self getNumberOfTabs];
    self.menu.menuItemHeight = [self getMenuItemheight];
    
    self.menu.delegate = self;
    self.menu.hidden = YES;
    [self syncMenu];
    
    float columns = (self.menuItems.count+1)/(float)[self getNumberOfTabs];
    columns = columns > (int)columns ? (int)columns + 1 : columns;
    self.menu.constraintMenuHeight.constant = columns*[self getMenuItemheight];
    CGRect frame = self.view.frame;
    frame.size.height = 0;
    self.menu.frame = frame;
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
    if(index >= [self getNumberOfTabs]){
        NSMutableArray *existingViewControllers = [[self viewControllers] mutableCopy];
        [existingViewControllers replaceObjectAtIndex:([self getNumberOfTabs] - 1) withObject:[self getControllerFor:index]];
        [self setViewControllers:existingViewControllers animated:NO];
        self.selectedIndex = [self getNumberOfTabs] -1;
    }else{
        self.selectedIndex = index;
    }
    self.shouldSelectIndex = index;
    [self syncMenu];
    [self hideMenu];
}

-(UIColor *)menuItemColor{
    return self.menuItemBackGroundColor;
}

-(UIColor *)menuSelectedItemColor{
    return self.menuItemSelectdBackGroundColor;
}

-(NSString *)getCloseButtonText{
    return self.closeButtonText;
}

-(void)syncMenu{
    self.menu.selectedIndex = (int)self.shouldSelectIndex;
    [self.menu.menuCollectionView reloadData];
}

#pragma mark - config methods

-(UIColor *)getMenuBackGroundColor{
    return self.menuBackGroundColor;
}

-(UIColor *)getMenuOverLayBackGroundColor{
    return self.menuOverLayBackGroundColor;
}

-(UIColor *)getMenuItemSelectdBackGroundColor{
    return self.menuItemSelectdBackGroundColor;
}

-(UIColor *)getMenuItemBackGroundColor{
    return self.menuItemBackGroundColor;
}

-(NSString *)getMoreButtontext{
    return self.moreButtonText;
}

-(int)getNumberOfTabs{
    if(IDIOM == IPAD){
        return (int)self.noOfTabsInRowForIPad > 8 ? 8 : (int)self.noOfTabsInRowForIPad;
    }
    return (int)self.noOfTabsInRowForIPhone > 5 ? 5 : (int)self.noOfTabsInRowForIPhone;
}

-(int)getMenuItemheight{
    return (int)self.menuItemHeight;
}

-(int)maxTabsForDevice{
    if(IDIOM == IPAD){
        return 8;
    }
    return 5;
}

@end

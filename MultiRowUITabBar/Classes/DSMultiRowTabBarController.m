//
//  MultiRowTabBarController.m
//  MultiRowTabBar
//
//  Created by Srinivasan Dodda on 22/03/16.
//  Copyright © 2016 Srinivasan Dodda. All rights reserved.
//

#import "DSMultiRowTabBarController.h"
#import "DSMenuTheme.h"

#define IDIOM  UI_USER_INTERFACE_IDIOM()
#define IPAD   UIUserInterfaceIdiomPad

@interface DSMultiRowTabBarController ()

@property (strong, nonatomic) DSMenu *menu;

@end

@implementation DSMultiRowTabBarController

#pragma mark - Initial Set up

- (id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    [self setDefaults];
    return self;
}

- (id)init{
    self = [super init];
    [self setDefaults];
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setDelegate:self];
    [self setupMenu];
}

- (void)setDefaults{
    self.theme = [[DSMenuTheme alloc] init];
}

#pragma mark - TabBar Setup and delegate methods

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{
    if(self.numberOfMenuItems <= [self numberOfTabsPerRow]){
        return YES;
    }
    
    if (!self.menu.isShown && viewController == [self.viewControllers objectAtIndex:([self numberOfTabsPerRow]-1)])
    {
        [self showMenu];
        return NO;
    }
    
    return YES;
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    int index = (int)[self.viewControllers indexOfObject:viewController];
    if(index < ([self numberOfTabsPerRow] - 1)){
        [self syncMenu];
    }
}

#pragma mark - TabBar setup methods

-(void)setupTabBar{
    NSMutableArray<UIViewController *> *viewControllers = [[NSMutableArray alloc] init];
    for(int i=0; i < self.numberOfTabsPerRow; i++){
        UIViewController *viewController = [self viewControllerForIndex:i];
        
        UITabBarItem *tabBarItem = [self tabBarItemForIndex:i];
        tabBarItem.image = [tabBarItem.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        
        if(i+1 == self.numberOfTabsPerRow){
            tabBarItem.title = _theme.menuText;
            tabBarItem.image = nil;
        }
        viewController.tabBarItem = tabBarItem;
        
        [viewControllers addObject:viewController];
    }
    [self setViewControllers:viewControllers];
    [self reloadMenuItems];
}

-(UITabBarItem *)tabBarItemForIndex:(NSUInteger)index{
    [self doesNotRecognizeSelector:_cmd];
    [NSException raise:NSInternalInconsistencyException
                format:@"You must override %@ in a subclass", NSStringFromSelector(_cmd)];
    return nil;
}

-(UIViewController *)viewControllerForIndex:(NSUInteger)index{
    [self doesNotRecognizeSelector:_cmd];
    [NSException raise:NSInternalInconsistencyException
                format:@"You must override %@ in a subclass", NSStringFromSelector(_cmd)];
    return nil;
}

#pragma mark - Menu methods

-(void)setupMenu {
    NSString *bundlePath = [[NSBundle bundleForClass:[DSMultiRowTabBarController class]] pathForResource:@"MultiRowUITabBar" ofType:@"bundle"];
    NSBundle *bundle = [NSBundle bundleWithPath:bundlePath];
    self.menu = [[bundle loadNibNamed:@"DSMenu" owner:self options:nil] objectAtIndex:0];
    self.menu.theme = _theme;
    [self.menu registerNib:[UINib nibWithNibName:@"DSMenuItem" bundle:bundle] withReuseIdentifier:@"DSMenuItem"];

    self.menu.delegate = self;
    self.menu.hidden = YES;
    
    [self.menu removeFromSuperview];
    [self.view addSubview:self.menu];
    
    [self reloadMenuItems];
}

-(void)reloadMenuItems{
    float columns = (self.numberOfMenuItems+1)/(float)[self numberOfTabsPerRow];
    columns = columns > (int)columns ? (int)columns + 1 : columns;
    
    [self.menu setColumns:[self numberOfTabsPerRow]];
    [self.menu setMenuItemHeight:_theme.menuItemHeight];
    [self syncMenu];
    
    CGRect frame = self.view.frame;
    frame.size.height = 0;
    self.menu.frame = frame;
}

-(void)showMenu{
    if(self.selectedIndex < self.numberOfTabsPerRow){
        self.menu.selectedIndex = self.selectedIndex;
    }
    [self syncMenu];
    [self.menu showMenu:self.view.frame];
}

-(void)syncMenu{
    [self.menu reloadMenu];
}

#pragma mark - Menu Delegate Methods

-(void)selectTab:(int)index{
    if(index >= [self numberOfTabsPerRow]-1){
        NSMutableArray *existingViewControllers = [[self viewControllers] mutableCopy];
        
        UIViewController *lastViewController = [existingViewControllers lastObject];
        UIViewController *controllerToReplace = [self viewControllerForIndex:index];
        controllerToReplace.tabBarItem = lastViewController.tabBarItem;
        
        [existingViewControllers replaceObjectAtIndex:([self numberOfTabsPerRow] - 1)
                                           withObject:controllerToReplace];
        
        [self setViewControllers:existingViewControllers animated:NO];
        self.selectedIndex = [self numberOfTabsPerRow] -1;
    }else{
        self.selectedIndex = index;
    }
}

-(NSInteger)numberOfMenuItems{
    [self doesNotRecognizeSelector:_cmd];
    [NSException raise:NSInternalInconsistencyException
                format:@"You must override %@ in a subclass", NSStringFromSelector(_cmd)];
    return 0;
}

-(void)setMenuItem:(DSMenuItem *)menuItem forIndex:(NSUInteger)index{
    [self doesNotRecognizeSelector:_cmd];
    [NSException raise:NSInternalInconsistencyException
                format:@"You must override %@ in a subclass", NSStringFromSelector(_cmd)];
}

#pragma mark - Utils

-(int)numberOfTabsPerRow{
    if(IDIOM == IPAD){
        return _theme.noOfTabsInRowForIPad > self.maxTabsForDevice ? self.maxTabsForDevice : _theme.noOfTabsInRowForIPad;
    }
    return _theme.noOfTabsInRowForIPhone > self.maxTabsForDevice ? self.maxTabsForDevice : _theme.noOfTabsInRowForIPhone;
}

-(int)maxTabsForDevice{
    if(IDIOM == IPAD){
        return 8;
    }
    return 5;
}

#pragma mark - Theme Methods

- (void)setTheme:(DSMenuTheme *)theme{
    _theme = theme;
    [self.menu setTheme:theme];
    [self reloadMenuItems];
}

@end

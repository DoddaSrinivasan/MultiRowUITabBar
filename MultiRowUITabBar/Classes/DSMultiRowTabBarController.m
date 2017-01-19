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

@end

@implementation DSMultiRowTabBarController

#pragma mark - Initial Set up

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupDefaults];
    [self setDelegate:self];
    [self setupMenu];
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
    
    [self hideMenu];
    
    return YES;
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    int index = (int)[self.viewControllers indexOfObject:viewController];
    if(index < ([self numberOfTabsPerRow] - 1)){
        [self syncMenu];
    }
}

-(void)setupTabBar{
    NSMutableArray<UIViewController *> *viewControllers = [[NSMutableArray alloc] init];
    for(int i=0; i < self.numberOfTabsPerRow; i++){
        UIViewController *viewController = [self viewControllerForIndex:i];
        UITabBarItem *tabBarItem = [self tabBarItemForIndex:i];
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
    [self.menu setMenuItemHeight:[self menuItemheight]];
    [self syncMenu];
    
    CGRect frame = self.view.frame;
    frame.size.height = 0;
    self.menu.frame = frame;
}

-(void)showMenu{
    self.menu.frame = self.view.frame;
    self.menu.hidden = NO;
    [self.menu reloadData];
}

-(void)syncMenu{
    [self.menu reloadData];
}

#pragma mark - Menu Delegate Methods

-(void)hideMenu{
    self.menu.hidden = YES;
    CGRect frame = self.view.frame;
    frame.size.height = 0;
    self.menu.frame = frame;
}

-(void)selectTab:(int)index{
    if(index > [self numberOfTabsPerRow]){
        NSMutableArray *existingViewControllers = [[self viewControllers] mutableCopy];
        [existingViewControllers replaceObjectAtIndex:([self numberOfTabsPerRow] - 1) withObject:[self viewControllerForIndex:index]];
        [self setViewControllers:existingViewControllers animated:NO];
        self.selectedIndex = [self numberOfTabsPerRow] -1;
    }else{
        self.selectedIndex = index;
    }
    [self syncMenu];
    [self hideMenu];
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

-(void)setupDefaults{
    self.noOfTabsInRowForIPhone = 5;
    self.noOfTabsInRowForIPad = 8;
    self.menuItemHeight = 55;
}

@end

# MultiRowUITabBar
Custom UITabBarController for iOS. Provides multiple rows of tab bar items on click of "More".

iOS provides "more" button when the number of tab items are more than 5 (8 for iPad). Once you go a level deep in the more section, we cant see all the available tab items. 

This custom UITabBarController provides a elegent way of showing all the tab items in a multi row view, letting the user to switch between any screen any time.

##Features

- Universal device support (iPhone + iPad)
- Multiple Storyboard support
- Easily stylable
- Nice set of configuration options
- Lightweight, simple and readable code.


![](http://res.cloudinary.com/dm6lqaxjt/image/upload/v1485178860/MultiRow_TabBar.gif)

##Demo

1. Git clone or download the project.
2. Go to Example directory and run pod install.
3. Open the MultiRowUITabBar.xcworkspace in xCode.
4. Run the xCode project

##Installation

####Manual Installation

1. Download the zip
2. Add the files under MultiRowTabBar into your project.
3. Extend your UITabBarController from MultiRowTabBarController

##Usage

#####Basic Setup

Subclass your TabBarController with DSMultiRowTabBarController. Call ```[self setupTabBar]``` in ``` viewDidLoad``` and override the following methods.

```
-(NSUInteger)numberOfMenuItems;
-(void)setMenuItem:(DSMenuItem *)menuItem forIndex:(NSUInteger)index;

-(UITabBarItem *)tabBarItemForIndex:(NSUInteger)index;
-(UIViewController *)viewControllerForIndex:(NSUInteger)index;
```

# Currently Re-Architecting this repo and adding CocoaPods support. Check back for updates.

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


![](http://res.cloudinary.com/dm6lqaxjt/image/upload/v1458745277/MultiRow_Default_Columns_n4i2mc.gif)  &nbsp;&nbsp;&nbsp;  ![](http://res.cloudinary.com/dm6lqaxjt/image/upload/v1458745277/MultiRow_custom_columns_zbhcmp.gif)


##Installation

####Manual Installation

1. Download the zip
2. Add the files under MultiRowTabBar into your project.
3. Extend your UITabBarController from MultiRowTabBarController

##Usage

#####Basic Setup

In your TabBarItems.plist, add an entry for each of the view controller you want to show up in tabs:<br />
controllerId -> storyboardId for that controller <br />

```plist
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
  <array>
  	<dict>
      <key>name</key>
      <string>vc1</string>
      <key>icon</key>
      <string>nothing</string>
      <key>storyboardName</key>
      <string>Main</string>
      <key>controllerId</key>
      <string>vc1</string>
    </dict>
    <dict>
      <key>name</key>
      <string>vc2</string>
      <key>icon</key>
      <string>nothing</string>
      <key>storyboardName</key>
      <string>Main</string>
      <key>controllerId</key>
      <string>vc2</string>
    </dict>
  </array>
</plist>
```

In your UITabBarController:<br />
```objective-c

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setDelegate:self];
    [self setUpTabBarForIndex:0]; //index of the tab you want to be selected
    [self setupMenu];
}
```

#####Advanced Setup
In your UITabBarController:<br />
```objective-c

- (void)viewDidLoad {
    [super viewDidLoad];

    self.menuBackGroundColor = [UIColor whiteColor];
    self.menuOverLayBackGroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.6];
    self.menuItemBackGroundColor = [UIColor whiteColor];
    self.menuItemSelectdBackGroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:0.0 alpha:0.5];
    self.closeButtonText = @"LESS";
    self.moreButtonText = @"MORE";
    self.noOfTabsInRowForIPhone = 3;
    self.noOfTabsInRowForIPad = 5;
    self.menuItemHeight = 60;

    [self setDelegate:self];
    [self setUpTabBarForIndex:0]; //index of the tab you want to be selected
    [self setupMenu];
}
```

You can also customize the MRMenu.xib and MRMenuItem.xib for the styling, but dont mess with the outlets

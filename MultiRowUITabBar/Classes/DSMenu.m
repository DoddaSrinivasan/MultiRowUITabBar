//
//  MRMenu.m
//
//  Created by Srinivasan Dodda on 15/03/16.
//

#import "DSMenu.h"
#import "DSMenuItem.h"
#import "MenuAnimationFlowLayout.h"

#define SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height

@interface DSMenu(){
    MenuAnimationFlowLayout *animatedFlowLayout;
}

@property int columns;
@property int menuItemHeight;

@property (weak, nonatomic) IBOutlet UIButton *overlay;
@property (weak, nonatomic) IBOutlet UILabel *lblclose;
@property (weak, nonatomic) IBOutlet UIView *viewClose;


@property (weak, nonatomic) IBOutlet UICollectionView *menuCollectionView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintMenuHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintCloseWidth;
@property (weak, nonatomic) IBOutlet UIView *viewShadow;

-(IBAction)clickedOut:(id)sender;
-(IBAction)closeMenu:(id)sender;

@end

@implementation DSMenu

- (id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    [self setDefaults];
    return self;
}

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    [self setDefaults];
    return self;
}

- (id)init{
    self = [super init];
    [self setDefaults];
    return self;
}

-(void)drawRect:(CGRect)rect{
    self.overlay.backgroundColor = _overlayColor;
    self.menuCollectionView.backgroundColor = _menuBackgroundColor;
    self.viewClose.backgroundColor = _menuBackgroundColor;
    self.lblclose.text = _closeText;
}

#pragma mark - UI set up methods

-(void)setDefaults{
    animatedFlowLayout = [[MenuAnimationFlowLayout alloc] init];
    _overlayColor = [UIColor colorWithWhite:0 alpha:0.5];
    _menuBackgroundColor = [UIColor whiteColor];
    _selectedTint = [UIColor redColor];
    _normalTint = [UIColor grayColor];
    _selectedBackgroundColor = [UIColor colorWithWhite:0 alpha:0.2];
    _closeText = @"CLOSE";
}

#pragma mark - UI utils
-(void)updateShadow{
    self.constraintCloseWidth.constant = SCREEN_WIDTH/(float)self.columns;
    self.viewShadow.layer.shadowColor = [UIColor grayColor].CGColor;
    self.viewShadow.layer.shadowOffset = CGSizeMake(0, -3);
    self.viewShadow.layer.shadowOpacity = 0.5;
    self.viewShadow.layer.shadowRadius = 1.0;
}

-(void)setColumns:(int)columns{
    _columns = columns;
    int requiredRows = ceilf(([_delegate numberOfMenuItems]+1)/(CGFloat)columns);
    self.constraintMenuHeight.constant = requiredRows*_menuItemHeight;
    [self setMenuAnimationConfig];
}

-(void)setMenuItemHeight:(int)height{
    _menuItemHeight = height;
    int requiredRows = ceilf(([_delegate numberOfMenuItems]+1)/(CGFloat)_columns);
    self.constraintMenuHeight.constant = requiredRows*height;
    [self setMenuAnimationConfig];
}

-(void)setMenuAnimationConfig{
    animatedFlowLayout.cellHeight = _menuItemHeight;
    animatedFlowLayout.maxColumns = _columns;
    [self.menuCollectionView setCollectionViewLayout:animatedFlowLayout animated:YES];
    [animatedFlowLayout invalidateLayout];
}

#pragma mark - Click Handlers
- (IBAction)clickedOut:(id)sender {
    [self hideMenu];
}

- (IBAction)closeMenu:(id)sender {
    [self hideMenu];
}

#pragma mark - UICollectionView methods.

-(void)reloadData{
    [self.menuCollectionView reloadData];
}

-(void)registerNib:(UINib *)nib withReuseIdentifier:(NSString *)reuseIdentifier{
    [self.menuCollectionView registerNib:nib forCellWithReuseIdentifier:reuseIdentifier];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    [self updateShadow];
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [_delegate numberOfMenuItems];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    DSMenuItem *menuCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"DSMenuItem"
                                                                     forIndexPath:indexPath];
    menuCell.uiLblMenuItem.textColor = _selectedIndex == (int)indexPath.row ? _selectedTint : _normalTint;
    
    [_delegate setMenuItem:menuCell forIndex:indexPath.row];
    
    menuCell.imgMenuItem.image = [menuCell.imgMenuItem.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [menuCell.imgMenuItem setTintColor:_selectedIndex == (int)indexPath.row ? _selectedTint : _normalTint];
    
    return menuCell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if(self.delegate && [self.delegate respondsToSelector:@selector(selectTab:)]){
        [self.delegate selectTab:(int)indexPath.row];
        _selectedIndex = (int)indexPath.row;
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat menuItemWidth = [[UIScreen mainScreen] bounds].size.width/(float)self.columns;
    return CGSizeMake(menuItemWidth, self.menuItemHeight);
}

#pragma mark - Show & Hide Menu

-(void)showMenu:(CGRect)frame{
    self.frame = frame;
    self.hidden = NO;
    [self reloadData];
}

-(void)hideMenu{
    self.hidden = YES;
}

@end

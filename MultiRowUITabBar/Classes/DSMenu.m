//
//  MRMenu.m
//
//  Created by Srinivasan Dodda on 15/03/16.
//

#import "DSMenu.h"
#import "DSMenuTheme.h"
#import "DSMenuItem.h"
#import "MenuAnimationFlowLayout.h"


@interface DSMenu(){
    MenuAnimationFlowLayout *animatedFlowLayout;
    NSMutableArray *animatableMenuItems;
    int speedFactor;
}

@property int columns;
@property int menuItemHeight;

@property (weak, nonatomic) IBOutlet UIButton *overlay;
@property (weak, nonatomic) IBOutlet UILabel *lblclose;
@property (weak, nonatomic) IBOutlet UIView *viewClose;

@property (weak, nonatomic) IBOutlet UICollectionView *menuCollectionView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintMenuHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintCloseWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintCollectionViewBgHeight;

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

- (void)setTheme:(DSMenuTheme *)theme{
    _theme = theme;
    self.overlay.backgroundColor = _theme.overlayColor;
    self.menuCollectionView.backgroundColor = [UIColor clearColor];
    self.viewClose.backgroundColor = _theme.menuBackgroundColor;
    self.lblclose.text = _theme.closeText;
}

#pragma mark - UI set up methods

- (void)setDefaults{
    speedFactor = 1.5;
    
    animatableMenuItems = [[NSMutableArray alloc] init];
    
    animatedFlowLayout = [[MenuAnimationFlowLayout alloc] init];
    animatedFlowLayout.minimumInteritemSpacing = 0.0f;
    animatedFlowLayout.minimumLineSpacing = 0.0f;
    animatedFlowLayout.sectionInset = UIEdgeInsetsMake(0,0,0,0);
    
    _theme = [[DSMenuTheme alloc] init];
}

- (void)setColumns:(int)columns{
    _columns = columns;
    int requiredRows = ceilf(([_delegate numberOfMenuItems]+1)/(CGFloat)columns);
    self.constraintMenuHeight.constant = requiredRows*_menuItemHeight;
    [self setMenuAnimationConfig];
}

- (void)setMenuItemHeight:(int)height{
    _menuItemHeight = height;
    int requiredRows = ceilf(([_delegate numberOfMenuItems]+1)/(CGFloat)_columns);
    self.constraintMenuHeight.constant = requiredRows*height;
    [self setMenuAnimationConfig];
}

#pragma mark - Click Handlers

- (IBAction)clickedOut:(id)sender {
    [self hideMenuByChangingIndex:NO];
}

- (IBAction)closeMenu:(id)sender {
    [self hideMenuByChangingIndex:NO];
}

#pragma mark - UICollectionView methods.

-(void)reloadMenu{
    [self.menuCollectionView reloadData];
}

-(void)registerNib:(UINib *)nib withReuseIdentifier:(NSString *)reuseIdentifier{
    [self.menuCollectionView registerNib:nib forCellWithReuseIdentifier:reuseIdentifier];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return animatableMenuItems.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    DSMenuItem *menuCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"DSMenuItem"
                                                                     forIndexPath:indexPath];
    
    [_delegate setMenuItem:menuCell forIndex:indexPath.row];
    [menuCell styleCellFor:_theme andActive:_selectedIndex == (int)indexPath.row];
    return menuCell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    _selectedIndex = (int)indexPath.row;
    [self hideMenuByChangingIndex:YES];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat menuItemWidth = [[UIScreen mainScreen] bounds].size.width/(float)self.columns;
    return CGSizeMake(menuItemWidth, self.menuItemHeight);
}

#pragma mark - Show & Hide Menu Animation

- (void)setMenuAnimationConfig{
    animatedFlowLayout.cellHeight = _theme.menuItemHeight;
    animatedFlowLayout.maxColumns = _columns;
    [self.menuCollectionView setCollectionViewLayout:animatedFlowLayout animated:YES];
    [animatedFlowLayout invalidateLayout];
}

- (void)showMenu:(CGRect)frame{
    self.frame = frame;
    self.overlay.alpha = 0;
    self.viewClose.alpha = 0;
    self.constraintCollectionViewBgHeight.constant = _menuItemHeight;
    self.constraintCloseWidth.constant = frame.size.width/_columns;
    [self layoutIfNeeded];
    self.hidden = NO;
    
    [self addCells];
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3*speedFactor];
    
    [CATransaction begin];
    [CATransaction setAnimationDuration:0.3*speedFactor];
    [CATransaction setAnimationTimingFunction:[CAMediaTimingFunction functionWithControlPoints:0.00 :1.5 :0.00 :1.0]];
    
    self.constraintCollectionViewBgHeight.constant = self.constraintMenuHeight.constant;
    self.overlay.alpha = 1;
    self.viewClose.alpha = 1;
    [self layoutIfNeeded];
    
    [CATransaction commit];
    [UIView commitAnimations];
}

-(void)addCells{
    for(int i=0; i<self.delegate.numberOfMenuItems; i++){
        [self addCell:i];
    }
}

-(void)addCell:(int)index{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3*speedFactor];
    
    [CATransaction begin];
    [CATransaction setAnimationDuration:0.3*speedFactor];
    
    CGFloat one =   0;
    CGFloat two =   1.8 - 0.10*(index%_columns);
    CGFloat three = 0 + 0.30*(index%_columns);
    CGFloat four =  1;
    
    [CATransaction setAnimationTimingFunction:[CAMediaTimingFunction functionWithControlPoints:one :two :three :four]];
    
    [self.menuCollectionView performBatchUpdates:^{
        [self.menuCollectionView insertItemsAtIndexPaths:@[[NSIndexPath indexPathForItem:index inSection:0]]];
        [animatableMenuItems insertObject:@"" atIndex:index];
    } completion:^(BOOL finished) {
        
    }];
    
    [CATransaction commit];
    [UIView commitAnimations];
}

-(void)hideMenuByChangingIndex:(BOOL)shouldChange{
    [self hideCells];
    
    if(shouldChange && self.delegate && [self.delegate respondsToSelector:@selector(selectTab:)]){
        [self.delegate selectTab:self.selectedIndex];
    }
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3*speedFactor];
    
    [CATransaction begin];
    [CATransaction setAnimationDuration:0.3*speedFactor];
    
    [CATransaction setCompletionBlock:^{
        self.hidden = YES;
    }];
    
    [CATransaction setAnimationTimingFunction:[CAMediaTimingFunction functionWithControlPoints:0 :1.6 :0 :1]];
    
    self.constraintCollectionViewBgHeight.constant = _menuItemHeight;
    self.overlay.alpha = 0;
    self.viewClose.alpha = 0;
    [self layoutIfNeeded];
    
    [CATransaction commit];
    [UIView commitAnimations];
    
}

-(void)hideCells{
    for(int i = (int)_delegate.numberOfMenuItems-1; i >= 0; i--){
        [self hideCell:i];
    }
}

-(void)hideCell:(int)index{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3*speedFactor];
    
    [CATransaction begin];
    [CATransaction setAnimationDuration:0.3*speedFactor];
    
    CGFloat one =   0;
    CGFloat two =   1.6 - 0.10*(_columns - 1 - index%_columns);
    CGFloat three = 0.0 + 0.30*(_columns - 1 - index%_columns);
    CGFloat four =  1;
    
    [CATransaction setAnimationTimingFunction:[CAMediaTimingFunction functionWithControlPoints:one :two :three :four]];
    
    [self.menuCollectionView performBatchUpdates:^{
        [self.menuCollectionView deleteItemsAtIndexPaths:@[[NSIndexPath indexPathForItem:index inSection:0]]];
        [animatableMenuItems removeLastObject];
    } completion:^(BOOL finished) {
        
    }];
    
    [CATransaction commit];
    [UIView commitAnimations];
}

@end

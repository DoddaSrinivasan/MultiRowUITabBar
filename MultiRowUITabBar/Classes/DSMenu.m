//
//  MRMenu.m
//
//  Created by Srinivasan Dodda on 15/03/16.
//

#import "DSMenu.h"
#import "DSMenuItem.h"

#define SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height

@implementation DSMenu

- (IBAction)clickedOut:(id)sender {
    if(self.delegate && [self.delegate respondsToSelector:@selector(hideMenu)]){
        [self.delegate hideMenu];
    }
}

- (IBAction)closeMenu:(id)sender {
    if(self.delegate && [self.delegate respondsToSelector:@selector(hideMenu)]){
        [self.delegate hideMenu];
    }
}

#pragma mark - UICollectionView methods.

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    self.constraintCloseWidth.constant = SCREEN_WIDTH/(float)self.columns;
    self.viewShadow.layer.shadowColor = [UIColor grayColor].CGColor;
    self.viewShadow.layer.shadowOffset = CGSizeMake(0, -3);
    self.viewShadow.layer.shadowOpacity = 0.5;
    self.viewShadow.layer.shadowRadius = 1.0;
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.menuItems.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    DSMenuItem *menuCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MRMenuItem" forIndexPath:indexPath];
    [menuCell initWith:[self.menuItems objectAtIndex:indexPath.row]];
    if(indexPath.row == self.selectedIndex){
        menuCell.backgroundColor = [self.delegate menuSelectedItemColor];
    }else{
        menuCell.backgroundColor = [self.delegate menuItemColor];
    }
    return menuCell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if(self.delegate && [self.delegate respondsToSelector:@selector(selectTab:)]){
        [self.delegate selectTab:(int)indexPath.row];
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat menuItemWidth = SCREEN_WIDTH/(float)self.columns;
    return CGSizeMake(menuItemWidth, self.menuItemHeight);
}

@end

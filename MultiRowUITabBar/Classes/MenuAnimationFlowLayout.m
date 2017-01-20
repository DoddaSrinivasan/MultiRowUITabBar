//
//  MenuAnimationFlowLayout.m
//  Pods
//
//  Created by Srinivasan Dodda on 20/01/17.
//
//

#import "MenuAnimationFlowLayout.h"

@implementation MenuAnimationFlowLayout

- (UICollectionViewLayoutAttributes*)initialLayoutAttributesForAppearingItemAtIndexPath:(NSIndexPath *)itemIndexPath
{
    UICollectionViewLayoutAttributes *attributes = [super initialLayoutAttributesForAppearingItemAtIndexPath:itemIndexPath];
    attributes.center = [self centreForIndexPath:itemIndexPath];
    attributes.alpha = [self alphaFor:itemIndexPath];
    return attributes;
    
}

- (UICollectionViewLayoutAttributes*)finalLayoutAttributesForDisappearingItemAtIndexPath:(NSIndexPath *)itemIndexPath
{
    UICollectionViewLayoutAttributes *attributes = [super finalLayoutAttributesForDisappearingItemAtIndexPath:itemIndexPath];
    attributes.center = [self centreForIndexPath:itemIndexPath];
    attributes.alpha = [self alphaFor:itemIndexPath];
    return attributes;
    
}

-(CGFloat)alphaFor:(NSIndexPath *)indexpath{
    if(indexpath.row < self.maxColumns-1){
        return 1;
    }else{
        return 0.5;
    }
}

-(CGPoint)centreForIndexPath:(NSIndexPath *)indexpath{
    CGPoint centre;
    centre = CGPointMake([self xFor:indexpath], [self yFor:indexpath]);
    return centre;
}

-(CGFloat)xFor:(NSIndexPath *)indexpath{
    CGRect frame = self.collectionView.frame;
    int firstItemCentreX = frame.size.width/(2*self.maxColumns);
    if(indexpath.row < self.maxColumns-1){
        return firstItemCentreX + 2*firstItemCentreX*indexpath.row;
    }else{
        int column = (indexpath.row + 1)%self.maxColumns;
        return firstItemCentreX + 2*firstItemCentreX*column;
    }
}

-(CGFloat)yFor:(NSIndexPath *)indexpath{
    CGRect frame = self.collectionView.frame;
    int firstItemCentreY = frame.size.height - self.cellHeight;
    int row = ((int)indexpath.row+1)/self.maxColumns;
    return firstItemCentreY + row*self.cellHeight;
}

@end

//
//  DJCollectionViewFlowLayout.m
//  DJDemo
//
//  Created by Sky on 2018/7/12.
//  Copyright © 2018年 Sky. All rights reserved.
//

#import "DJCollectionReusableView.h"
#import "DJCollectionViewLayoutAttributes.h"
#import "DJCollectionViewFlowLayout.h"

NSString *const DJCollectionViewSectionBackground = @"DJCollectionViewSectionBackground";

@implementation DJCollectionViewFlowLayout

- (instancetype)init {
    self = [super init];
    if (self) {
        self.decorationViewAttrs = [NSMutableArray array];
        [self setup];
    }
    return self;
}
- (void)setup {
    [self registerClass:[DJCollectionViewLayoutAttributes class] forDecorationViewOfKind:DJCollectionViewSectionBackground];
}
- (void)prepareLayout { //准备布局
    [super prepareLayout];
    [self.decorationViewAttrs removeAllObjects];
    
    NSInteger numberOfSections = [self.collectionView numberOfSections];
    id delegate = self.collectionView.delegate;
    if (!numberOfSections || ![delegate conformsToProtocol:@protocol(DJCollectionViewDelegateFlowLayout)]) {
        return;
    }
    
    for (NSInteger section = 0; section < numberOfSections; section++) {
        NSInteger numberOfItems = [self.collectionView numberOfItemsInSection:section];
        if (numberOfItems <= 0) {
            continue;
        }
        UICollectionViewLayoutAttributes *firstItem = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:section]];
        UICollectionViewLayoutAttributes *lastItem = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:numberOfItems - 1 inSection:section]];
        if (!firstItem || !lastItem) {
            continue;
        }
        
        UIEdgeInsets sectionInset = [self sectionInset];
        
        if ([delegate respondsToSelector:@selector(collectionView:layout:insetForSectionAtIndex:)]) {
            UIEdgeInsets inset = [delegate collectionView:self.collectionView layout:self insetForSectionAtIndex:section];
            sectionInset = inset;
        }
        
        
        CGRect sectionFrame = CGRectUnion(firstItem.frame, lastItem.frame);
        sectionFrame.origin.x -= sectionInset.left;
        sectionFrame.origin.y -= sectionInset.top;
        
        if (self.scrollDirection == UICollectionViewScrollDirectionHorizontal) {
            sectionFrame.size.width += sectionInset.left + sectionInset.right;
            sectionFrame.size.height = self.collectionView.frame.size.height;
        } else {
            sectionFrame.size.width = self.collectionView.frame.size.width;
            sectionFrame.size.height += sectionInset.top + sectionInset.bottom;
        }
        
        // 2、定义
        DJCollectionViewLayoutAttributes *attr = [DJCollectionViewLayoutAttributes layoutAttributesForDecorationViewOfKind:DJCollectionViewSectionBackground withIndexPath:[NSIndexPath indexPathForItem:0 inSection:section]];
        attr.frame = sectionFrame;
        attr.zIndex = -1;
        
        attr.sectionBgColor = [delegate collectionView:self.collectionView layout:self backgroudColorFroSection:section];
        [self.decorationViewAttrs addObject:attr];
    }
    
}
- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSMutableArray *attrs = [[super layoutAttributesForElementsInRect:rect] mutableCopy];
    for (UICollectionViewLayoutAttributes *attr in self.decorationViewAttrs) {
        
        if (CGRectIntersectsRect(rect, attr.frame)) {
            [attrs addObject:attr];
        }
    }
    return attrs;
}
//给每个区的背景视图 设置布局属性
- (UICollectionViewLayoutAttributes *)layoutAttributesForDecorationViewOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath {
    //如果是要设置背景的section背景视图，返回我们计算好的区背景视图布局属性
    if ([elementKind isEqualToString:DJCollectionViewSectionBackground]) {
        return self.decorationViewAttrs[indexPath.section];
    }
    //其他的返回默认的布局熟悉感
    return [super layoutAttributesForDecorationViewOfKind:elementKind atIndexPath:indexPath];
}
@end

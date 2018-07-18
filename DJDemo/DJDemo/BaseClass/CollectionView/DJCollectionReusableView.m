//
//  DJCollectionReusableView.m
//  DJDemo
//
//  Created by Sky on 2018/7/12.
//  Copyright © 2018年 Sky. All rights reserved.
//

#import "DJCollectionReusableView.h"
#import "DJCollectionViewLayoutAttributes.h"
@implementation DJCollectionReusableView

- (void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes {
    [super applyLayoutAttributes:layoutAttributes];
    
    if ([layoutAttributes isKindOfClass:[DJCollectionViewLayoutAttributes class]]) {
        DJCollectionViewLayoutAttributes *attr = (DJCollectionViewLayoutAttributes *)layoutAttributes;
        self.backgroundColor = attr.sectionBgColor;
    }
}
@end

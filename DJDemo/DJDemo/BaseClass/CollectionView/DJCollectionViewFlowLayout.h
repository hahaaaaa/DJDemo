//
//  DJCollectionViewFlowLayout.h
//  DJDemo
//
//  Created by Sky on 2018/7/12.
//  Copyright © 2018年 Sky. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DJCollectionViewDelegateFlowLayout <UICollectionViewDelegateFlowLayout>

- (UIColor *)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout backgroudColorFroSection:(NSInteger)section;

@end

@interface DJCollectionViewFlowLayout : UICollectionViewFlowLayout

@property (strong, nonatomic) NSMutableArray<UICollectionViewLayoutAttributes *> *decorationViewAttrs;

@end

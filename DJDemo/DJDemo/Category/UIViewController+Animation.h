//
//  UIViewController+Animation.h
//  maidu
//
//  Created by 张颖 on 2017/7/10.
//  Copyright © 2017年 陈家奇. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (Animation)

- (void)beginViewScaleAnimateWithBeginHandler:(void(^)(void))beginHandler EndHandler:(void(^)(void))endHandler ;

- (void)endViewScaleAnimateWithBeginHandler:(void(^)(void))beginHandler EndHandler:(void(^)(void))endHandler ;

@end

//
//  UIViewController+Animation.m
//  maidu
//
//  Created by 张颖 on 2017/7/10.
//  Copyright © 2017年 陈家奇. All rights reserved.
//

#import "UIViewController+Animation.h"

@implementation UIViewController (Animation)

- (void)beginViewScaleAnimateWithBeginHandler:(void(^)(void))beginHandler EndHandler:(void(^)(void))endHandler {
    
    [UIView animateWithDuration:.15 animations:^{
        [self.view.window.layer setTransform:[self firstTransform]];

        if (beginHandler) {
            beginHandler();
        }
        
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:0.3 animations:^{
            self.view.window.transform = CGAffineTransformMakeScale(.9, .9);

            if (endHandler) {
                endHandler();
            }
            
        } completion:^(BOOL finished) {
            
        }];
        
    }];
}
- (void)endViewScaleAnimateWithBeginHandler:(void(^)(void))beginHandler EndHandler:(void(^)(void))endHandler {
    
    [UIView animateWithDuration:.3 animations:^{
        
        [self.view.window.layer setTransform:[self firstTransfrom3]];
        if (beginHandler) {
            beginHandler();
        }

    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:0.4 animations:^{
            
            self.view.window.transform = CGAffineTransformMakeScale(1, 1);
            if (endHandler) {
                endHandler();
            }
        } completion:^(BOOL finished) {
            
            
        }];
        
    }];
}

-(CATransform3D)firstTransform{
    
    CATransform3D t1 = CATransform3DIdentity;
    
    t1.m34 = 1.0/-900;
    
    t1 = CATransform3DScale(t1, 0.9, 0.9, 1);
    
    //绕x旋转
    
    t1 = CATransform3DRotate(t1, 13.0*M_PI/180.0, 1, 0, 0);
    
    return t1;
    
}
- (CATransform3D)firstTransfrom3{
    
    CATransform3D t1 = CATransform3DIdentity;
    
    t1.m34 = 1.0/-900;
    
    t1 = CATransform3DScale(t1, 1, 1, 1);
    
    t1 = CATransform3DRotate(t1, 13*M_PI/180.0, 1, 0, 0);
    
    return t1;
    
}
@end

//
//  DJAlertView.h
//  maidu
//
//  Created by 张颖 on 2017/7/4.
//  Copyright © 2017年 陈家奇. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DJAlertView : NSObject

+ (UIAlertController *)showAlerViewControllerWithVC:(UIViewController *)vc Title:(NSString *)title Message:(NSString *)message CancelTitle:(NSString *)cancelTitle EnsureTitle:(NSString *)ensureTitle CancelBlock:(void(^)())cancelBlock EnsureBlock:(void(^)())ensureBlock;

+ (void)showAlertActionSheetWithLauncher:(UIViewController *)launcher Title:(NSString *)title Msg:(NSString *)msg SureHandler:(void(^)())sureHandler CancelHandler:(void(^)())cancelHandler ;

+ (void)unLogiAlertView:(UIViewController *)controller;
+ (void)isLoginVC:(UIViewController *)vc;
@end

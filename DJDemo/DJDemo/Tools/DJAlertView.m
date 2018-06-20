//
//  DJAlertView.m
//  maidu
//
//  Created by 张颖 on 2017/7/4.
//  Copyright © 2017年 陈家奇. All rights reserved.
//

#import "DJAlertView.h"
//#import "LoginViewController.h"

@implementation DJAlertView

+ (UIAlertController *)showAlerViewControllerWithVC:(UIViewController *)vc Title:(NSString *)title Message:(NSString *)message CancelTitle:(NSString *)cancelTitle EnsureTitle:(NSString *)ensureTitle CancelBlock:(void(^)())cancelBlock EnsureBlock:(void(^)())ensureBlock{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action1, *action2;
    
    UIColor *titleColor = [UIColor darkGrayColor];
    if(cancelTitle && cancelTitle.length){
        action1 = [UIAlertAction actionWithTitle:cancelTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if (cancelBlock) {
                cancelBlock();
            }
        }];
        [alert addAction:action1];
        [action1 setValue:titleColor forKey:@"titleTextColor"];
    }
    
    if (ensureTitle && ensureTitle.length) {
        action2 = [UIAlertAction actionWithTitle:ensureTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if (ensureBlock) {
                ensureBlock();
            }
        }];
        [alert addAction:action2];
        [action2 setValue:titleColor forKey:@"titleTextColor"];
    }
    [vc presentViewController:alert animated:YES completion:nil];
    return alert;
    
}

+ (void)showAlertActionSheetWithLauncher:(UIViewController *)launcher Title:(NSString *)title Msg:(NSString *)msg SureHandler:(void(^)())sureHandler CancelHandler:(void(^)())cancelHandler {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:msg preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIColor *titleColor = [UIColor darkGrayColor];
    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action){
        if (sureHandler) {
            sureHandler();
        }
    }];
    [sureAction setValue:titleColor forKey:@"titleTextColor"];

    [alertController addAction:sureAction];

    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action){
        if (cancelHandler) {
            cancelHandler();
        }
    }];
    [cancelAction setValue:titleColor forKey:@"titleTextColor"];

    [alertController addAction:cancelAction];
    
    [launcher presentViewController:alertController animated:YES completion:nil];
}

//+ (void)unLogiAlertView:(UIViewController *)controller {
//    [self showAlerViewControllerWithVC:controller Title:@"未登录" Message:@"去登录界面登录" CancelTitle:@"暂不" EnsureTitle:@"前往" CancelBlock:^{
//        
//    } EnsureBlock:^{
//        [[UIApplication sharedApplication].keyWindow setRootViewController:[[UINavigationController alloc] initWithRootViewController:[LoginViewController new]]];
//    }];
//}
//+ (void)isLoginVC:(UIViewController *)vc {
//    if (![KeyChain load:AppToken]) {
//        [self unLogiAlertView:vc];
//        return;
//    }
//}
@end

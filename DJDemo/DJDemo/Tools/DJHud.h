//
//  DJHud.h
//  ecshop
//
//  Created by 张颖 on 2017/6/22.
//  Copyright © 2017年 jsyh. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,DJHudOrigin) {
    DJHudOriginTop = 0,
    DJHudOriginMiddle,
    DJHudOriginBottom
};

@interface DJHud : UIView
@property (strong, nonatomic) UILabel *label;

+ (void)showMessage:(NSString *)msg ;
+ (void)showMessage:(NSString *)msg DJHudOrigin:(DJHudOrigin)origin;

+ (DJHud *)showNoHiddenMessage:(NSString *)msg DJHudOrigin:(DJHudOrigin)origin;
+ (void)hiddenHud:(DJHud *)hud;

@end

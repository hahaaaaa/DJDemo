//
//  DJHud.m
//  ecshop
//
//  Created by 张颖 on 2017/6/22.
//  Copyright © 2017年 jsyh. All rights reserved.
//

#import "DJHud.h"

@interface DJHud ()

@property (strong, nonatomic) UIView *baseView;
@property (assign, nonatomic) DJHudOrigin orgin;
@end

@implementation DJHud
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self setupWithOrigin:DJHudOriginMiddle];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame Origin:(DJHudOrigin)origin{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self setupWithOrigin:origin];
    }
    return self;
}
- (void)setupWithOrigin:(DJHudOrigin)origin {
    UIView *baseView = [UIView new];
    baseView.backgroundColor = [UIColor blackColor];
    baseView.layer.cornerRadius = 5;
    [self addSubview:baseView];
    DJWeakSelf;
    if (origin == DJHudOriginBottom) {
        [baseView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(weakSelf);
            make.bottom.equalTo(weakSelf).offset(-100);
            make.width.greaterThanOrEqualTo(@21);
            make.height.equalTo(@40);
        }];
    } else if (origin == DJHudOriginMiddle) {
        
        [baseView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(weakSelf);
            make.centerY.equalTo(weakSelf);
            make.width.greaterThanOrEqualTo(@21);
            make.height.equalTo(@40);
        }];
    } else if (origin == DJHudOriginTop) {
        
        baseView.backgroundColor = [UIColor redColor];
        [baseView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.equalTo(weakSelf);
            make.height.equalTo(@64);
        }];
    }
    self.baseView = baseView;
    
    UILabel *label = [UILabel new];
    label.textColor = [UIColor whiteColor];
    label.textAlignment = 1;
    label.font = [UIFont systemFontOfSize:15];
    [label sizeToFit];
    [baseView addSubview:label];
    
    if (origin == DJHudOriginTop) {
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(baseView).insets(UIEdgeInsetsMake(30, 10, 5, 10));
        }];
    } else {
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(baseView).insets(UIEdgeInsetsMake(5, 10, 5, 10));
        }];
    }

    self.label = label;
}

- (void)hideWithDelay:(CGFloat)delay;{
    [self performSelector:@selector(delayAction) withObject:nil afterDelay:delay];
}
- (void)delayAction {
    self.alpha = 0;
    [self removeFromSuperview];
}
- (void)dealloc {
    [self removeFromSuperview];
}

#pragma mark - ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ public

+ (void)showMessage:(NSString *)msg {
    UIView *view = [UIApplication sharedApplication].keyWindow;
    DJHud *hud = [[self alloc] initWithFrame:view.frame];
    hud.label.text = msg;
    [view addSubview:hud];
    [hud hideWithDelay:1.0];
}
+ (void)showMessage:(NSString *)msg DJHudOrigin:(DJHudOrigin)origin; {
    UIView *view = [UIApplication sharedApplication].keyWindow;
    DJHud *hud = [[self alloc] initWithFrame:view.frame Origin:origin];
    hud.label.text = msg;
    [view addSubview:hud];
    [hud hideWithDelay:1.0];
}

#pragma mark - ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~手动延时方法
+ (DJHud *)showNoHiddenMessage:(NSString *)msg DJHudOrigin:(DJHudOrigin)origin{

    UIView *view = [UIApplication sharedApplication].keyWindow;
    DJHud *hud = [[DJHud alloc] initWithFrame:view.frame Origin:origin];
    hud.label.text = msg;
    [view addSubview:hud];

    return hud;
}
+ (void)hiddenHud:(DJHud *)hud{

    [hud hideWithDelay:1.0];
}
@end

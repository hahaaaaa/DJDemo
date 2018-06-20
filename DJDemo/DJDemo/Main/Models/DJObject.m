//
//  DJObject.m
//  DJDemo
//
//  Created by Sky on 2018/6/7.
//  Copyright © 2018年 Sky. All rights reserved.
//

#import "DJObject.h"

@implementation DJObject
- (void)setAge:(NSInteger)age {
    _age = age;
}
+ (DJObject *)shareObjectFromType:(ObjectType)type; {
    switch (type) {
        case a:
            return [DJAObject new];
            break;
        case b:
            return [DJBObject new];
            break;
        case c:
            return [DJCObject new];
            break;
        case d:
            return [DJDObject new];
            break;
        default:
            break;
    }
}
- (NSInteger)showNum {
    return 0;
}
- (void)run {
    NSLog(@"%s",__func__);
}
@end

@implementation DJAObject
- (NSInteger)showNum {
    return 10;
}
- (void)run {
    [super run];
    NSLog(@"%s",__func__);
}
@end

@implementation DJBObject
- (NSInteger)showNum {
    return 20;
}
- (void)run {
    [super run];
    NSLog(@"%s",__func__);
}
@end

@implementation DJCObject
- (NSInteger)showNum {
    return 30;
}
- (void)run {
    [super run];
    NSLog(@"%s",__func__);
}
@end

@implementation DJDObject
- (NSInteger)showNum {
    return 40;
}
- (void)run {
    [super run];
    NSLog(@"%s",__func__);
}
@end


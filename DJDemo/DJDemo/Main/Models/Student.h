//
//  Student.h
//  DJDemo
//
//  Created by Sky on 2018/6/20.
//  Copyright © 2018年 Sky. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Student : NSObject

@property (assign, nonatomic) NSInteger id;
@property (assign, nonatomic) NSInteger age;
@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSString *sex;

@end

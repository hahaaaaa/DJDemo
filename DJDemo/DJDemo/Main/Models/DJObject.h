//
//  DJObject.h
//  DJDemo
//
//  Created by Sky on 2018/6/7.
//  Copyright © 2018年 Sky. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {a,b,c,d}ObjectType;

@interface DJObject : NSObject

@property (assign, nonatomic) NSInteger age;

+ (DJObject *)shareObjectFromType:(ObjectType)type;

- (NSInteger)showNum;

- (void)run;

@end

@interface DJAObject:DJObject
@end
@interface DJBObject:DJObject
@end
@interface DJCObject:DJObject
@end
@interface DJDObject:DJObject
@end

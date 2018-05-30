//
//  NSNull+NULLExtension.m
//  ecshop
//
//  Created by 张颖 on 2017/6/6.
//  Copyright © 2017年 jsyh. All rights reserved.
//

#import "NSNull+NULLExtension.h"
#define UXY_NullObjects @[@"",@0,@{},@[]]

@implementation NSNull (NULLExtension)

- (NSMethodSignature *)methodSignatureForSelector:(SEL)selector
{
    NSMethodSignature *signature = [super methodSignatureForSelector:selector];
    
    if (signature != nil) return signature;
    
    for (NSObject *object in UXY_NullObjects)
    {
        signature = [object methodSignatureForSelector:selector];
        
        if (signature)
        {
            if (strcmp(signature.methodReturnType, "@") == 0)
            {
                signature = [[NSNull null] methodSignatureForSelector:@selector(__returnNil)];
            }
            break;
        }
    }
    
    return signature;
} 


- (void)forwardInvocation:(NSInvocation *)anInvocation
{
    if (strcmp(anInvocation.methodSignature.methodReturnType, "@") == 0)
    {
        anInvocation.selector = @selector(__uxy_nil);
        [anInvocation invokeWithTarget:self];
        return;
    }
    
    for (NSObject *object in UXY_NullObjects)
    {
        if ([object respondsToSelector:anInvocation.selector])
        {
            [anInvocation invokeWithTarget:object];
            return;
        }
    }
    
    [self doesNotRecognizeSelector:anInvocation.selector];
}

- (id)__uxy_nil
{
    return nil;
}

@end

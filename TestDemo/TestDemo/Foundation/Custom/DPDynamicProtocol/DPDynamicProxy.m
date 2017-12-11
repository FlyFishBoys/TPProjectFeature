//
//  DPDynamicProxy.m
//  TestDemo
//
//  Created by sunwf on 2017/12/7.
//  Copyright © 2017年 sunwf. All rights reserved.
//

#import "DPDynamicProxy.h"

@implementation DPDynamicProxy
- (id)initWithObject:(id)obj {
    _obj = obj;

    return self;
}

- (void)forwardInvocation:(NSInvocation *)invocation {
    if (_obj) {
        NSLog(@"proxy invocation obj method : %@", NSStringFromSelector([invocation selector]));
        [invocation setTarget:_obj];
        [invocation invoke];
    }
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel {
    if ([_obj isKindOfClass:[NSObject class]]) {
        return [(NSObject *)_obj methodSignatureForSelector:sel];
    }
    return [super methodSignatureForSelector:sel];
}

- (void)doSomething {
    NSLog(@"proxy do something");//1
    [_obj doSomething];
}

//-(void)doOtherThing
//{
//    NSLog(@"proxy do doOtherThing");//1
//    [_obj doOtherThing];
//}


@end

//
//  DPNormalObject.m
//  TestDemo
//
//  Created by sunwf on 2017/12/7.
//  Copyright © 2017年 sunwf. All rights reserved.
//

#import "DPNormalObject.h"

@implementation DPNormalObject

- (void)doSomething {
    NSLog(@"normal object do something");

    if (self.deleagte && [self.deleagte respondsToSelector:@selector(doSomething)]) {
        [self.deleagte doSomething];
    }
    
}

- (void)doOtherThing {
    NSLog(@"normal object do other thing");

    if (self.deleagte && [self.deleagte respondsToSelector:@selector(doOtherThing)]) {
        [self.deleagte doOtherThing];
    }
    
}

- (void)dealloc
{
   
}

@end

//
//  DPDynamicProxy.h
//  TestDemo
//
//  Created by sunwf on 2017/12/7.
//  Copyright © 2017年 sunwf. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DPDynamicProtocol.h"

@interface DPDynamicProxy : NSProxy<DPDynamicProtocol>
{
@private
    id _obj;
}
- (id)initWithObject:(id)obj;

@end

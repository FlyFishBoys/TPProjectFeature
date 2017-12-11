//
//  UITableView+UpdateFont.m
//  ZQ_SetFontSize
//
//  Created by sunwf on 2017/12/1.
//  Copyright © 2017年 hzq. All rights reserved.
//

#import "UITableView+UpdateFont.h"
#import <objc/runtime.h>
#import <objc/message.h>

@implementation UITableView (UpdateFont)

static void dz_exchangeMethod(Class originalClass, SEL originalSel, Class replacedClass, SEL replacedSel, SEL orginReplaceSel){
    // 原方法
    Method originalMethod = class_getInstanceMethod(originalClass, originalSel);
    // 替换方法
    Method replacedMethod = class_getInstanceMethod(replacedClass, replacedSel);
    // 如果没有实现 delegate 方法，则手动动态添加
    if (!originalMethod) {
        Method orginReplaceMethod = class_getInstanceMethod(replacedClass, orginReplaceSel);
        BOOL didAddOriginMethod = class_addMethod(originalClass, originalSel, method_getImplementation(orginReplaceMethod), method_getTypeEncoding(orginReplaceMethod));
        if (didAddOriginMethod) {
            //            NSLog(@"did Add Origin Replace Method");
        }
        return;
    }
    // 向实现 delegate 的类中添加新的方法
    // 这里是向 originalClass 的 replaceSel（@selector(replace_webViewDidFinishLoad:)） 添加 replaceMethod
    BOOL didAddMethod = class_addMethod(originalClass, replacedSel, method_getImplementation(replacedMethod), method_getTypeEncoding(replacedMethod));
    if (didAddMethod) {
        // 添加成功
        //        NSLog(@"class_addMethod_success --> (%@)", NSStringFromSelector(replacedSel));
        // 重新拿到添加被添加的 method,这里是关键(注意这里 originalClass, 不 replacedClass), 因为替换的方法已经添加到原类中了, 应该交换原类中的两个方法
        Method newMethod = class_getInstanceMethod(originalClass, replacedSel);
        // 实现交换
        method_exchangeImplementations(originalMethod, newMethod);
    }else{
        // 添加失败，则说明已经 hook 过该类的 delegate 方法，防止多次交换。
        NSLog(@"Already hook class --> (%@)",NSStringFromClass(originalClass));
    }

}

+(void)load{
    // hook UIWebView
    Method originalMethod = class_getInstanceMethod([self class], @selector(setDelegate:));
    Method swizzledMethod = class_getInstanceMethod([self class], @selector(dz_setDelegate:));
    method_exchangeImplementations(originalMethod, swizzledMethod);
}

- (void)dz_setDelegate:(id<UITableViewDelegate>)delegate{
    [self dz_setDelegate:delegate];
    
    NSLog(@"-----------  dz_setDelegate");
    // 拿到 delegate 对象，在这里做替换 delegate 方法的操作
    [self exchangeUIWebViewDelegateMethod:delegate];
    
}

#pragma mark - hook webView delegate 方法

- (void)exchangeUIWebViewDelegateMethod:(id)delegate{
    dz_exchangeMethod([delegate class], @selector(tableView:cellForRowAtIndexPath:), [self class], @selector(replace_tableView:cellForRowAtIndexPath:),@selector(oriReplace_tableView:cellForRowAtIndexPath:));
}


- (UITableViewCell*)replace_tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    UITableViewCell * cell = [self replace_tableView:tableView cellForRowAtIndexPath:indexPath];
    cell.backgroundColor = [UIColor redColor];
    cell.hidden = YES;
    NSLog(@"----------- replace_tableView: cellForRowAtIndexPath:");
    [UITableView checkSubViewsForView:cell];
    
    return   cell;
}


- (UITableViewCell*)oriReplace_tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
     UITableViewCell * cell = [self oriReplace_tableView:tableView cellForRowAtIndexPath:indexPath];
    cell.backgroundColor = [UIColor redColor];
    
    [UITableView checkSubViewsForView:cell];

    return  cell;
}


+(void)checkSubViewsForView:(UIView*)view
{
    for (UIView* obj in view.subviews) {

         UIView * sub = obj;
        if ([obj isKindOfClass:[UITextView class]]) {
            UITextView * lab = (UITextView*)obj;
            
            UIFont * tempFont = lab.font;
            
            UIFontDescriptor *ctfFont = tempFont.fontDescriptor;
            NSNumber *fontSize = [ctfFont objectForKey:@"NSFontSizeAttribute"];
            lab.font = [UIFont systemFontOfSize:[fontSize floatValue]];
            
            NSLog(@"%@--字体大小--%@",lab.text,lab.font);
        }
        if (sub.subviews.count>1) {
             [UITableView checkSubViewsForView:sub];
        }
    }
}



@end

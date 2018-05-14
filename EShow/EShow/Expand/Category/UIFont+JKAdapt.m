//
//  UIFont+JKAdapt.m
//  EShow
//
//  Created by 周家康 on 2018/5/7.
//  Copyright © 2018年 周家康. All rights reserved.
//

#import "UIFont+JKAdapt.h"

@implementation UIFont (JKAdapt)

+ (void)load{
    //获取替换后的类方法
    Method newMethod = class_getClassMethod([self class], @selector(adjustFont:));
    //获取替换前的类方法
    Method method = class_getClassMethod([self class], @selector(systemFontOfSize:));
    //然后交换类方法
    method_exchangeImplementations(newMethod, method);
}

+(UIFont *)adjustFont:(CGFloat)fontSize{
    UIFont *newFont=nil;
    if (IS_IPHONE_8) {
        newFont = [UIFont adjustFont:fontSize + IPHONE_8_INCREMENT];
    } else if (IS_IPHONE_8_PLUS) {
        newFont = [UIFont adjustFont:fontSize + IPHONE_8_PLUS_INCREMENT];
    } else if (IS_IPHONE_X) {
        newFont = [UIFont adjustFont:fontSize + IPHONE_X_INCREMENT];
    } else{
        newFont = [UIFont adjustFont:fontSize];
    }
    return newFont;
}

@end

//
//  UIFont+JKAdapt.h
//  EShow
//
//  Created by 周家康 on 2018/5/7.
//  Copyright © 2018年 周家康. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <objc/runtime.h>

@interface UIFont (JKAdapt)

+ (UIFont *)adjustFont:(CGFloat)fontSize;

@end
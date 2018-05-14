//
//  NSString+JKExtension.m
//  EShow
//
//  Created by 周家康 on 2018/5/7.
//  Copyright © 2018年 周家康. All rights reserved.
//

#import "NSString+JKExtension.h"

@implementation NSString (JKExtension)

#pragma mark -- 去除多余的空白字符
- (NSString *) trimmingCharacters {
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}

@end

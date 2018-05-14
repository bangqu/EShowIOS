//
//  JKGlobalSingleton.m
//  EShow
//
//  Created by 周家康 on 2018/5/8.
//  Copyright © 2018年 周家康. All rights reserved.
//

#import "JKGlobalSingleton.h"

static JKGlobalSingleton *_singleton;

@implementation JKGlobalSingleton

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _singleton = [super allocWithZone:zone];
    });
    return _singleton;
}

+ (instancetype)shareSingleton {
    return [[self alloc] init];
}

-(id)copyWithZone:(NSZone *)zone
{
    return _singleton;
}

-(id)mutableCopyWithZone:(NSZone *)zone
{
    return _singleton;
}

@end

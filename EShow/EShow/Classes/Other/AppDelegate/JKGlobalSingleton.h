//
//  JKGlobalSingleton.h
//  EShow
//
//  Created by 周家康 on 2018/5/8.
//  Copyright © 2018年 周家康. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JKGlobalSingleton : NSObject<NSCopying>

@property (nonatomic, strong) NSString *accessToken;

+ (instancetype)shareSingleton;

@end

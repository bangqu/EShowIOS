//
//  JKUserInfoModel.h
//  EShow
//
//  Created by 周家康 on 2018/5/8.
//  Copyright © 2018年 周家康. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JKUserInfoModel : NSObject
@property (nonatomic, strong) NSString *accessToken;
@property (nonatomic, strong) NSString *userId;
@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) NSString *nickname;
@property (nonatomic, strong) NSString *photo;
@property (nonatomic, strong) NSString *male;
@property (nonatomic, strong) NSString *intro;

- (instancetype)initWithUserInfoModelWithDict:(NSDictionary *)dict;
@end

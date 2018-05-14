//
//  JKUserInfoModel.m
//  EShow
//
//  Created by 周家康 on 2018/5/8.
//  Copyright © 2018年 周家康. All rights reserved.
//

#import "JKUserInfoModel.h"

@implementation JKUserInfoModel
- (instancetype)initWithUserInfoModelWithDict:(NSDictionary *)dict{
    self = [super init];
    if (self) {
        self.accessToken = dict[kAccessToken][kAccessToken];
        self.userId = dict[kUser][kUserId];
        self.username = dict[kUser][kUserName];
        self.nickname = dict[kUser][kNickName];
        self.photo = dict[kUser][kPhoto];
        self.male = dict[kUser][kMale];
        self.intro = dict[kUser][kIntro];
    }
    return self;
}
@end

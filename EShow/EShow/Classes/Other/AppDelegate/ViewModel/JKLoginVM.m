//
//  JKLoginVM.m
//  EShow
//
//  Created by 周家康 on 2018/5/8.
//  Copyright © 2018年 周家康. All rights reserved.
//

#import "JKLoginVM.h"
#import "JKUserInfoModel.h"

@implementation JKLoginVM

- (void)loginRequestWithSuccessBlock:(ReturnSuccessBlock)successBlock
                    withFailureBlock:(ReturnFailureBlock)failureBlock {
    NSMutableDictionary * params = [[NSMutableDictionary alloc] init];
    [params setObject:self.phoneStr forKey:kUserUserName];
    [params setObject:self.pwdStr forKey:kUserPassword];
    NSString *clientId = [JKUserDefaults objectForKey:kClientId];
    if (clientId != nil) {
        [params setObject:[JKUserDefaults objectForKey:kClientId] forKey:kUserClientId];
    }
    
    NSString *urlStr = [NSString stringWithFormat:@"%@",URL_User_Login];
    [[JKHttpTool shareInstance] PostReceiveInfo:params url:urlStr successBlock:^(NSURLSessionDataTask *operation, id responseObject) {
        if([responseObject[kStatus] integerValue] == 1) {
            JKUserInfoModel *model = [[JKUserInfoModel alloc] initWithUserInfoModelWithDict:responseObject];
            if (![model.accessToken isKindOfClass:[NSNull class]]) {
                [JKUserDefaults setObject:model.accessToken forKey:kAccessToken];
            }
            if (![model.userId isKindOfClass:[NSNull class]]) {
                [JKUserDefaults setObject:model.userId forKey:kUserId];
            }
            if (![model.username isKindOfClass:[NSNull class]]) {
                [JKUserDefaults setObject:model.username forKey:kUserName];
            }
            if (![model.nickname isKindOfClass:[NSNull class]]) {
                [JKUserDefaults setObject:model.nickname forKey:kNickName];
            }
            if (![model.photo isKindOfClass:[NSNull class]]) {
                [JKUserDefaults setObject:model.photo forKey:kPhoto];
            }
            if (![model.male isKindOfClass:[NSNull class]]) {
                [JKUserDefaults setObject:model.male forKey:kMale];
            }
            if (![model.intro isKindOfClass:[NSNull class]]) {
                [JKUserDefaults setObject:model.intro forKey:kIntro];
            }
            [JKUserDefaults synchronize];
        }
        successBlock(responseObject);
    } withFailureBlock:^(NSURLSessionDataTask *operation, NSError *error) {
        failureBlock(error);
    }];
}



@end

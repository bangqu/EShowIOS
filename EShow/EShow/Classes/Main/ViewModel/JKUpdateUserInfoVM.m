//
//  JKUpdateUserInfoVM.m
//  EShow
//
//  Created by 周家康 on 2018/5/9.
//  Copyright © 2018年 周家康. All rights reserved.
//

#import "JKUpdateUserInfoVM.h"

@implementation JKUpdateUserInfoVM

#pragma mark -- 头像
- (void)userInfoHeadImgVRequestWithSuccessBlock:(ReturnSuccessBlock)successBlock
                               withFailureBlock:(ReturnFailureBlock)failureBlock {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:[JKUserDefaults objectForKey:kAccessToken] forKey:kAccessToken];
    [params setObject:self.photoStr forKey:kUserPhoto];
    
    NSString *urlStr = [NSString stringWithFormat:@"%@",URL_User_Update];

    [[JKHttpTool shareInstance] PostReceiveInfo:params url:urlStr successBlock:^(NSURLSessionDataTask *operation, id responseObject) {
        successBlock(responseObject);
    } withFailureBlock:^(NSURLSessionDataTask *operation, NSError *error) {
        failureBlock(error);
    }];
}

#pragma mark -- 性别
- (void)userInfoGenderRequestWithSuccessBlock:(ReturnSuccessBlock)successBlock
                       withFailureBlock:(ReturnFailureBlock)failureBlock {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:[JKUserDefaults objectForKey:kAccessToken] forKey:kAccessToken];
    if ([self.genderStr isEqualToString:@"男"]) {
        [params setObject:@"true" forKey:kUserMale];
    } else if ([self.genderStr isEqualToString:@"女"]) {
        [params setObject:@"false" forKey:kUserMale];
    }
    
    NSString *urlStr = [NSString stringWithFormat:@"%@",URL_User_Update];
    [[JKHttpTool shareInstance] PostReceiveInfo:params url:urlStr successBlock:^(NSURLSessionDataTask *operation, id responseObject) {
        [YJProgressHUD hide];
        successBlock(responseObject);
    } withFailureBlock:^(NSURLSessionDataTask *operation, NSError *error) {
        failureBlock(error);
    }];
}

#pragma mark -- 昵称
- (void)userInfoModifyNameRequestWithSuccessBlock:(ReturnSuccessBlock)successBlock
                                 withFailureBlock:(ReturnFailureBlock)failureBlock {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:[JKUserDefaults objectForKey:kAccessToken] forKey:kAccessToken];
    [params setObject:self.nickNameStr forKey:kUserNickName];
    
    NSString *urlStr = [NSString stringWithFormat:@"%@",URL_User_Update];
    [[JKHttpTool shareInstance] PostReceiveInfo:params url:urlStr successBlock:^(NSURLSessionDataTask *operation, id responseObject) {
        successBlock(responseObject);
    } withFailureBlock:^(NSURLSessionDataTask *operation, NSError *error) {
        failureBlock(error);
    }];
}

#pragma mark -- 个性签名
- (void)userInfoIntroRequestWithSuccessBlock:(ReturnSuccessBlock)successBlock
                            withFailureBlock:(ReturnFailureBlock)failureBlock {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:[JKUserDefaults objectForKey:kAccessToken] forKey:kAccessToken];
    [params setObject:self.introStr forKey:kUserIntro];
    
    NSString *urlStr = [NSString stringWithFormat:@"%@",URL_User_Update];
    [[JKHttpTool shareInstance] PostReceiveInfo:params url:urlStr successBlock:^(NSURLSessionDataTask *operation, id responseObject) {
        successBlock(responseObject);
    } withFailureBlock:^(NSURLSessionDataTask *operation, NSError *error) {
        failureBlock(error);
    }];
}

@end

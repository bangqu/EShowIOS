//
//  JKModifyPwdVM.m
//  EShow
//
//  Created by 周家康 on 2018/5/10.
//  Copyright © 2018年 周家康. All rights reserved.
//

#import "JKModifyPwdVM.h"

@implementation JKModifyPwdVM

- (void)modifyPwdRequestWithSuccessBlock:(ReturnSuccessBlock)successBlock
                        withFailureBlock:(ReturnFailureBlock)failureBlock {
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:[JKUserDefaults objectForKey:kAccessToken] forKey:kAccessToken];
    [params setObject:self.oldPwdStr forKey:kOldPassword];
    [params setObject:self.nPwdStr forKey:kUserPassword];
    
    NSString *urlStr = [NSString stringWithFormat:@"%@",URL_User_UpdatePassword];

    [[JKHttpTool shareInstance] PostReceiveInfo:params url:urlStr successBlock:^(NSURLSessionDataTask *operation, id responseObject) {
        [YJProgressHUD hide];
        successBlock(responseObject);
    } withFailureBlock:^(NSURLSessionDataTask *operation, NSError *error) {
        failureBlock(error);
    }];
}

@end

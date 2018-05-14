//
//  JKVerificationLoginVM.m
//  EShow
//
//  Created by 周家康 on 2018/5/9.
//  Copyright © 2018年 周家康. All rights reserved.
//

#import "JKVerificationLoginVM.h"
#import "JKUserInfoModel.h"

@implementation JKVerificationLoginVM

- (void)loginRequestWithSuccessBlock:(ReturnSuccessBlock)successBlock
                    withFailureBlock:(ReturnFailureBlock)failureBlock {
    NSMutableDictionary * params = [[NSMutableDictionary alloc] init];
    [params setObject:self.phoneStr forKey:kUserUserName];
    [params setObject:self.codeStr forKey:kCode];
    NSString *clientId = [JKUserDefaults objectForKey:kClientId];
    if (clientId != nil) {
        [params setObject:[JKUserDefaults objectForKey:kClientId] forKey:kUserClientId];
    }
    
    NSString *urlStr = [NSString stringWithFormat:@"%@",URL_Captcha_Login];
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

#pragma mark -- 发送验证码
- (void)verificationRequestWithSuccessBlock:(ReturnSuccessBlock)successBlock
                           withFailureBlock:(ReturnFailureBlock)failureBlock {
    NSMutableDictionary * params = [[NSMutableDictionary alloc] init];
    [params setObject:self.phoneStr forKey:kCaptchaMobile];
    [params setObject:kLogin forKey:kCaptchaType];
    
    NSString *urlStr = [NSString stringWithFormat:@"%@",URL_Captcha_Send];
    [[JKHttpTool shareInstance] PostReceiveInfo:params url:urlStr successBlock:^(NSURLSessionDataTask *operation, id responseObject) {
        if ([responseObject[kStatus] integerValue] == 1) {
            [self restTime];
        }
        successBlock(responseObject);
    } withFailureBlock:^(NSURLSessionDataTask *operation, NSError *error) {
        failureBlock(error);
    }];
}

#pragma mark -- 倒计时
- (void)restTime {
    //修改时间效果
    __block int timeout = 59;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer, dispatch_walltime(NULL, 0), 1.0*NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(_timer, ^{
        if (timeout <= 0) {
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.verificationBtn setTitle:@"重新获取" forState:UIControlStateNormal];
                [self.verificationBtn setTitleColor:RGBHex(0xBBBBBB) forState:UIControlStateNormal];
                self.verificationBtn.enabled = YES;
            });
        } else {
            int seconds = timeout % 60;
            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                [UIView beginAnimations:nil context:nil];
                [UIView setAnimationDuration:1];
                [self.verificationBtn setTitle:[NSString stringWithFormat:@"%@s",strTime] forState:UIControlStateDisabled];
                [UIView commitAnimations];
                self.verificationBtn.enabled = NO;
            });
            timeout--;
        }
    });
    dispatch_resume(_timer);
}

@end

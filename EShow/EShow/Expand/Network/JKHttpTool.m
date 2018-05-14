//
//  JKHttpTool.m
//  EShow
//
//  Created by 周家康 on 2018/5/7.
//  Copyright © 2018年 周家康. All rights reserved.
//

#import "JKHttpTool.h"

@implementation JKHttpTool

+ (JKHttpTool *)shareInstance{
    static JKHttpTool *instance= nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        instance = [[JKHttpTool alloc]init];
    });
    return instance;
}

- (AFHTTPSessionManager *)baseHttpRequest{
    // 1.加密
    AFSecurityPolicy *securityPolicy = [[AFSecurityPolicy alloc] init];
    [securityPolicy setAllowInvalidCertificates:YES];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    // 2.设置非校验证书模式
    manager.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    manager.securityPolicy.allowInvalidCertificates = YES;
    [manager.securityPolicy setValidatesDomainName:NO];
    
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 3.0f;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    
    return manager;
}

#pragma mark -- POST
- (void)PostReceiveInfo:(NSDictionary *)dictionary url:(NSString *)url successBlock:(SuccessBlock)successBlock withFailureBlock:(FailureBlock)failureBlock{
    AFHTTPSessionManager *manager = [self baseHttpRequest];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/plain",@"text/html",@"image/png", @"application/javascript", @"text/javascript",nil];
    
    [manager POST:url parameters:dictionary progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        successBlock(task,responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failureBlock(task,error);
        NSLog(@"%@",error);
    }];
}

#pragma mark -- GET
- (void)GetReceiveInfo:(NSDictionary *)dictionary url:(NSString *)url successBlock:(SuccessBlock)successBlock withFailureBlock:(FailureBlock)failureBlock {
    AFHTTPSessionManager *manager = [self baseHttpRequest];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/plain",@"text/html",@"image/png", @"application/javascript", @"text/javascript",nil];
    
    [manager GET:url parameters:dictionary progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        successBlock(task,responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failureBlock(task,error);
    }];
}

@end

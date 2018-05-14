//
//  JKHttpTool.h
//  EShow
//
//  Created by 周家康 on 2018/5/7.
//  Copyright © 2018年 周家康. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetWorking.h"

@interface JKHttpTool : NSObject
// 请求成功之后回调的 Block
typedef void(^SuccessBlock) (NSURLSessionDataTask *operation, id responseObject);
// 请求失败之后回调的 Block
typedef void(^FailureBlock) (NSURLSessionDataTask *operation, NSError *error);

+ (JKHttpTool *)shareInstance;

- (AFHTTPSessionManager *)baseHttpRequest;

- (void)PostReceiveInfo:(NSDictionary *)dictionary url:(NSString *)url successBlock:(SuccessBlock)successBlock withFailureBlock:(FailureBlock)failureBlock;

- (void)GetReceiveInfo:(NSDictionary *)dictionary url:(NSString *)url successBlock:(SuccessBlock)successBlock withFailureBlock:(FailureBlock)failureBlock;


@end

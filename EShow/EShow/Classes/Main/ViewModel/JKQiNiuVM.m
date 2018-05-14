//
//  JKQiNiuVM.m
//  EShow
//
//  Created by 周家康 on 2018/5/10.
//  Copyright © 2018年 周家康. All rights reserved.
//

#import "JKQiNiuVM.h"

@interface JKQiNiuVM()
@property (nonatomic, strong) NSString *qiniuToken;
@property (nonatomic, strong) NSString *qiniuKey;
@end

@implementation JKQiNiuVM

- (void)QiNiuRequestWithSuccessBlock:(ReturnSuccessBlock)successBlock
                    withFailureBlock:(ReturnFailureBlock)failureBlock {
    NSString *tokenUrl = [NSString stringWithFormat:@"%@",URL_QiNiu_UpToken];
    [[JKHttpTool shareInstance] PostReceiveInfo:nil url:tokenUrl successBlock:^(NSURLSessionDataTask *operation, id responseObject) {
        if ([responseObject[kStatus] integerValue] == 1) {
            self.qiniuToken = responseObject[kMsg];
            
            NSString *keyUrl = [NSString stringWithFormat:@"%@",URL_QiNiu_Key];
            [[JKHttpTool shareInstance] PostReceiveInfo:nil url:keyUrl successBlock:^(NSURLSessionDataTask *operation, id responseObject) {
                if ([responseObject[kStatus] integerValue] == 1) {
                    NSString *msg =[NSString stringWithFormat:@"%@",responseObject[kMsg]];
                    NSArray *keyArr = [msg componentsSeparatedByString:@"/"];
                    self.qiniuKey = [keyArr lastObject];
                    
                    NSString *documentPath = [self saveImage:self.image withName:[self timeString]];
                    QNUploadManager *upManager = [[QNUploadManager alloc] init];
                    NSData *imageData = [NSData dataWithContentsOfFile:documentPath];
                    [upManager putData:imageData key:self.qiniuKey token:self.qiniuToken complete:^(QNResponseInfo *info, NSString *key, NSDictionary *resp) {
                        NSString *imgUrl = [NSString stringWithFormat:@"http://oyeu81n16.bkt.clouddn.com/%@",key];
                        [JKUserDefaults setObject:imgUrl forKey:kPhoto];
                        successBlock(imgUrl);
                    } option:nil];
                } else {
                    successBlock(@"fail");
                }
            } withFailureBlock:^(NSURLSessionDataTask *operation, NSError *error) {
                failureBlock(error);
            }];
        } else {
           successBlock(@"fail");
        }
    } withFailureBlock:^(NSURLSessionDataTask *operation, NSError *error) {
        failureBlock(error);
    }];
}

#pragma mark - 保存图片至沙盒
- (NSString *)saveImage:(UIImage *)currentImage withName:(NSString *)imageName {
    imageName = [imageName stringByReplacingOccurrencesOfString:@"/" withString:@""];
    NSData *photoData = UIImageJPEGRepresentation(currentImage, 1.0);
    // 获取沙盒目录
    NSString *documentPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:imageName];
    // 将图片写入文件
    [photoData writeToFile:documentPath atomically:NO];
    return documentPath;
}

#pragma mark - 保存日期
- (NSString *) timeString {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat: @"yyyy-MM-dd-HH-mm-ss"];
    return [formatter stringFromDate:[NSDate date]];
}



@end

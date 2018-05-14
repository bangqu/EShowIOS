//
//  JKTouchIDAndFaceIDVC.m
//  EShow
//
//  Created by 周家康 on 2018/5/11.
//  Copyright © 2018年 周家康. All rights reserved.
//

#import "JKTouchIDAndFaceIDVC.h"
#import <LocalAuthentication/LocalAuthentication.h>

@interface JKTouchIDAndFaceIDVC ()

@end

@implementation JKTouchIDAndFaceIDVC

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"TouchID&FaceID";

    [self createFoundation];
}

- (void)createFoundation {
    if (@available(iOS 8.0, *)) {
        LAContext *laContent = [LAContext new];
        laContent.localizedFallbackTitle = @"验证登录密码";
        
        NSError *authError = nil;
        BOOL isCanEvaluatePolicy = [laContent canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&authError];
        
        if (authError) {
            NSLog(@"%@",[NSString stringWithFormat:@"检测设备是否支持TouchID或者FaceID失败。\n errorCode : %ld\n errorMsg : %@",(long)authError.code, authError.localizedDescription]);
        } else {
            if (isCanEvaluatePolicy) {
                [laContent evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:@"请按Home键指纹解锁" reply:^(BOOL success, NSError * _Nullable error) {
                    if (success) {
                        NSLog(@"验证成功 刷新主界面");
                    } else {
                        NSLog(@"%@",error.localizedDescription);
                        switch (error.code) {
                            case LAErrorSystemCancel:
                            {
                                NSLog(@"系统取消授权，如其他APP切入");
                                break;
                            }
                            case LAErrorUserCancel:
                            {
                                NSLog(@"用户取消验证Touch ID");
                                break;
                            }
                            case LAErrorAuthenticationFailed:
                            {
                                NSLog(@"授权失败");
                                break;
                            }
                            case LAErrorPasscodeNotSet:
                            {
                                NSLog(@"系统未设置密码");
                                break;
                            }
                            case LAErrorTouchIDNotAvailable:
                            {
                                NSLog(@"设备Touch ID不可用，例如未打开");
                                break;
                            }
                            case LAErrorTouchIDNotEnrolled:
                            {
                                NSLog(@"设备Touch ID不可用，用户未录入");
                                break;
                            }
                            case LAErrorUserFallback:
                            {
                                [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                                    NSLog(@"用户选择输入密码，切换主线程处理");
                                }];
                                break;
                            }
                            default:
                            {
                                [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                                    NSLog(@"其他情况，切换主线程处理");
                                }];
                                break;
                            }
                        }
                    }
                }];
            } else {
                NSLog(@"不支持指纹识别");
            }
        }
    } else {
        NSLog(@"不支持指纹识别");
    }
}






@end

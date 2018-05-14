//
//  JKVerificationLoginVC.m
//  EShow
//
//  Created by 周家康 on 2018/5/9.
//  Copyright © 2018年 周家康. All rights reserved.
//

#import "JKVerificationLoginVC.h"
#import "JKVerificationLoginView.h"

@interface JKVerificationLoginVC ()<JKVerificationLoginViewDelegate>

@end

@implementation JKVerificationLoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"验证码登录";
    
    JKVerificationLoginView *vlV = [[JKVerificationLoginView alloc] init];
    vlV.delegate = self;
    vlV.backgroundColor = kWhiteColor;
    [self.view addSubview:vlV];
    [vlV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.safeAreaTopView.mas_bottom).offset(SCALE_SIZE(10));
        make.left.right.bottom.equalTo(self.view);
    }];
}

#pragma mark -- JKVerificationLoginViewDelegate
- (void)pushMainVC {
    JKMainVC *mVC = [[JKMainVC alloc] init];
    JKNavigationVC *nVC = [[JKNavigationVC alloc] initWithRootViewController:mVC];
    UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
    [window setRootViewController:nVC];
}

@end

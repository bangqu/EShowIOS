//
//  JKAccountSecurityVC.m
//  EShow
//
//  Created by 周家康 on 2018/5/10.
//  Copyright © 2018年 周家康. All rights reserved.
//

#import "JKAccountSecurityVC.h"
#import "JKAccountSecurityView.h"
#import "JKModifyPwdVC.h"
#import "JKSocialAccountVC.h"

@interface JKAccountSecurityVC () <JKAccountSecurityViewDelegate>

@end

@implementation JKAccountSecurityVC

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"账号与安全";
    
    JKAccountSecurityView *asV = [[JKAccountSecurityView alloc] init];
    asV.delegate = self;
    [self.view addSubview:asV];
    [asV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.safeAreaTopView.mas_bottom);
        make.left.right.bottom.equalTo(self.view);
    }];
}

#pragma mark -- 修改密码
- (void)pushModifyPwdVC {
    JKModifyPwdVC *mpVC = [[JKModifyPwdVC alloc] init];
    [self.navigationController pushViewController:mpVC animated:YES];
}

#pragma mark -- 社交账号绑定
- (void)pushSocialAccountVC {
    JKSocialAccountVC *saVC = [[JKSocialAccountVC alloc] init];
    [self.navigationController pushViewController:saVC animated:YES];
}

@end

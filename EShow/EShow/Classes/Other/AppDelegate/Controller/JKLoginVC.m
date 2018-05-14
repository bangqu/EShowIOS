//
//  JKLoginVC.m
//  EShow
//
//  Created by 周家康 on 2018/5/8.
//  Copyright © 2018年 周家康. All rights reserved.
//

#import "JKLoginVC.h"
#import "JKLoginView.h"
#import "JKForgetPwdVC.h"
#import "JKVerificationLoginVC.h"
#import "JKBindPhoneVC.h"

@interface JKLoginVC () <JKLoginViewDelegate>
@end

@implementation JKLoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"登录";
    if (!self.isRootVC) {
        [self createLeftBarButtonItem];
    }
    [self createRightBarButtonItem];
    
    if (self.isShowRegisterVC) {
        [self registerBtnClick];
    }
    
    JKLoginView *lV = [[JKLoginView alloc] init];
    lV.delegate = self;
    lV.backgroundColor = kWhiteColor;
    [self.view addSubview:lV];
    [lV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.safeAreaTopView.mas_bottom).offset(SCALE_SIZE(10));
        make.left.right.bottom.equalTo(self.view);
    }];
}

#pragma mark -- JKLoginViewDelegate
- (void)pushMainVC {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (self.isRootVC) {
            JKMainVC *mVC = [[JKMainVC alloc] init];
            JKNavigationVC *nVC = [[JKNavigationVC alloc] initWithRootViewController:mVC];
            UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
            [window setRootViewController:nVC];
        } else {
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    });
}

- (void)pushForgetPwdVC {
    JKForgetPwdVC *fpVC = [[JKForgetPwdVC alloc] init];
    [self.navigationController pushViewController:fpVC animated:YES];
}

- (void)pushVerificationLoginVC {
    JKVerificationLoginVC *vlVC = [[JKVerificationLoginVC alloc] init];
    [self.navigationController pushViewController:vlVC animated:YES];
}

- (void)pushBindPhoneVC {
    JKBindPhoneVC *bpVC = [[JKBindPhoneVC alloc] init];
    [self.navigationController pushViewController:bpVC animated:YES];
}

#pragma mark -- 返回按钮
- (void)createLeftBarButtonItem {
    UIButton *backBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 80, 21)];
    backBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [backBtn setTitle:@"返回" forState:UIControlStateNormal];
    [backBtn setTitleColor:kTextBaseColor forState:UIControlStateNormal];
    [backBtn setImage:[UIImage imageNamed:@"goBack"] forState:UIControlStateNormal];
    if (@available(iOS 11.0, *)) {
        [backBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -30, 0, 0)];
        [backBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, -30, 0, 0)];
    } else {
        [backBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 0)];
        [backBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 0)];
    }
    [backBtn addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *btnItem=[[UIBarButtonItem alloc]initWithCustomView:backBtn];
    
    UIBarButtonItem *navigationSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    if (@available(iOS 11.0, *)) {
        
    } else {
        navigationSpace.width = -15;
    }
    self.navigationItem.leftBarButtonItems = @[navigationSpace, btnItem];
}

#pragma mark -- 返回的点击事件
- (void)backBtnClick {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark -- 注册按钮
- (void)createRightBarButtonItem {
    UIButton *registerBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 21)];
    registerBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [registerBtn setTitle:@"注册" forState:UIControlStateNormal];
    [registerBtn setTitleColor:kTextBaseColor forState:UIControlStateNormal];
    if (@available(iOS 11.0, *)) {
        [registerBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, -10)];
    } else {
        registerBtn.contentHorizontalAlignment =UIControlContentHorizontalAlignmentRight;
        [registerBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    }
    [registerBtn addTarget:self action:@selector(registerBtnClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *btnItem=[[UIBarButtonItem alloc]initWithCustomView:registerBtn];
    self.navigationItem.rightBarButtonItem = btnItem;
}

#pragma mark -- 注册的点击事件
- (void)registerBtnClick {
    JKRegisterVC *rVC = [[JKRegisterVC alloc] init];
    [self.navigationController pushViewController:rVC animated:YES];
}

@end

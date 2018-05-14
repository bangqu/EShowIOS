//
//  JKForgetPwdVC.m
//  EShow
//
//  Created by 周家康 on 2018/5/9.
//  Copyright © 2018年 周家康. All rights reserved.
//

#import "JKForgetPwdVC.h"
#import "JKForgetPwdView.h"

@interface JKForgetPwdVC ()<JKForgetPwdViewDelegate>

@end

@implementation JKForgetPwdVC

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"忘记密码";
    
    JKForgetPwdView *rV = [[JKForgetPwdView alloc] init];
    rV.delegate = self;
    rV.backgroundColor = kWhiteColor;
    [self.view addSubview:rV];
    [rV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.safeAreaTopView.mas_bottom).offset(SCALE_SIZE(10));
        make.left.right.bottom.equalTo(self.view);
    }];
}

#pragma mark -- JKForgetPwdViewDelegate
- (void)popLoginVC {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.navigationController popViewControllerAnimated:YES];
    });
}
@end

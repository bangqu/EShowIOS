//
//  JKRegisterVC.m
//  EShow
//
//  Created by 周家康 on 2018/5/9.
//  Copyright © 2018年 周家康. All rights reserved.
//

#import "JKRegisterVC.h"
#import "JKRegisterView.h"

@interface JKRegisterVC ()<JKRegisterViewDelegate>

@end

@implementation JKRegisterVC

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"注册";
    
    JKRegisterView *rV = [[JKRegisterView alloc] init];
    rV.backgroundColor = kWhiteColor;
    [self.view addSubview:rV];
    [rV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.safeAreaTopView.mas_bottom).offset(SCALE_SIZE(10));
        make.left.right.bottom.equalTo(self.view);
    }];
}

#pragma mark -- JKRegisterViewDelegate
- (void)popLoginVC {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.navigationController popViewControllerAnimated:YES];
    });
}

@end

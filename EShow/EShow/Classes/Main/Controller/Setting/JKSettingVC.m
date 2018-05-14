//
//  JKSettingVC.m
//  EShow
//
//  Created by 周家康 on 2018/5/10.
//  Copyright © 2018年 周家康. All rights reserved.
//

#import "JKSettingVC.h"
#import "JKSettingView.h"
#import "JKAccountSecurityVC.h"

@interface JKSettingVC () <JKSettingViewDelegate>

@end

@implementation JKSettingVC

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"设置";
    
    JKSettingView *sV = [[JKSettingView alloc] init];
    sV.delegate = self;
    [self.view addSubview:sV];
    [sV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.safeAreaTopView.mas_bottom);
        make.left.right.bottom.equalTo(self.view);
    }];
}

#pragma mark -- 账号与安全
- (void)pushAccountSecurityVC {
    JKAccountSecurityVC *asVC = [[JKAccountSecurityVC alloc] init];
    [self.navigationController pushViewController:asVC animated:YES];
}







@end

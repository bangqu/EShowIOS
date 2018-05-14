//
//  JKBindPhoneVC.m
//  EShow
//
//  Created by 周家康 on 2018/5/9.
//  Copyright © 2018年 周家康. All rights reserved.
//

#import "JKBindPhoneVC.h"
#import "JKBindPhoneView.h"

@interface JKBindPhoneVC ()

@end

@implementation JKBindPhoneVC

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"绑定手机号";
    
    JKBindPhoneView *bpV = [[JKBindPhoneView alloc] init];
    bpV.backgroundColor = kWhiteColor;
    [self.view addSubview:bpV];
    [bpV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.safeAreaTopView.mas_bottom).offset(SCALE_SIZE(10));
        make.left.right.bottom.equalTo(self.view);
    }];
}

@end

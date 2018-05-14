//
//  JKModifyPwdVC.m
//  EShow
//
//  Created by 周家康 on 2018/5/10.
//  Copyright © 2018年 周家康. All rights reserved.
//

#import "JKModifyPwdVC.h"
#import "JKModifyPwdView.h"

@interface JKModifyPwdVC ()

@end

@implementation JKModifyPwdVC

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"修改密码";
    
    JKModifyPwdView *mpV = [[JKModifyPwdView alloc] init];
//    mpV.delegate = self;
    mpV.backgroundColor = kWhiteColor;
    [self.view addSubview:mpV];
    [mpV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.safeAreaTopView.mas_bottom).offset(SCALE_SIZE(10));
        make.left.right.bottom.equalTo(self.view);
    }];
}



@end

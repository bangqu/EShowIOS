//
//  JKModifyPwdView.m
//  EShow
//
//  Created by 周家康 on 2018/5/10.
//  Copyright © 2018年 周家康. All rights reserved.
//

#import "JKModifyPwdView.h"
#import "JKModifyPwdVM.h"

@interface JKModifyPwdView ()
@property (nonatomic, strong) UITextField *oldPwdTF;
@property (nonatomic, strong) UITextField *nPwdTF;
@property (nonatomic, strong) UITextField *againPwdTF;
@property (nonatomic, strong) UIButton *submitBtn;
@end

@implementation JKModifyPwdView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}

#pragma mark -- 忘记密码界面
- (void)createUI {
    UITextField *oldPwdTF = [[UITextField alloc] init];
    oldPwdTF.placeholder = @"请输入原密码";
    oldPwdTF.textColor = kBlackColor;
    oldPwdTF.textAlignment = NSTextAlignmentLeft;
    oldPwdTF.secureTextEntry = YES;
    oldPwdTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    [oldPwdTF addTarget:self action:@selector(textFieldChanged) forControlEvents:UIControlEventEditingChanged];
    [self addSubview:oldPwdTF];
    [oldPwdTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(SCALE_SIZE(20));
        make.left.equalTo(self).offset(SCALE_SIZE(34));
        make.right.equalTo(self).offset(SCALE_SIZE(-34));
        make.height.mas_equalTo(SCALE_SIZE(20));
    }];
    self.oldPwdTF = oldPwdTF;
    
    UILabel *onLineLb = [[UILabel alloc] init];
    onLineLb.backgroundColor = RGBHex(0xdfdfdf);
    [self addSubview:onLineLb];
    [onLineLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(oldPwdTF.mas_bottom).offset(14);
        make.left.equalTo(oldPwdTF.mas_left);
        make.right.equalTo(oldPwdTF.mas_right);
        make.height.mas_equalTo(1);
    }];
    
    UITextField *nPwdTF = [[UITextField alloc] init];
    nPwdTF.placeholder = @"请输入新密码";
    nPwdTF.textColor = kBlackColor;
    nPwdTF.textAlignment = NSTextAlignmentLeft;
    nPwdTF.secureTextEntry = YES;
    nPwdTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    [nPwdTF addTarget:self action:@selector(textFieldChanged) forControlEvents:UIControlEventEditingChanged];
    [self addSubview:nPwdTF];
    [nPwdTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(onLineLb.mas_bottom).offset(SCALE_SIZE(20));
        make.left.equalTo(onLineLb.mas_left);
        make.right.equalTo(onLineLb.mas_right);
        make.height.mas_equalTo(SCALE_SIZE(20));
    }];
    self.nPwdTF = nPwdTF;
    
    UILabel *naLineLb = [[UILabel alloc] init];
    naLineLb.backgroundColor = RGBHex(0xdfdfdf);
    [self addSubview:naLineLb];
    [naLineLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(nPwdTF.mas_bottom).offset(14);
        make.left.equalTo(nPwdTF.mas_left);
        make.right.equalTo(self).offset(SCALE_SIZE(-34));
        make.height.mas_equalTo(1);
    }];
    
    UITextField *againPwdTF = [[UITextField alloc] init];
    againPwdTF.placeholder = @"请再次输入新密码";
    againPwdTF.textColor = kBlackColor;
    againPwdTF.textAlignment = NSTextAlignmentLeft;
    againPwdTF.secureTextEntry = YES;
    againPwdTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    [againPwdTF addTarget:self action:@selector(textFieldChanged) forControlEvents:UIControlEventEditingChanged];
    [self addSubview:againPwdTF];
    [againPwdTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(naLineLb.mas_bottom).offset(SCALE_SIZE(20));
        make.left.equalTo(naLineLb.mas_left);
        make.right.equalTo(naLineLb.mas_right);
        make.height.mas_equalTo(SCALE_SIZE(20));
    }];
    self.againPwdTF = againPwdTF;
    
    UILabel *asLineLb = [[UILabel alloc] init];
    asLineLb.backgroundColor = RGBHex(0xdfdfdf);
    [self addSubview:asLineLb];
    [asLineLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(againPwdTF.mas_bottom).offset(14);
        make.left.equalTo(againPwdTF.mas_left);
        make.right.equalTo(self).offset(SCALE_SIZE(-34));
        make.height.mas_equalTo(1);
    }];
    
    
    UIButton *submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [submitBtn setTitle:@"提 交" forState:UIControlStateNormal];
    [submitBtn setTitleColor:kWhiteColor forState:UIControlStateNormal];
    [submitBtn addTarget:self action:@selector(submitBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    submitBtn.titleLabel.font = [UIFont systemFontOfSize:17];
    submitBtn.backgroundColor = RGB(37, 152, 253);
    submitBtn.layer.cornerRadius = 4.0f;
    submitBtn.layer.masksToBounds = YES;
    submitBtn.alpha = 0.5;
    submitBtn.userInteractionEnabled = NO;
    [self addSubview:submitBtn];
    [submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(asLineLb.mas_bottom).offset(SCALE_SIZE(40));
        make.left.equalTo(self).offset(SCALE_SIZE(34));
        make.right.equalTo(self).offset(SCALE_SIZE(-34));
        make.height.mas_equalTo(SCALE_SIZE(44));
    }];
    self.submitBtn = submitBtn;
}

#pragma mark -- 提交的点击事件
- (void)submitBtnClick:(UIButton *)btn {
    if ([self.oldPwdTF.text isEqualToString:self.nPwdTF.text]) {
        [YJProgressHUD showMessage:@"原密码和新密码不能一样" inView:self afterDelayTime:2];
        return;
    }
    
    if (![self.nPwdTF.text isEqualToString:self.againPwdTF.text]) {
        [YJProgressHUD showMessage:@"请输入相同的新密码" inView:self afterDelayTime:2];
        return;
    }
    
    [YJProgressHUD showProgressCircleNoValue:@"提交中..." inView:self];
    JKModifyPwdVM *mpVC = [[JKModifyPwdVM alloc] init];
    mpVC.oldPwdStr = self.oldPwdTF.text;
    mpVC.nPwdStr = self.nPwdTF.text;
    mpVC.againPwdStr = self.againPwdTF.text;
    [mpVC modifyPwdRequestWithSuccessBlock:^(id returnValue) {
        [YJProgressHUD hide];
        if ([returnValue[kStatus] integerValue] == 1) {
            [YJProgressHUD showMessage:returnValue[kMsg] inView:self afterDelayTime:1];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                JKLoginVC *lVC = [[JKLoginVC alloc] init];
                lVC.isRootVC = YES;
                JKNavigationVC *navigationVC = [[JKNavigationVC alloc] initWithRootViewController:lVC];
                UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
                [window setRootViewController:navigationVC];
            });
        } else {
            [YJProgressHUD showMsgWithImage:returnValue[kMsg] imageName:iFailPath inview:self];
        }
    } withFailureBlock:^(id errorCode) {
        [YJProgressHUD hide];
    }];
}

#pragma mark --  监听UITextField
- (void)textFieldChanged {
    if ([self.oldPwdTF.text trimmingCharacters].length > 20) {
        NSString *str = [self.oldPwdTF.text substringToIndex:20];
        self.oldPwdTF.text = str;
        return;
    }
    
    if ([self.nPwdTF.text trimmingCharacters].length > 20) {
        NSString *str = [self.nPwdTF.text substringToIndex:20];
        self.nPwdTF.text = str;
        return;
    }
    
    if ([self.againPwdTF.text trimmingCharacters].length > 20) {
        NSString *str = [self.againPwdTF.text substringToIndex:20];
        self.againPwdTF.text = str;
        return;
    }
    
    if ([self.oldPwdTF.text trimmingCharacters].length >= 6 && [self.nPwdTF.text trimmingCharacters].length >= 6 && [self.againPwdTF.text trimmingCharacters].length >= 6) {
        self.submitBtn.alpha = 1;
        self.submitBtn.userInteractionEnabled = YES;
    } else {
        self.submitBtn.alpha = 0.5;
        self.submitBtn.userInteractionEnabled = NO;
    }
}








@end

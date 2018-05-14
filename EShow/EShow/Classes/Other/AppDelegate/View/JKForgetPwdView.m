//
//  JKForgetPwdView.m
//  EShow
//
//  Created by 周家康 on 2018/5/9.
//  Copyright © 2018年 周家康. All rights reserved.
//

#import "JKForgetPwdView.h"
#import "JKForgetPwdVM.h"

@interface JKForgetPwdView()
@property (nonatomic, strong) UITextField *phoneTF;
@property (nonatomic, strong) UITextField *codeTF;
@property (nonatomic, strong) UITextField *pwdTF;
@property (nonatomic, strong) UITextField *nPwdTF;
@property (nonatomic, strong) UIButton *verificationBtn;
@property (nonatomic, strong) UIButton *submitBtn;
@property (nonatomic, strong) JKForgetPwdVM *fpVM;
@end

@implementation JKForgetPwdView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.fpVM = [[JKForgetPwdVM alloc] init];
        [self createUI];
    }
    return self;
}

#pragma mark -- 忘记密码界面
- (void)createUI {
    UILabel *codeLb = [[UILabel alloc] init];
    codeLb.text = @"+86";
    codeLb.textColor = kBlackColor;
    codeLb.font = [UIFont systemFontOfSize:17];
    [self addSubview:codeLb];
    [codeLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(SCALE_SIZE(20));
        make.left.equalTo(self).offset(SCALE_SIZE(34));
        make.size.mas_equalTo(CGSizeMake(SCALE_SIZE(40), SCALE_SIZE(20)));
    }];
    
    UITextField *phoneTF = [[UITextField alloc] init];
    phoneTF.placeholder = @"请输入手机号码";
    phoneTF.keyboardType = UIKeyboardTypeNumberPad;
    phoneTF.textColor = kBlackColor;
    phoneTF.textAlignment = NSTextAlignmentLeft;
    phoneTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    [phoneTF addTarget:self action:@selector(textFieldChanged) forControlEvents:UIControlEventEditingChanged];
    [self addSubview:phoneTF];
    [phoneTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(SCALE_SIZE(20));
        make.left.equalTo(codeLb.mas_right).offset(SCALE_SIZE(10));
        make.right.equalTo(self).offset(SCALE_SIZE(-34));
        make.height.mas_equalTo(SCALE_SIZE(20));
    }];
    self.phoneTF = phoneTF;
    
    UILabel *pvLineLb = [[UILabel alloc] init];
    pvLineLb.backgroundColor = RGBHex(0xdfdfdf);
    [self addSubview:pvLineLb];
    [pvLineLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(codeLb.mas_bottom).offset(14);
        make.left.equalTo(codeLb.mas_left);
        make.right.equalTo(self).offset(SCALE_SIZE(-34));
        make.height.mas_equalTo(1);
    }];
    
    UIButton *verificationBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [verificationBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [verificationBtn setTitleColor:RGBHex(0xBBBBBB) forState:UIControlStateNormal];
    [verificationBtn addTarget:self action:@selector(verificationBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    verificationBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    verificationBtn.backgroundColor = RGBHex(0xF7F7F7);
    verificationBtn.layer.cornerRadius = 15;
    verificationBtn.layer.masksToBounds = YES;
    [self addSubview:verificationBtn];
    [verificationBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(pvLineLb.mas_bottom).offset(SCALE_SIZE(20));
        make.right.equalTo(self).offset(SCALE_SIZE(-34));
        make.size.mas_equalTo(CGSizeMake(105, 30));
    }];
    self.verificationBtn = verificationBtn;
    
    UITextField *codeTF = [[UITextField alloc] init];
    codeTF.placeholder = @"请输入验证码";
    codeTF.keyboardType = UIKeyboardTypeNumberPad;
    codeTF.textColor = kBlackColor;
    codeTF.textAlignment = NSTextAlignmentLeft;
    codeTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    [codeTF addTarget:self action:@selector(textFieldChanged) forControlEvents:UIControlEventEditingChanged];
    [self addSubview:codeTF];
    [codeTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(verificationBtn.mas_centerY);
        make.left.equalTo(pvLineLb.mas_left);
        make.right.equalTo(verificationBtn.mas_left).offset(SCALE_SIZE(-10));
        make.height.mas_equalTo(SCALE_SIZE(20));
    }];
    self.codeTF = codeTF;
    
    UILabel *vpLineLb = [[UILabel alloc] init];
    vpLineLb.backgroundColor = RGBHex(0xdfdfdf);
    [self addSubview:vpLineLb];
    [vpLineLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(codeTF.mas_bottom).offset(14);
        make.left.equalTo(codeTF.mas_left);
        make.right.equalTo(self).offset(SCALE_SIZE(-34));
        make.height.mas_equalTo(1);
    }];
    
    UITextField *pwdTF = [[UITextField alloc] init];
    pwdTF.placeholder = @"请输入新密码";
    pwdTF.textColor = kBlackColor;
    pwdTF.textAlignment = NSTextAlignmentLeft;
    pwdTF.secureTextEntry = YES;
    pwdTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    [pwdTF addTarget:self action:@selector(textFieldChanged) forControlEvents:UIControlEventEditingChanged];
    [self addSubview:pwdTF];
    [pwdTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(vpLineLb.mas_bottom).offset(SCALE_SIZE(30));
        make.left.equalTo(vpLineLb.mas_left);
        make.right.equalTo(vpLineLb.mas_right);
        make.height.mas_equalTo(SCALE_SIZE(20));
    }];
    self.pwdTF = pwdTF;
    
    UILabel *pwdLineLb = [[UILabel alloc] init];
    pwdLineLb.backgroundColor = RGBHex(0xdfdfdf);
    [self addSubview:pwdLineLb];
    [pwdLineLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(pwdTF.mas_bottom).offset(14);
        make.left.equalTo(pwdTF.mas_left);
        make.right.equalTo(self).offset(SCALE_SIZE(-34));
        make.height.mas_equalTo(1);
    }];
    
    UITextField *nPwdTF = [[UITextField alloc] init];
    nPwdTF.placeholder = @"请再次输入新密码";
    nPwdTF.textColor = kBlackColor;
    nPwdTF.textAlignment = NSTextAlignmentLeft;
    nPwdTF.secureTextEntry = YES;
    nPwdTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    [nPwdTF addTarget:self action:@selector(textFieldChanged) forControlEvents:UIControlEventEditingChanged];
    [self addSubview:nPwdTF];
    [nPwdTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(pwdLineLb.mas_bottom).offset(SCALE_SIZE(20));
        make.left.equalTo(pwdLineLb.mas_left);
        make.right.equalTo(pwdLineLb.mas_right);
        make.height.mas_equalTo(SCALE_SIZE(20));
    }];
    self.nPwdTF = nPwdTF;
    
    UILabel *ptLineLb = [[UILabel alloc] init];
    ptLineLb.backgroundColor = RGBHex(0xdfdfdf);
    [self addSubview:ptLineLb];
    [ptLineLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(nPwdTF.mas_bottom).offset(14);
        make.left.equalTo(nPwdTF.mas_left);
        make.right.equalTo(self).offset(SCALE_SIZE(-34));
        make.height.mas_equalTo(1);
    }];
    
    UILabel *tipsLb = [[UILabel alloc] init];
    tipsLb.text = @"密码长度为6-20位，字母或数字";
    tipsLb.textColor = kLightGrayColor;
    tipsLb.textAlignment = NSTextAlignmentLeft;
    tipsLb.font = [UIFont systemFontOfSize:13];
    [self addSubview:tipsLb];
    [tipsLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ptLineLb.mas_bottom).offset(SCALE_SIZE(7));
        make.left.equalTo(ptLineLb.mas_left);
        make.right.equalTo(ptLineLb.mas_right);
        make.height.mas_equalTo(SCALE_SIZE(20));
    }];
    
    UIButton *submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [submitBtn setTitle:@"提 交" forState:UIControlStateNormal];
    [submitBtn setTitleColor:kWhiteColor forState:UIControlStateNormal];
    submitBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    submitBtn.layer.cornerRadius = 8;
    submitBtn.layer.masksToBounds = YES;
    submitBtn.alpha = 0.5;
    submitBtn.userInteractionEnabled = NO;
    submitBtn.backgroundColor = kTextBaseColor;
    [submitBtn addTarget:self action:@selector(submitBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:submitBtn];
    [submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(tipsLb.mas_bottom).offset(SCALE_SIZE(40));
        make.left.right.equalTo(ptLineLb);
        make.height.mas_equalTo(SCALE_SIZE(44));
    }];
    self.submitBtn = submitBtn;
}

#pragma mark -- 提交
- (void)submitBtnClick:(UIButton *)btn {
    if (![self.pwdTF.text isEqualToString:self.nPwdTF.text]) {
        [YJProgressHUD showMessage:@"请输入相同的新密码" inView:self afterDelayTime:2];
        return;
    }
    
    [YJProgressHUD showProgressCircleNoValue:@"提交中..." inView:self];
    self.fpVM.phoneStr = self.phoneTF.text;
    self.fpVM.codeStr = self.codeTF.text;
    self.fpVM.pwdStr = self.pwdTF.text;
    self.fpVM.npwdStr = self.nPwdTF.text;
    [self.fpVM submitRequestWithSuccessBlock:^(id returnValue) {
        [YJProgressHUD hide];
        if ([returnValue[kStatus] integerValue] == 1) {
            [YJProgressHUD showMessage:returnValue[kMsg] inView:self afterDelayTime:1];
            if ([_delegate respondsToSelector:@selector(popLoginVC)]) {
                [_delegate popLoginVC];
            }
        } else {
            [YJProgressHUD showMsgWithImage:returnValue[kMsg] imageName:iFailPath inview:self];
        }
    } withFailureBlock:^(id errorCode) {
        [YJProgressHUD hide];
    }];
}

#pragma mark -- 验证码点击事件
- (void)verificationBtnClick:(UIButton *)btn {
    if (self.phoneTF.text.length != 11) {
        [YJProgressHUD showMessage:@"请输入正确的手机号码" inView:self afterDelayTime:2];
        return;
    }
    
    [YJProgressHUD showProgressCircleNoValue:@"发送中..." inView:self];
    self.fpVM.phoneStr = self.phoneTF.text;
    self.fpVM.verificationBtn = self.verificationBtn;
    [self.fpVM verificationRequestWithSuccessBlock:^(id returnValue) {
        [YJProgressHUD hide];
        if ([returnValue[kStatus] integerValue] == 1) {
            [YJProgressHUD showMessage:returnValue[kMsg] inView:self afterDelayTime:1];
        } else {
            [YJProgressHUD showMsgWithImage:returnValue[kMsg] imageName:iFailPath inview:self];
        }
    } withFailureBlock:^(id errorCode) {
        [YJProgressHUD hide];
    }];
}

#pragma mark -- 监听textField
- (void)textFieldChanged {
    //手机号11位
    if ([self.phoneTF.text trimmingCharacters].length > 11) {
        NSString *str = [self.phoneTF.text substringToIndex:11];
        self.phoneTF.text = str;
        return;
    }
    
    //验证码6位
    if ([self.codeTF.text trimmingCharacters].length > 6) {
        NSString *str = [self.codeTF.text substringToIndex:6];
        self.codeTF.text = str;
        return;
    }
    
    //密码不能超过20位
    if ([self.pwdTF.text trimmingCharacters].length > 20) {
        NSString *str = [self.pwdTF.text substringToIndex:20];
        self.pwdTF.text = str;
        return;
    }
    
    //密码不能超过20位
    if ([self.nPwdTF.text trimmingCharacters].length > 20) {
        NSString *str = [self.nPwdTF.text substringToIndex:20];
        self.nPwdTF.text = str;
        return;
    }
    
    if ([self.phoneTF.text trimmingCharacters].length == 11 && [self.pwdTF.text trimmingCharacters].length >= 6 && [self.codeTF.text trimmingCharacters].length == 6 && [self.nPwdTF.text trimmingCharacters].length >= 6) {
        self.submitBtn.alpha = 1;
        self.submitBtn.userInteractionEnabled = YES;
    } else {
        self.submitBtn.alpha = 0.5;
        self.submitBtn.userInteractionEnabled = NO;
    }
}


@end

//
//  JKLoginView.m
//  EShow
//
//  Created by 周家康 on 2018/5/8.
//  Copyright © 2018年 周家康. All rights reserved.
//

#import "JKLoginView.h"
#import "JKLoginVM.h"

@interface JKLoginView()
@property (nonatomic, strong) UITextField *phoneTF;
@property (nonatomic, strong) UITextField *pwdTF;
@property (nonatomic, strong) UIButton *loginBtn;
@property (nonatomic, strong) JKLoginVM *lVM;
@end

@implementation JKLoginView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.lVM = [[JKLoginVM alloc] init];
        [self createUI];
    }
    return self;
}

#pragma mark -- 登录界面
- (void)createUI {
    UIImageView *phoneImgV = [[UIImageView alloc] init];
    phoneImgV.image = [UIImage imageNamed:@"phoneNumber"];
    phoneImgV.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:phoneImgV];
    [phoneImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(SCALE_SIZE(24));
        make.left.equalTo(self).offset(SCALE_SIZE(34));
        make.size.mas_equalTo(CGSizeMake(SCALE_SIZE(20), SCALE_SIZE(20)));
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
        make.top.equalTo(self).offset(SCALE_SIZE(24));
        make.left.equalTo(phoneImgV.mas_right).offset(SCALE_SIZE(10));
        make.right.equalTo(self).offset(SCALE_SIZE(-34));
        make.height.mas_equalTo(SCALE_SIZE(20));
    }];
    self.phoneTF = phoneTF;

    UILabel *ppLineLb = [[UILabel alloc] init];
    ppLineLb.backgroundColor = RGBHex(0xdfdfdf);
    [self addSubview:ppLineLb];
    [ppLineLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(phoneImgV.mas_bottom).offset(14);
        make.left.equalTo(phoneImgV.mas_left);
        make.right.equalTo(self).offset(SCALE_SIZE(-34));
        make.height.mas_equalTo(1);
    }];
    
    UIImageView *pwdImgV = [[UIImageView alloc] init];
    pwdImgV.image = [UIImage imageNamed:@"password"];
    pwdImgV.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:pwdImgV];
    [pwdImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ppLineLb.mas_bottom).offset(SCALE_SIZE(24));
        make.left.equalTo(self).offset(SCALE_SIZE(34));
        make.size.mas_equalTo(CGSizeMake(SCALE_SIZE(20), SCALE_SIZE(20)));
    }];
    
    UIButton *forgetPwdBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [forgetPwdBtn setTitle:@"忘记密码？" forState:UIControlStateNormal];
    [forgetPwdBtn setTitleColor:kTextBaseColor forState:UIControlStateNormal];
    forgetPwdBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [forgetPwdBtn addTarget:self action:@selector(forgetPwdBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    forgetPwdBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    forgetPwdBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    [self addSubview:forgetPwdBtn];
    [forgetPwdBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ppLineLb.mas_bottom).offset(SCALE_SIZE(24));
        make.right.equalTo(self).offset(SCALE_SIZE(-34));
        make.size.mas_equalTo(CGSizeMake(SCALE_SIZE(90), SCALE_SIZE(20)));
    }];
    
    UITextField *pwdTF = [[UITextField alloc] init];
    pwdTF.placeholder = @"请输入密码";
    pwdTF.keyboardType = UIKeyboardTypeDefault;
    pwdTF.textColor = kBlackColor;
    pwdTF.textAlignment = NSTextAlignmentLeft;
    pwdTF.secureTextEntry = YES;
    pwdTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    [pwdTF addTarget:self action:@selector(textFieldChanged) forControlEvents:UIControlEventEditingChanged];
    [self addSubview:pwdTF];
    [pwdTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ppLineLb.mas_bottom).offset(SCALE_SIZE(24));
        make.left.equalTo(phoneImgV.mas_right).offset(SCALE_SIZE(10));
        make.right.equalTo(forgetPwdBtn.mas_left);
        make.height.mas_equalTo(SCALE_SIZE(20));
    }];
    self.pwdTF = pwdTF;
    
    UILabel *plLineLb = [[UILabel alloc] init];
    plLineLb.backgroundColor = RGBHex(0xdfdfdf);
    [self addSubview:plLineLb];
    [plLineLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(pwdImgV.mas_bottom).offset(14);
        make.left.equalTo(pwdImgV.mas_left);
        make.right.equalTo(self).offset(SCALE_SIZE(-34));
        make.height.mas_equalTo(1);
    }];
    
    UIButton *loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [loginBtn setTitle:@"登 录" forState:UIControlStateNormal];
    [loginBtn setTitleColor:kWhiteColor forState:UIControlStateNormal];
    loginBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    loginBtn.layer.cornerRadius = 8;
    loginBtn.layer.masksToBounds = YES;
    loginBtn.alpha = 0.5;
    loginBtn.userInteractionEnabled = NO;
    loginBtn.backgroundColor = kTextBaseColor;
    [loginBtn addTarget:self action:@selector(loginBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:loginBtn];
    [loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(plLineLb.mas_bottom).offset(SCALE_SIZE(40));
        make.left.right.equalTo(plLineLb);
        make.height.mas_equalTo(SCALE_SIZE(44));
    }];
    self.loginBtn = loginBtn;
    
    UIButton *verificationLoginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [verificationLoginBtn setTitle:@"验证码登录 >" forState:UIControlStateNormal];
    [verificationLoginBtn setTitleColor:kTextBaseColor forState:UIControlStateNormal];
    verificationLoginBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [verificationLoginBtn addTarget:self action:@selector(verificationLoginBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:verificationLoginBtn];
    [verificationLoginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(loginBtn.mas_bottom).offset(SCALE_SIZE(40));
        make.centerX.equalTo(self.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(SCALE_SIZE(120), SCALE_SIZE(20)));
    }];
    
    UIButton *protolBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [protolBtn setTitle:@"登录即同意《EShow用户使用协议》" forState:UIControlStateNormal];
    [protolBtn setTitleColor:kBlackColor forState:UIControlStateNormal];
    protolBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [protolBtn addTarget:self action:@selector(protolBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:protolBtn];
    [protolBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self).offset(SCALE_SIZE(-30));
        make.centerX.equalTo(self.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, SCALE_SIZE(20)));
    }];
    
    UIButton *qqBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [qqBtn setImage:[UIImage imageNamed:@"qq"] forState:UIControlStateNormal];
    [qqBtn setTitleColor:kLightGrayColor forState:UIControlStateNormal];
    [qqBtn addTarget:self action:@selector(qqBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:qqBtn];
    [qqBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(protolBtn.mas_top).offset(SCALE_SIZE(-15));
        make.right.equalTo(self.mas_centerX).offset(SCALE_SIZE(-15));
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH * 0.3, 62));
    }];
    
    UIButton *weChatBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [weChatBtn setImage:[UIImage imageNamed:@"wx"] forState:UIControlStateNormal];
    [weChatBtn addTarget:self action:@selector(weChatBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:weChatBtn];
    [weChatBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(protolBtn.mas_top).offset(SCALE_SIZE(-15));
        make.left.equalTo(self.mas_centerX).offset(SCALE_SIZE(15));
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH * 0.3, 62));
    }];
}

#pragma mark -- QQ登录
- (void)qqBtnClicked:(UIButton *)btn {
    if ([_delegate respondsToSelector:@selector(pushBindPhoneVC)]) {
        [_delegate pushBindPhoneVC];
    }
}

#pragma mark -- 微信登录
- (void)weChatBtnClicked:(UIButton *)btn {
    if ([_delegate respondsToSelector:@selector(pushBindPhoneVC)]) {
        [_delegate pushBindPhoneVC];
    }
}

#pragma mark -- 登录
- (void)loginBtnClick:(UIButton *)btn {
    [YJProgressHUD showProgressCircleNoValue:@"登录中..." inView:self];
    self.lVM.phoneStr = self.phoneTF.text;
    self.lVM.pwdStr = self.pwdTF.text;
    [self.lVM loginRequestWithSuccessBlock:^(id returnValue) {
        [YJProgressHUD hide];
        if ([returnValue[kStatus] integerValue] == 1) {
            [YJProgressHUD showMessage:returnValue[kMsg] inView:self afterDelayTime:1];
            if ([_delegate respondsToSelector:@selector(pushMainVC)]) {
                [_delegate pushMainVC];
            }
        } else {
            [YJProgressHUD showMsgWithImage:returnValue[kMsg] imageName:iFailPath inview:self];
        }
    } withFailureBlock:^(id errorCode) {
        [YJProgressHUD hide];
    }];
}

#pragma mark -- 使用协议
- (void)protolBtnClick:(UIButton *)btn {
    [YJProgressHUD showMessage:@"使用协议" inView:self afterDelayTime:1];
}

#pragma mark -- 验证码登录
- (void)verificationLoginBtnClick:(UIButton *)btn {
    if ([_delegate respondsToSelector:@selector(pushVerificationLoginVC)]) {
        [_delegate pushVerificationLoginVC];
    }
}

#pragma mark -- 忘记密码
- (void)forgetPwdBtnClick:(UIButton *)btn {
    if ([_delegate respondsToSelector:@selector(pushForgetPwdVC)]) {
        [_delegate pushForgetPwdVC];
    }
}

#pragma mark -- 监听UITextField
- (void)textFieldChanged {
    //手机号11位
    if ([self.phoneTF.text trimmingCharacters].length > 11) {
        NSString *str = [self.phoneTF.text substringToIndex:11];
        self.phoneTF.text = str;
        return;
    }
    
    //密码不能超过20位
    if ([self.pwdTF.text trimmingCharacters].length > 20) {
        NSString *str = [self.pwdTF.text substringToIndex:20];
        self.pwdTF.text = str;
        return;
    }
    
    //手机号满11位，放弃第一响应者
    if ([self.phoneTF.text trimmingCharacters].length == 11) {
        [self.phoneTF resignFirstResponder];
        [self.pwdTF becomeFirstResponder];
    }
    
    if ([self.phoneTF.text trimmingCharacters].length == 11 && [self.pwdTF.text trimmingCharacters].length >= 6) {
        self.loginBtn.alpha = 1;
        self.loginBtn.userInteractionEnabled = YES;
    } else {
        self.loginBtn.alpha = 0.5;
        self.loginBtn.userInteractionEnabled = NO;
    }
}

@end

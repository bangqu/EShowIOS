//
//  JKVerificationLoginView.m
//  EShow
//
//  Created by 周家康 on 2018/5/9.
//  Copyright © 2018年 周家康. All rights reserved.
//

#import "JKVerificationLoginView.h"
#import "JKVerificationLoginVM.h"

@interface JKVerificationLoginView()
@property (nonatomic, strong) UITextField *phoneTF;
@property (nonatomic, strong) UITextField *codeTF;
@property (nonatomic, strong) UIButton *verificationBtn;
@property (nonatomic, strong) UIButton *loginBtn;
@property (nonatomic, strong) JKVerificationLoginVM *vlVM;
@end

@implementation JKVerificationLoginView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.vlVM = [[JKVerificationLoginVM alloc] init];
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
    
    UILabel *pvLineLb = [[UILabel alloc] init];
    pvLineLb.backgroundColor = RGBHex(0xdfdfdf);
    [self addSubview:pvLineLb];
    [pvLineLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(phoneImgV.mas_bottom).offset(14);
        make.left.equalTo(phoneImgV.mas_left);
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
    
    UIImageView *pwdImgV = [[UIImageView alloc] init];
    pwdImgV.image = [UIImage imageNamed:@"password"];
    pwdImgV.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:pwdImgV];
    [pwdImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(verificationBtn.mas_centerY);
        make.left.equalTo(self).offset(SCALE_SIZE(34));
        make.size.mas_equalTo(CGSizeMake(SCALE_SIZE(20), SCALE_SIZE(20)));
    }];
    
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
        make.left.equalTo(pwdImgV.mas_right).offset(SCALE_SIZE(10));
        make.right.equalTo(verificationBtn.mas_left).offset(SCALE_SIZE(-10));
        make.height.mas_equalTo(SCALE_SIZE(20));
    }];
    self.codeTF = codeTF;
    
    UILabel *vlLineLb = [[UILabel alloc] init];
    vlLineLb.backgroundColor = RGBHex(0xdfdfdf);
    [self addSubview:vlLineLb];
    [vlLineLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(codeTF.mas_bottom).offset(14);
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
        make.top.equalTo(vlLineLb.mas_bottom).offset(SCALE_SIZE(40));
        make.left.right.equalTo(vlLineLb);
        make.height.mas_equalTo(SCALE_SIZE(44));
    }];
    self.loginBtn = loginBtn;
    
}

#pragma mark -- 登录点击事件
- (void)loginBtnClick:(UIButton *)btn {
    [YJProgressHUD showProgressCircleNoValue:@"登录中..." inView:self];
    self.vlVM.phoneStr = self.phoneTF.text;
    self.vlVM.codeStr = self.codeTF.text;
    [self.vlVM loginRequestWithSuccessBlock:^(id returnValue) {
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

#pragma mark -- 验证码点击事件
- (void)verificationBtnClick:(UIButton *)btn {
    if (self.phoneTF.text.length != 11) {
        [YJProgressHUD showMessage:@"请输入正确的手机号码" inView:self afterDelayTime:2];
        return;
    }
    
    [YJProgressHUD showProgressCircleNoValue:@"发送中..." inView:self];
    self.vlVM.phoneStr = self.phoneTF.text;
    self.vlVM.verificationBtn = self.verificationBtn;
    [self.vlVM verificationRequestWithSuccessBlock:^(id returnValue) {
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

#pragma mark -- 监听UITextField
- (void)textFieldChanged {
    //手机号11位
    if ([self.phoneTF.text trimmingCharacters].length > 11) {
        NSString *str = [self.phoneTF.text substringToIndex:11];
        self.phoneTF.text = str;
        return;
    }
    
    //验证码不能超过6位
    if ([self.codeTF.text trimmingCharacters].length > 6) {
        NSString *str = [self.codeTF.text substringToIndex:6];
        self.codeTF.text = str;
        return;
    }
    
    if ([self.phoneTF.text trimmingCharacters].length == 11 && [self.codeTF.text trimmingCharacters].length == 6) {
        self.loginBtn.alpha = 1;
        self.loginBtn.userInteractionEnabled = YES;
    } else {
        self.loginBtn.alpha = 0.5;
        self.loginBtn.userInteractionEnabled = NO;
    }
}

@end

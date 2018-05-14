//
//  JKRegisterView.m
//  EShow
//
//  Created by 周家康 on 2018/5/9.
//  Copyright © 2018年 周家康. All rights reserved.
//

#import "JKRegisterView.h"
#import "JKRegisterVM.h"

@interface JKRegisterView()
@property (nonatomic, strong) UITextField *phoneTF;
@property (nonatomic, strong) UITextField *pwdTF;
@property (nonatomic, strong) UITextField *codeTF;
@property (nonatomic, strong) UIButton *verificationBtn;
@property (nonatomic, strong) UIButton *registerBtn;
@property (nonatomic, strong) JKRegisterVM *rVM;
@end

@implementation JKRegisterView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.rVM = [[JKRegisterVM alloc] init];
        [self createUI];
    }
    return self;
}

#pragma mark -- 注册界面
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
    pwdTF.placeholder = @"请输入密码";
    pwdTF.keyboardType = UIKeyboardTypeDefault;
    pwdTF.textColor = kBlackColor;
    pwdTF.textAlignment = NSTextAlignmentLeft;
    pwdTF.secureTextEntry = YES;
    pwdTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    [pwdTF addTarget:self action:@selector(textFieldChanged) forControlEvents:UIControlEventEditingChanged];
    [self addSubview:pwdTF];
    [pwdTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(vpLineLb.mas_bottom).offset(SCALE_SIZE(20));
        make.left.equalTo(vpLineLb.mas_left);
        make.right.equalTo(vpLineLb.mas_right);
        make.height.mas_equalTo(SCALE_SIZE(20));
    }];
    self.pwdTF = pwdTF;
    
    UILabel *prLineLb = [[UILabel alloc] init];
    prLineLb.backgroundColor = RGBHex(0xdfdfdf);
    [self addSubview:prLineLb];
    [prLineLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(pwdTF.mas_bottom).offset(14);
        make.left.equalTo(pwdTF.mas_left);
        make.right.equalTo(self).offset(SCALE_SIZE(-34));
        make.height.mas_equalTo(1);
    }];
    
    UIButton *registerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [registerBtn setTitle:@"注 册" forState:UIControlStateNormal];
    [registerBtn setTitleColor:kWhiteColor forState:UIControlStateNormal];
    registerBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    registerBtn.layer.cornerRadius = 8;
    registerBtn.layer.masksToBounds = YES;
    registerBtn.alpha = 0.5;
    registerBtn.userInteractionEnabled = NO;
    registerBtn.backgroundColor = kTextBaseColor;
    [registerBtn addTarget:self action:@selector(registerBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:registerBtn];
    [registerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(prLineLb.mas_bottom).offset(SCALE_SIZE(40));
        make.left.right.equalTo(prLineLb);
        make.height.mas_equalTo(SCALE_SIZE(44));
    }];
    self.registerBtn = registerBtn;
    
    UIButton *protolBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [protolBtn setTitle:@"我已同意EShow使用协议" forState:UIControlStateNormal];
    [protolBtn setTitleColor:kTextBaseColor forState:UIControlStateNormal];
    protolBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [protolBtn addTarget:self action:@selector(protolBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:protolBtn];
    [protolBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(registerBtn.mas_bottom).offset(SCALE_SIZE(20));
        make.centerX.equalTo(registerBtn.mas_centerX);
        make.left.right.equalTo(self);
    }];
}

#pragma mark -- 注册点击事件
- (void)registerBtnClick:(UIButton *)btn {
    [YJProgressHUD showProgressCircleNoValue:@"注册中..." inView:self];
    self.rVM.phoneStr = self.phoneTF.text;
    self.rVM.codeStr = self.codeTF.text;
    self.rVM.pwdStr = self.pwdTF.text;
    [self.rVM registerRequestWithSuccessBlock:^(id returnValue) {
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

#pragma mark -- 协议点击事件
- (void)protolBtnClick:(UIButton *)btn {
    [YJProgressHUD showMessage:@"使用协议" inView:self afterDelayTime:1];
}

#pragma mark -- 验证码点击事件
- (void)verificationBtnClick:(UIButton *)btn {
    if (self.phoneTF.text.length != 11) {
        [YJProgressHUD showMessage:@"请输入正确的手机号码" inView:self afterDelayTime:2];
        return;
    }
    
    [YJProgressHUD showProgressCircleNoValue:@"发送中..." inView:self];
    self.rVM.phoneStr = self.phoneTF.text;
    self.rVM.verificationBtn = self.verificationBtn;
    [self.rVM verificationRequestWithSuccessBlock:^(id returnValue) {
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
    //密码不能超过20位
    if ([self.pwdTF.text trimmingCharacters].length > 20) {
        NSString *str = [self.pwdTF.text substringToIndex:20];
        self.pwdTF.text = str;
        return;
    }
    //验证码达到6位，放弃第一响应者
    if ([self.codeTF.text trimmingCharacters].length == 6) {
        [self.codeTF resignFirstResponder];
        [self.pwdTF becomeFirstResponder];
    }
    //验证码6位
    if ([self.codeTF.text trimmingCharacters].length > 6) {
        NSString *str = [self.codeTF.text substringToIndex:6];
        self.codeTF.text = str;
        return;
    }
    
    if ([self.phoneTF.text trimmingCharacters].length == 11 && [self.pwdTF.text trimmingCharacters].length >= 6 && [self.codeTF.text trimmingCharacters].length == 6) {
        self.registerBtn.alpha = 1;
        self.registerBtn.userInteractionEnabled = YES;
    } else {
        self.registerBtn.alpha = 0.5;
        self.registerBtn.userInteractionEnabled = NO;
    }
}

@end

//
//  JKBindPhoneView.m
//  EShow
//
//  Created by 周家康 on 2018/5/9.
//  Copyright © 2018年 周家康. All rights reserved.
//

#import "JKBindPhoneView.h"
@interface JKBindPhoneView()
@property (nonatomic, strong) UITextField *phoneTF;
@property (nonatomic, strong) UITextField *codeTF;
@property (nonatomic, strong) UIButton *verificationBtn;
@property (nonatomic, strong) UIButton *submitBtn;
@end

@implementation JKBindPhoneView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}

#pragma mark -- 绑定手机界面
- (void)createUI {
    UIImageView *phoneImgV = [[UIImageView alloc] init];
    phoneImgV.image = [UIImage imageNamed:@"ic_login_linkphone"];
    phoneImgV.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:phoneImgV];
    [phoneImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(SCALE_SIZE(45));
        make.centerX.equalTo(self.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(SCALE_SIZE(30), SCALE_SIZE(45)));
    }];
    
    UILabel *tipsLb = [[UILabel alloc] init];
    tipsLb.text = @"绑定手机之后，开启EShow功能之旅";
    tipsLb.textColor = kLightGrayColor;
    tipsLb.textAlignment = NSTextAlignmentCenter;
    tipsLb.font = [UIFont systemFontOfSize:15];
    [self addSubview:tipsLb];
    [tipsLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(phoneImgV.mas_bottom).offset(SCALE_SIZE(15));
        make.left.right.equalTo(self);
        make.height.mas_equalTo(20);
    }];
    
    UILabel *codeLb = [[UILabel alloc] init];
    codeLb.text = @"+86";
    codeLb.textColor = kBlackColor;
    codeLb.font = [UIFont systemFontOfSize:17];
    [self addSubview:codeLb];
    [codeLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(tipsLb.mas_bottom).offset(SCALE_SIZE(64));
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
        make.top.equalTo(tipsLb.mas_bottom).offset(SCALE_SIZE(64));
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
        make.top.equalTo(vpLineLb.mas_bottom).offset(SCALE_SIZE(40));
        make.left.right.equalTo(vpLineLb);
        make.height.mas_equalTo(SCALE_SIZE(44));
    }];
    self.submitBtn = submitBtn;
}

#pragma mark -- 提交点击事件
- (void)submitBtnClick:(UIButton *)btn {
    
}

#pragma mark -- 验证码点击事件
- (void)verificationBtnClick:(UIButton *)btn {
    
}

#pragma mark -- 监听textField
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
        self.submitBtn.alpha = 1;
        self.submitBtn.userInteractionEnabled = YES;
    } else {
        self.submitBtn.alpha = 0.5;
        self.submitBtn.userInteractionEnabled = NO;
    }
}

@end

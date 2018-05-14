//
//  JKIntroVC.m
//  EShow
//
//  Created by 周家康 on 2018/5/10.
//  Copyright © 2018年 周家康. All rights reserved.
//

#import "JKIntroVC.h"
#import "JKUpdateUserInfoVM.h"

@interface JKIntroVC () <UITextFieldDelegate>
@property (nonatomic, strong) UITextField *introTF;

@end

@implementation JKIntroVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"个性签名";
    [self createIntroVCUI];
}

- (void)createIntroVCUI {
    UIView *bgView = [[UIView alloc] init];
    bgView.backgroundColor = kWhiteColor;
    [self.view addSubview:bgView];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.safeAreaTopView.mas_bottom).offset(SCALE_SIZE(15));
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(SCALE_SIZE(48));
    }];
    
    UITextField *introTF = [[UITextField alloc] init];
    introTF.text = self.introStr;
    introTF.placeholder = @"请输入您的个性签名";
    [introTF setValue:kGrayColor forKeyPath:@"_placeholderLabel.textColor"];
    introTF.textColor = kTextBaseColor;
    introTF.textAlignment = NSTextAlignmentLeft;
    introTF.font = [UIFont systemFontOfSize:17];
    introTF.delegate = self;
    introTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    [introTF addTarget:self action:@selector(textFieldChanged) forControlEvents:UIControlEventEditingChanged];
    [bgView addSubview:introTF];
    [introTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bgView.mas_top);
        make.bottom.equalTo(bgView.mas_bottom);
        make.left.equalTo(bgView.mas_left).offset(SCALE_SIZE(15));
        make.right.equalTo(bgView.mas_right).offset(SCALE_SIZE(-15));
    }];
    self.introTF = introTF;
}

#pragma mark -- 监听textField
- (void)textFieldChanged {
    if ([self.introTF.text trimmingCharacters].length > 0) {
        [self setUpRightBarItem];
    } else {
        self.navigationItem.rightBarButtonItem = nil;
    }
}

#pragma mark -- 保存按钮
- (void)setUpRightBarItem {
    UIButton *saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [saveBtn setTitle:@"保存" forState:UIControlStateNormal];
    [saveBtn setTitleColor:kTextBaseColor forState:UIControlStateNormal];
    [saveBtn sizeToFit];
    [saveBtn addTarget:self action:@selector(saveBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBarButtomItem = [[UIBarButtonItem alloc]initWithCustomView:saveBtn];
    self.navigationItem.rightBarButtonItem = rightBarButtomItem;
}

- (void)saveBtnClick:(UIButton *)btn {
    if ([JKToolKit stringContainsEmoji:self.introTF.text]) {
        [YJProgressHUD showMessage:@"不能输入表情符号" inView:self.view afterDelayTime:2];
        return;
    }
    
    [YJProgressHUD showProgressCircleNoValue:@"更新中..." inView:self.view];
    JKUpdateUserInfoVM *uuiVM = [[JKUpdateUserInfoVM alloc] init];
    uuiVM.introStr = self.introTF.text;
    [uuiVM userInfoIntroRequestWithSuccessBlock:^(id returnValue) {
        [YJProgressHUD hide];
        if ([returnValue[kStatus] integerValue] == 1) {
            [YJProgressHUD showMessage:returnValue[kMsg] inView:self.view afterDelayTime:1];
            self.block(self.introTF.text);
            [self.navigationController popViewControllerAnimated:YES];
        } else {
            [YJProgressHUD showMsgWithImage:returnValue[kMsg] imageName:iFailPath inview:self.view];
        }
    } withFailureBlock:^(id errorCode) {
        [YJProgressHUD hide];
    }];
}

#pragma mark -- UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField == self.introTF) {
        if (string.length == 0) return YES;
        NSInteger existedLength = textField.text.length;
        NSInteger selectedLength = range.length;
        NSInteger replaceLength = string.length;
        if (existedLength - selectedLength + replaceLength > 20) {
            [YJProgressHUD showMessage:@"昵称不能超过20个字符" inView:self.view afterDelayTime:2];
            return NO;
        }
    }
    return YES;
}
@end

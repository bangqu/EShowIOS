//
//  JKMainVC.m
//  EShow
//
//  Created by 周家康 on 2018/5/7.
//  Copyright © 2018年 周家康. All rights reserved.
//

#import "JKMainVC.h"
#import "JKMainView.h"
#import "JKPersonalCenterVC.h"
#import "JKSettingVC.h"
#import "JKTouchIDAndFaceIDVC.h"

@interface JKMainVC () <JKMainViewDelegate>
@property (nonatomic, strong) JKMainView *mainV;

@end

@implementation JKMainVC
- (JKMainView *)mainV {
    if (!_mainV) {
        _mainV = [[JKMainView alloc] init];
        _mainV.delegate = self;
    }
    return _mainV;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"首页";
    [self.view addSubview:self.mainV];
    [self.mainV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.safeAreaTopView.mas_bottom);
        make.left.right.bottom.equalTo(self.view);
    }];
}

#pragma mark -- 个人中心
- (void)pushPersonCenterVC {
    if ([JKUserDefaults objectForKey:kAccessToken] == nil) {
        JKLoginVC *lVC = [[JKLoginVC alloc] init];
        JKNavigationVC *navi = [[JKNavigationVC alloc] initWithRootViewController:lVC];
        [self presentViewController:navi animated:YES completion:nil];
    } else {
        JKPersonalCenterVC *pcVC = [[JKPersonalCenterVC alloc] init];
        [self.navigationController pushViewController:pcVC animated:YES];
    }
}

#pragma mark -- 设置
- (void)pushSettingVC {
    if ([JKUserDefaults objectForKey:kAccessToken] == nil) {
        JKLoginVC *lVC = [[JKLoginVC alloc] init];
        JKNavigationVC *navi = [[JKNavigationVC alloc] initWithRootViewController:lVC];
        [self presentViewController:navi animated:YES completion:nil];
    } else {
        JKSettingVC *sVC = [[JKSettingVC alloc] init];
        [self.navigationController pushViewController:sVC animated:YES];
    }
}

#pragma mark -- TouchID&FaceID
- (void)pushTouchIDAndFaceIDVC {
    if ([JKUserDefaults objectForKey:kAccessToken] == nil) {
        JKLoginVC *lVC = [[JKLoginVC alloc] init];
        JKNavigationVC *navi = [[JKNavigationVC alloc] initWithRootViewController:lVC];
        [self presentViewController:navi animated:YES completion:nil];
    } else {
        JKTouchIDAndFaceIDVC *tfVC = [[JKTouchIDAndFaceIDVC alloc] init];
        [self.navigationController pushViewController:tfVC animated:YES];
    }
}


@end

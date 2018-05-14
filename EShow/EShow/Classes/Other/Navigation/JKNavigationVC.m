//
//  JKNavigationVC.m
//  EShow
//
//  Created by 周家康 on 2018/5/7.
//  Copyright © 2018年 周家康. All rights reserved.
//

#import "JKNavigationVC.h"

@interface JKNavigationVC ()<UIGestureRecognizerDelegate>

@end

@implementation JKNavigationVC

- (void)viewDidLoad {
    [super viewDidLoad];

    //设置手势代理
    self.interactivePopGestureRecognizer.delegate = self;
    //设置NavigationBar
    [self setupNavigationBar];
}

#pragma mark -- 设置NavigationBar
- (void)setupNavigationBar {
    UINavigationBar *bar = [UINavigationBar appearance];
    //统一设置导航栏颜色，如果单个界面需要设置，可以在viewWillAppear里面设置，在viewWillDisappear设置回统一格式。
    [bar setBarTintColor:kWhiteColor];
    
    //导航栏title格式
    NSMutableDictionary *textAttribute = [NSMutableDictionary dictionary];
    textAttribute[NSForegroundColorAttributeName] = kTextBaseColor;
    textAttribute[NSFontAttributeName] = [UIFont systemFontOfSize:19];
    [bar setTitleTextAttributes:textAttribute];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
        //返回按钮
        UIButton *backBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 80, 22)];
        backBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [backBtn setTitle:@"返回" forState:UIControlStateNormal];
        [backBtn setTitleColor:kTextBaseColor forState:UIControlStateNormal];
        [backBtn setImage:[UIImage imageNamed:@"goBack"] forState:UIControlStateNormal];
        if (@available(iOS 11.0, *)) {
            [backBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -30, 0, 0)];
            [backBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, -30, 0, 0)];
        } else {
            [backBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 0)];
            [backBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 0)];
        }
        [backBtn addTarget:self action:@selector(popView) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *btnItem=[[UIBarButtonItem alloc]initWithCustomView:backBtn];
        
        UIBarButtonItem *navigationSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        if (@available(iOS 11.0, *)) {
            
        } else {
            navigationSpace.width = -15;
        }
        
        viewController.navigationItem.leftBarButtonItems = @[navigationSpace, btnItem];
    }
    [super pushViewController:viewController animated:animated];
}

#pragma mark -- 返回
- (void)popView
{
    [self popViewControllerAnimated:YES];
}

#pragma mark -- 手势
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    return self.childViewControllers.count > 1;
}

@end

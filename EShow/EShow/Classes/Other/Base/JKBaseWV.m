//
//  JKBaseWV.m
//  EShow
//
//  Created by 周家康 on 2018/5/10.
//  Copyright © 2018年 周家康. All rights reserved.
//

#import "JKBaseWV.h"
#import "WYWebProgressLayer.h"
#import "UIView+Frame.h"
#import "WLWebProgressLayer.h"

@interface JKBaseWV () <WKNavigationDelegate, WKUIDelegate>
@property (nonatomic, strong) WYWebProgressLayer *progressLayer; // 网页加载进度条

@end

@implementation JKBaseWV

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = self.currentTitle;
    
    WKWebView *webView = [[WKWebView alloc] init];
    webView.scrollView.showsVerticalScrollIndicator = NO;
    webView.UIDelegate = self;
    webView.navigationDelegate = self;
    [self.view addSubview:webView];
    [webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.safeAreaTopView.mas_bottom);
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view);
    }];
    
    NSString *urlUTF8 = [self.urlStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSURL *urlStr = [NSURL URLWithString:urlUTF8];//创建URL
    NSURLRequest* request = [NSURLRequest requestWithURL:urlStr];//创建NSURLRequest
    [webView loadRequest:request];
    self.webView = webView;
}

#pragma mark -- 开始加载
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(null_unspecified WKNavigation *)navigation {
    self.progressLayer = [WYWebProgressLayer layerWithFrame:CGRectMake(0, SafeAreaTopHeight-0.5, SCREEN_WIDTH, 2)];
    [self.view.layer addSublayer:self.progressLayer];
    [self.progressLayer startLoad];
}

#pragma mark -- 加载完毕
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    [self.progressLayer finishedLoad];
}

#pragma mark -- 加载失败
- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    [self.progressLayer finishedLoad];
}

@end

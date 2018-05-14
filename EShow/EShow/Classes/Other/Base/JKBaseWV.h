//
//  JKBaseWV.h
//  EShow
//
//  Created by 周家康 on 2018/5/10.
//  Copyright © 2018年 周家康. All rights reserved.
//

#import "JKBaseVC.h"
#import <WebKit/WebKit.h>
@interface JKBaseWV : JKBaseVC
@property (nonatomic, strong) NSString *currentTitle;
@property (nonatomic, strong) NSString *urlStr;
@property (nonatomic, strong) WKWebView *webView;
@end

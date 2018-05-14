//
//  AppDelegate.m
//  EShow
//
//  Created by 周家康 on 2018/5/7.
//  Copyright © 2018年 周家康. All rights reserved.
//

#import "AppDelegate.h"
#import "JKGuidePagesView.h"

@interface AppDelegate () <JKGuidePagesViewDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    JKMainVC *mVC = [[JKMainVC alloc] init];
    JKNavigationVC *nVC = [[JKNavigationVC alloc] initWithRootViewController:mVC];
    [self.window setRootViewController:nVC];
    
    NSString *version = [[NSBundle mainBundle].infoDictionary objectForKey:@"CFBundleShortVersionString"];
    BOOL show = [JKUserDefaults boolForKey:[NSString stringWithFormat:@"version_%@", version]];
    if (!show) {
        [self setupGuidePage];
        [JKUserDefaults setBool:YES forKey:[NSString stringWithFormat:@"version_%@", version]];
        [JKUserDefaults synchronize];
    }
    
    return YES;
}

#pragma mark -- 显示引导页
- (void)setupGuidePage {
    NSMutableArray *images = [NSMutableArray new];
    [images addObject:[UIImage imageNamed:@"welcome_page_1"]];
    [images addObject:[UIImage imageNamed:@"welcome_page_2"]];
    [images addObject:[UIImage imageNamed:@"welcome_page_3"]];
    
    JKGuidePagesView *gpV = [[JKGuidePagesView alloc] init];
    gpV.frame = SCREEN_BOUNDS;
    gpV.delegate = self;
    [gpV showGuideViewWithImages:images
                       andLeftBtnTitle:@"注册"
                  andLeftBtnTitleColor:kWhiteColor
                     andLeftBtnBgColor:kTextBaseColor
                      andRightBtnTitle:@"登录"
                 andRightBtnTitleColor:kTextBaseColor
                    andRightBtnBgColor:kWhiteColor
                andRightBtnBorderColor:kTextBaseColor];
    [self.window addSubview:gpV];
}

#pragma mark -- JKGuidePagesViewDelegate
- (void)clickButtonEvents:(UIButton *)btn {
    if (btn.tag == 1) {
        [self createLoginVC:YES with:YES];
    } else if (btn.tag == 2) {
        [self createLoginVC:YES with:NO];
    }
}

#pragma mark -- 登录界面
- (void)createLoginVC:(BOOL)isRootVC with:(BOOL)isShowRegisterVC {
    JKLoginVC *lVC = [[JKLoginVC alloc] init];
    lVC.isRootVC = isRootVC;
    lVC.isShowRegisterVC = isShowRegisterVC;
    JKNavigationVC *navi = [[JKNavigationVC alloc] initWithRootViewController:lVC];
    [self.window setRootViewController:navi];
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end

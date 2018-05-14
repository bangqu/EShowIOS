//
//  Macros.h
//  EShow
//
//  Created by 周家康 on 2018/5/7.
//  Copyright © 2018年 周家康. All rights reserved.
//

#ifndef Macros_h
#define Macros_h

// 输出
#ifdef DEBUG
# define NSLog(fmt, ...) NSLog((@"[函数名:%s]\n" "[行号:%d] \n" fmt), __FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
# define NSLog(...);
#endif

// 屏幕宽度和高度
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define SCREEN_BOUNDS [UIScreen mainScreen].bounds
// 适配屏幕宽高比例
#define SCREEN_SCALE (SCREEN_HEIGHT / 667)
#define SCALE_SIZE(s) SCREEN_SCALE * s
#define SafeAreaTopHeight (SCREEN_HEIGHT == 812.0 ? 88 : 64)
#define SafeAreaBottomHeight (SCREEN_HEIGHT == 812.0 ? 83 : 49)

// 各个尺寸的iPhone的高度
#define IS_IPHONE_8 ([[UIScreen mainScreen] bounds].size.height == 667.0f)
#define IS_IPHONE_8_PLUS ([[UIScreen mainScreen] bounds].size.height == 736.0f)
#define IS_IPHONE_X ([[UIScreen mainScreen] bounds].size.height == 812.0f)
#define IS_IPHONE_SE ([[UIScreen mainScreen] bounds].size.height == 568.0f)

// 通知中心
#define JKNotificationCenter [NSNotificationCenter defaultCenter]
// UserDefault
#define JKUserDefaults [NSUserDefaults standardUserDefaults]

// 字体大小
#define IPHONE_8_INCREMENT 1
#define IPHONE_8_PLUS_INCREMENT 2
#define IPHONE_X_INCREMENT 1.5

// 自定义颜色
#define RGB(r,g,b)      [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0]
#define RGBA(r,g,b,a)   [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

#define RGBHex(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define RGBHexAlpha(rgbValue,a) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:(a)]

#define RandomColor     RGB(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))

#define kTextBaseColor        RGBHex(0xf96650)
// 默认色
#define kWhiteColor           [UIColor whiteColor]
#define kBlackColor           [UIColor blackColor]
#define kRedColor             [UIColor redColor]
#define kBlueColor            [UIColor blueColor]
#define kGreenColor           [UIColor greenColor]
#define kGrayColor            [UIColor grayColor]
#define kDarkGrayColor        [UIColor darkGrayColor]
#define kLightGrayColor       [UIColor lightGrayColor]
#define kClearColor           [UIColor clearColor]

#endif /* Macros_h */

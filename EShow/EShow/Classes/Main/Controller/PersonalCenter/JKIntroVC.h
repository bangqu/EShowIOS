//
//  JKIntroVC.h
//  EShow
//
//  Created by 周家康 on 2018/5/10.
//  Copyright © 2018年 周家康. All rights reserved.
//

#import "JKBaseVC.h"

typedef void(^IntroBlock)(NSString *introStr);

@interface JKIntroVC : JKBaseVC
@property (nonatomic, strong) NSString *introStr;
@property (nonatomic, strong) IntroBlock block;
@end

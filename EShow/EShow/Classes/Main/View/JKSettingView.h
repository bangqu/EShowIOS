//
//  JKSettingView.h
//  EShow
//
//  Created by 周家康 on 2018/5/10.
//  Copyright © 2018年 周家康. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol JKSettingViewDelegate <NSObject>
- (void)pushAccountSecurityVC;
@end

@interface JKSettingView : UIView
@property (nonatomic, strong) id<JKSettingViewDelegate> delegate;
@end

//
//  JKAccountSecurityView.h
//  EShow
//
//  Created by 周家康 on 2018/5/10.
//  Copyright © 2018年 周家康. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol JKAccountSecurityViewDelegate <NSObject>
- (void)pushModifyPwdVC;
- (void)pushSocialAccountVC;
@end


@interface JKAccountSecurityView : UIView
@property (nonatomic, strong) id<JKAccountSecurityViewDelegate> delegate;

@end

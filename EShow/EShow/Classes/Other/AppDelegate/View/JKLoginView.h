//
//  JKLoginView.h
//  EShow
//
//  Created by 周家康 on 2018/5/8.
//  Copyright © 2018年 周家康. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol JKLoginViewDelegate <NSObject>
- (void)pushMainVC;
- (void)pushForgetPwdVC;
- (void)pushVerificationLoginVC;
- (void)pushBindPhoneVC;
@end


@interface JKLoginView : UIView

@property (nonatomic, weak) id<JKLoginViewDelegate> delegate;

@end

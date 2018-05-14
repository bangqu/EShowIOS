//
//  JKForgetPwdView.h
//  EShow
//
//  Created by 周家康 on 2018/5/9.
//  Copyright © 2018年 周家康. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol JKForgetPwdViewDelegate <NSObject>
- (void)popLoginVC;
@end

@interface JKForgetPwdView : UIView

@property (nonatomic, weak) id<JKForgetPwdViewDelegate> delegate;

@end

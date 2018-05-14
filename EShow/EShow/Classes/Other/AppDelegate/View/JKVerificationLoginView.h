//
//  JKVerificationLoginView.h
//  EShow
//
//  Created by 周家康 on 2018/5/9.
//  Copyright © 2018年 周家康. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol JKVerificationLoginViewDelegate <NSObject>
- (void)pushMainVC;
@end

@interface JKVerificationLoginView : UIView

@property (nonatomic, weak) id<JKVerificationLoginViewDelegate> delegate;

@end

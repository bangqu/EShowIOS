//
//  JKGuidePagesView.h
//  EShow
//
//  Created by 周家康 on 2018/5/8.
//  Copyright © 2018年 周家康. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol JKGuidePagesViewDelegate <NSObject>
- (void)clickButtonEvents:(UIButton *)btn;
@end

@interface JKGuidePagesView : UIView
@property (nonatomic, strong) id<JKGuidePagesViewDelegate> delegate;

- (void)showGuideViewWithImages:(NSArray *)images
                andLeftBtnTitle:(NSString *)leftBtnTitle
           andLeftBtnTitleColor:(UIColor *)leftBtnTitleColor
              andLeftBtnBgColor:(UIColor *)leftBtnBgColor
               andRightBtnTitle:(NSString *)rightBtnTitle
          andRightBtnTitleColor:(UIColor *)rightBtnTitleColor
             andRightBtnBgColor:(UIColor *)rightBtnBgColor
         andRightBtnBorderColor:(UIColor *)rightBtnBorderColor;
@end

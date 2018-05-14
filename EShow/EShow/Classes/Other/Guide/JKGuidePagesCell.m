//
//  JKGuidePagesCell.m
//  EShow
//
//  Created by 周家康 on 2018/5/8.
//  Copyright © 2018年 周家康. All rights reserved.
//

#import "JKGuidePagesCell.h"

@implementation JKGuidePagesCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self createUI];
    }
    return self;
}

- (void)createUI {
    self.layer.masksToBounds = YES;
    self.imageView = [[UIImageView alloc]initWithFrame:SCREEN_BOUNDS];
    [self.contentView addSubview:self.imageView];
    
    CGFloat width = SCREEN_WIDTH / 3;
    CGFloat leftBtnX = SCREEN_WIDTH / 2 - width - width / 4;
    CGFloat rightBtnX = SCREEN_WIDTH / 2 + width / 4;
    
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(leftBtnX, SCREEN_HEIGHT - SCALE_SIZE(44) - SCALE_SIZE(34), width, SCALE_SIZE(44));
    leftBtn.titleLabel.font = [UIFont systemFontOfSize:17];
    leftBtn.layer.cornerRadius = SCALE_SIZE(22);
    leftBtn.layer.masksToBounds = YES;
    leftBtn.hidden = YES;
    [self.contentView addSubview:leftBtn];
    self.leftBtn = leftBtn;
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(rightBtnX, SCREEN_HEIGHT - SCALE_SIZE(44) - SCALE_SIZE(34), width, SCALE_SIZE(44));
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:17];
    rightBtn.layer.cornerRadius = SCALE_SIZE(22);
    rightBtn.layer.masksToBounds = YES;
    rightBtn.hidden = YES;
    [self.contentView addSubview:rightBtn];
    self.rightBtn = rightBtn;
    
    UIButton *skipBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    skipBtn.frame = CGRectMake(SCREEN_WIDTH - SCALE_SIZE(40) - 40, SafeAreaTopHeight - 30, SCALE_SIZE(60), SCALE_SIZE(30));
    skipBtn.titleLabel.font = [UIFont systemFontOfSize:17];
    skipBtn.layer.cornerRadius = SCALE_SIZE(15);
    skipBtn.layer.masksToBounds = YES;
    skipBtn.hidden = YES;
    [self.contentView addSubview:skipBtn];
    self.skipBtn = skipBtn;
}











@end

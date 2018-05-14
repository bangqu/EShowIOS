//
//  JKPersonCenterView.h
//  EShow
//
//  Created by 周家康 on 2018/5/7.
//  Copyright © 2018年 周家康. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol JKPersonCenterViewDelegate <NSObject>
- (void)pushModifyNickNameVC;
- (void)pushIntroVC;
- (void)chooseGender;
- (void)chooseHeadImgV;
@end

@interface JKPersonCenterView : UIView
@property (nonatomic, weak) id<JKPersonCenterViewDelegate> delegate;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSString *photoStr;
@property (nonatomic, strong) NSString *nicknameStr;
@property (nonatomic, strong) NSString *genderStr;
@property (nonatomic, strong) NSString *introStr;
@end

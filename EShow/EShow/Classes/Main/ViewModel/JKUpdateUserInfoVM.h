//
//  JKUpdateUserInfoVM.h
//  EShow
//
//  Created by 周家康 on 2018/5/9.
//  Copyright © 2018年 周家康. All rights reserved.
//

#import "JKViewModel.h"

@interface JKUpdateUserInfoVM : JKViewModel
@property (nonatomic, strong) NSString *genderStr;
@property (nonatomic, strong) NSString *nickNameStr;
@property (nonatomic, strong) NSString *introStr;
@property (nonatomic, strong) NSString *photoStr;

- (void)userInfoGenderRequestWithSuccessBlock:(ReturnSuccessBlock)successBlock withFailureBlock:(ReturnFailureBlock)failureBlock;
- (void)userInfoModifyNameRequestWithSuccessBlock:(ReturnSuccessBlock)successBlock withFailureBlock:(ReturnFailureBlock)failureBlock;
- (void)userInfoIntroRequestWithSuccessBlock:(ReturnSuccessBlock)successBlock withFailureBlock:(ReturnFailureBlock)failureBlock;
- (void)userInfoHeadImgVRequestWithSuccessBlock:(ReturnSuccessBlock)successBlock withFailureBlock:(ReturnFailureBlock)failureBlock;
@end

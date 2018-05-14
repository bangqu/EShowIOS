//
//  JKRegisterVM.h
//  EShow
//
//  Created by 周家康 on 2018/5/9.
//  Copyright © 2018年 周家康. All rights reserved.
//

#import "JKViewModel.h"

@interface JKRegisterVM : JKViewModel
@property (nonatomic, strong) NSString *phoneStr;
@property (nonatomic, strong) NSString *codeStr;
@property (nonatomic, strong) NSString *pwdStr;
@property (nonatomic, strong) UIButton *verificationBtn;
- (void)verificationRequestWithSuccessBlock:(ReturnSuccessBlock)successBlock withFailureBlock:(ReturnFailureBlock)failureBlock;
- (void)registerRequestWithSuccessBlock:(ReturnSuccessBlock)successBlock withFailureBlock:(ReturnFailureBlock)failureBlock;

@end

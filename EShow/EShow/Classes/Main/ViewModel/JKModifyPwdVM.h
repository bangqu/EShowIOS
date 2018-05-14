//
//  JKModifyPwdVM.h
//  EShow
//
//  Created by 周家康 on 2018/5/10.
//  Copyright © 2018年 周家康. All rights reserved.
//

#import "JKViewModel.h"

@interface JKModifyPwdVM : JKViewModel

@property (nonatomic, strong) NSString *oldPwdStr;
@property (nonatomic, strong) NSString *nPwdStr;
@property (nonatomic, strong) NSString *againPwdStr;

- (void)modifyPwdRequestWithSuccessBlock:(ReturnSuccessBlock)successBlock withFailureBlock:(ReturnFailureBlock)failureBlock;

@end

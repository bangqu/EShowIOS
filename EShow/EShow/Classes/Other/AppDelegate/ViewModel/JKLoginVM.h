//
//  JKLoginVM.h
//  EShow
//
//  Created by 周家康 on 2018/5/8.
//  Copyright © 2018年 周家康. All rights reserved.
//

#import "JKViewModel.h"

@interface JKLoginVM : JKViewModel
@property (nonatomic, strong) NSString *phoneStr;
@property (nonatomic, strong) NSString *pwdStr;

- (void)loginRequestWithSuccessBlock:(ReturnSuccessBlock)successBlock withFailureBlock:(ReturnFailureBlock)failureBlock;

@end

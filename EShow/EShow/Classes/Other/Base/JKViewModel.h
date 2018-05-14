//
//  JKViewModel.h
//  EShow
//
//  Created by 周家康 on 2018/5/8.
//  Copyright © 2018年 周家康. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^ReturnSuccessBlock)(id returnValue);
typedef void(^ReturnFailureBlock)(id errorCode);

@interface JKViewModel : NSObject
@property (nonatomic, strong) ReturnSuccessBlock successBlock;
@property (nonatomic, strong) ReturnFailureBlock failureBlock;
@end

//
//  JKModifyNickNameVC.h
//  EShow
//
//  Created by 周家康 on 2018/5/8.
//  Copyright © 2018年 周家康. All rights reserved.
//

#import "JKBaseVC.h"

typedef void(^ModifyNickName)(NSString *name);

@interface JKModifyNickNameVC : JKBaseVC
@property (nonatomic, strong) NSString *nickNameStr;
@property (nonatomic, strong) ModifyNickName block;
@end

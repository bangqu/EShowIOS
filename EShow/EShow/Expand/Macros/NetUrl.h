//
//  NetUrl.h
//  EShow
//
//  Created by 周家康 on 2018/5/7.
//  Copyright © 2018年 周家康. All rights reserved.
//

#ifndef NetUrl_h
#define NetUrl_h

#define BaseUrl  @"http://api.chemo.daoqun.com"

/**用户登录*/
#define URL_User_Login [NSString stringWithFormat:@"%@%@",BaseUrl,@"/user/login.json"]
/**发送验证码*/
#define URL_Captcha_Send [NSString stringWithFormat:@"%@%@",BaseUrl,@"/captcha/send.json"]
/**用户注册*/
#define URL_User_SignUp [NSString stringWithFormat:@"%@%@",BaseUrl,@"/user/signup.json"]
/**忘记密码-重置密码*/
#define URL_Forget_Password_Reset [NSString stringWithFormat:@"%@%@",BaseUrl,@"/forget-password/reset.json"]
/**验证码登录*/
#define URL_Captcha_Login [NSString stringWithFormat:@"%@%@",BaseUrl,@"/captcha/login.json"]
/**获取七牛空间TOKEN*/
#define URL_QiNiu_UpToken [NSString stringWithFormat:@"%@%@",BaseUrl,@"/qiniu/uptoken.json"]
/**获取七牛KEY*/
#define URL_QiNiu_Key [NSString stringWithFormat:@"%@%@",BaseUrl,@"/qiniu/key.json"]
/**修改新密码*/
#define URL_User_UpdatePassword [NSString stringWithFormat:@"%@%@",BaseUrl,@"/user/updatePassword.json"]
/**修改用户信息*/
#define URL_User_Update [NSString stringWithFormat:@"%@%@",BaseUrl,@"/user/update.json"]




















#endif /* NetUrl_h */

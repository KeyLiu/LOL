//  SyncGET
//
//  Created by Sure on 14-10-7.
//  Copyright (c) 2014年 Sure. All rights reserved.
//

#import <Foundation/Foundation.h>
//常用字符串加密库
//用于对网址加密解密操作
@interface NSString (URLEncoding)
//加密操作
-(NSString *)URLEncodedString;
//解密操作
-(NSString *)URLDecodedString;


@end

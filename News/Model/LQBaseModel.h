//
//  LQBaseModel.h
//  LOL
//
//  Created by GH on 16/2/22.
//  Copyright © 2016年 LIUQI. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LQBaseModel : NSObject

//标题
@property(nonatomic,copy)NSString  * title;

//详情
@property(nonatomic,copy)NSString  * shortString;//KVC查找找的仍然是short属性 需重新赋值

//图标
@property(nonatomic,copy)NSString  * icon;

//跳转详情ID
@property(nonatomic,copy)NSString  * idString;



@end

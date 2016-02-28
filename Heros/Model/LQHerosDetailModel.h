//
//  LQHerosDetailModel.h
//  LOL
//
//  Created by GH on 16/2/24.
//  Copyright © 2016年 LIUQI. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LQHerosDetailModel : NSObject
//背景故事
@property(nonatomic,copy)NSString  * background;
//使用技巧
@property(nonatomic,copy)NSString  * analyse;
//对线技巧
@property(nonatomic,copy)NSString  * talent_desc;
//英雄技能
@property(nonatomic,strong)NSArray * skill;

//英雄名称
@property(nonatomic,copy)NSString  * name_c;
//英雄头像
@property(nonatomic,copy)NSString  * img;

@end

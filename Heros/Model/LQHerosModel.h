//
//  LQHerosModel.h
//  LOL
//
//  Created by GH on 16/2/24.
//  Copyright © 2016年 LIUQI. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LQHerosModel : NSObject

//id
@property(nonatomic,copy)NSString  * idString;

//图片
@property(nonatomic,copy)NSString  * img;

//别名
@property(nonatomic,copy)NSString  * name_c;

//技能
@property(nonatomic,copy)NSString  * tags;

//名字
@property(nonatomic,copy)NSString  * title;

@end

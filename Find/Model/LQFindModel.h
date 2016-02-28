//
//  LQFindModel.h
//  LOL
//
//  Created by LQ on 16/2/26.
//  Copyright © 2016年 LIUQI. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LQFindModel : NSObject

@property(nonatomic,copy)NSString  * idString;

//标题
@property(nonatomic,copy)NSString  * title;

//详情
@property(nonatomic,copy)NSString  * intro;

//图片数组
@property(nonatomic,strong)NSDictionary * pics;

//大图
@property(nonatomic,copy)NSString * kpic;



@end

//
//  LQBaseModel.m
//  LOL
//
//  Created by GH on 16/2/22.
//  Copyright © 2016年 LIUQI. All rights reserved.
//

#import "LQBaseModel.h"

@implementation LQBaseModel

//重写KVC方法
//KVC赋值操作
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
    //id   short
    if ([key isEqualToString:@"id"]) {
        self.idString = value;
    } else if([key isEqualToString:@"short"]) {
        self.shortString = value;
    }
    
}

//KVC取值操作

- (id)valueForUndefinedKey:(NSString *)key{
    
    return nil;
    
}

@end

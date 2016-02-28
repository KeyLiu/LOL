//
//  LQFindModel.m
//  LOL
//
//  Created by LQ on 16/2/26.
//  Copyright © 2016年 LIUQI. All rights reserved.
//

#import "LQFindModel.h"

@implementation LQFindModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
    if ([key isEqualToString:@"id"]) {
        self.idString = value;
    }
    
}

- (id)valueForUndefinedKey:(NSString *)key{
    
    return nil;
    
}

@end

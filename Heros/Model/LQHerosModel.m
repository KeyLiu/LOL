//
//  LQHerosModel.m
//  LOL
//
//  Created by GH on 16/2/24.
//  Copyright © 2016年 LIUQI. All rights reserved.
//

#import "LQHerosModel.h"

@implementation LQHerosModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
    if ([key isEqualToString:@"id"]) {
        self.idString = value;
    }
    
}

- (id)valueForUndefinedKey:(NSString *)key{
    
    return nil;
    
}

@end

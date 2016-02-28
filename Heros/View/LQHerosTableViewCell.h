//
//  LQHerosTableViewCell.h
//  LOL
//
//  Created by GH on 16/2/23.
//  Copyright © 2016年 LIUQI. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "LQHerosModel.h"

@interface LQHerosTableViewCell : UITableViewCell

//头像
@property (strong, nonatomic) IBOutlet UIImageView *iconImageView;

//名字
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;

//别名
@property (strong, nonatomic) IBOutlet UILabel *realLabel;

//技能
@property (strong, nonatomic) IBOutlet UILabel *tagLabel;

- (void)addModel:(LQHerosModel *)model;

@end

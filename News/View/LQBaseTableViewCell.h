//
//  LQBaseTableViewCell.h
//  LOL
//
//  Created by GH on 16/2/22.
//  Copyright © 2016年 LIUQI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LQBaseModel.h"
@interface LQBaseTableViewCell : UITableViewCell

//图标
@property (strong, nonatomic) IBOutlet UIImageView *iconImageView;

//标题
@property (strong, nonatomic) IBOutlet UILabel *newsLabel;

//详情
@property (strong, nonatomic) IBOutlet UILabel *infoLabel;


//公开数据与视图联系的方法
- (void)loadDataFromModel:(LQBaseModel *)model;

@end

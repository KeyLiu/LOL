//
//  LQFindNormalTableViewCell.h
//  LOL
//
//  Created by LQ on 16/2/25.
//  Copyright © 2016年 LIUQI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LQFindModel.h"

@interface LQFindNormalTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *iconImageView;
@property (strong, nonatomic) IBOutlet UILabel *newslabel;
@property (strong, nonatomic) IBOutlet UILabel *infoLabel;


- (void)loadDataFromModel:(LQFindModel *)model;

@end

//
//  LQFindNormalTableViewCell.m
//  LOL
//
//  Created by LQ on 16/2/25.
//  Copyright © 2016年 LIUQI. All rights reserved.
//

#import "LQFindNormalTableViewCell.h"

@implementation LQFindNormalTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)loadDataFromModel:(LQFindModel *)model{
    
    //图标
    [self.iconImageView setImageWithURL:[NSURL URLWithString:model.kpic] placeholderImage:[UIImage imageNamed:@"top_page_view_default"]];
    
    //标题
    self.newslabel.text = model.title;
    
    //详情
    self.infoLabel.text = model.intro;
    
}

@end

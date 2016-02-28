//
//  LQBaseTableViewCell.m
//  LOL
//
//  Created by GH on 16/2/22.
//  Copyright © 2016年 LIUQI. All rights reserved.
//

#import "LQBaseTableViewCell.h"

@implementation LQBaseTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)loadDataFromModel:(LQBaseModel *)model{
    
    [self.iconImageView setImageWithURL:[NSURL URLWithString:model.icon] placeholderImage:[UIImage imageNamed:@"top_page_view_default@2x.png"]];
    
    self.newsLabel.text = model.title;
    
    self.infoLabel.text = model.shortString;
    
}

@end

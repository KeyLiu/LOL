//
//  LQHerosTableViewCell.m
//  LOL
//
//  Created by GH on 16/2/23.
//  Copyright © 2016年 LIUQI. All rights reserved.
//

#import "LQHerosTableViewCell.h"

@implementation LQHerosTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)addModel:(LQHerosModel *)model{
    
    [self.iconImageView setImageWithURL:[NSURL URLWithString:model.img] placeholderImage:[UIImage imageNamed:@"default_hero_head@2x.png"]];
    self.nameLabel.text = model.name_c;
    self.realLabel.text = model.title;
    self.tagLabel.text = model.tags;
    
}

@end

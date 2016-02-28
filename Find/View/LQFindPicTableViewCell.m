//
//  LQFindPicTableViewCell.m
//  LOL
//
//  Created by LQ on 16/2/25.
//  Copyright © 2016年 LIUQI. All rights reserved.
//

#import "LQFindPicTableViewCell.h"

@implementation LQFindPicTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)loadDataFromModel:(LQFindModel *)model{
    
    //标题
    self.newsLabel.text = model.title;
    
    //下方图片
    NSArray *listArray = model.pics[@"list"];
    
    self.mainScrollView.contentSize = CGSizeMake(120 * listArray.count + 10 * (listArray.count - 1), 110);
    self.mainScrollView.bounces = NO;
    self.mainScrollView.showsHorizontalScrollIndicator = NO;
    self.mainScrollView.showsVerticalScrollIndicator = NO;
    
    for (int i = 0; i < listArray.count; i ++) {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(5 + (5 +120) * i, 5, 120, 100)];
        [imageView setImageWithURL:[NSURL URLWithString:listArray[i][@"kpic"]] placeholderImage:[UIImage imageNamed:@"notice_pic_background_defualt@2x.png"]];
        [self.mainScrollView addSubview:imageView];
    }
}

@end

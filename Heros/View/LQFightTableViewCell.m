//
//  LQFightTableViewCell.m
//  LOL
//
//  Created by GH on 16/2/24.
//  Copyright © 2016年 LIUQI. All rights reserved.
//

#import "LQFightTableViewCell.h"

@interface LQFightTableViewCell ()

//技能名称
@property(nonatomic,strong)UILabel * nameLabel;
//技能描述
@property(nonatomic,strong)UILabel * desLabel;
//cd
@property(nonatomic,strong)UILabel * cdLabel;
//消耗
@property(nonatomic,strong)UILabel * costLabel;

//全局变量形式的数组
@property(nonatomic,strong)NSArray * skillArray;


@end

@implementation LQFightTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)loadDataFromModelArray:(NSArray *)fightArray{
    
    //分类切换该方法会执行多次，因此要在每次创建之前移除上一次的控件，统一移除
    
    //.subviews属性，数组中存储了该视图上所有子视图
    
    //NSArray *subArr = self.contentView.subviews;
    
    for (UIView *view in self.contentView.subviews) {
        [view removeFromSuperview];
    }
    
    self.skillArray = fightArray;
    
    for (int i = 0; i < fightArray.count; i ++) {
        UIImageView *imageview = [[UIImageView alloc]initWithFrame:CGRectMake(10 + (40 +20) * i, 10, 40, 40)];
        [self.contentView addSubview:imageview];
        NSDictionary *dic = fightArray[i];
        [imageview setImageWithURL:[NSURL URLWithString:dic[@"img"]] placeholderImage:[UIImage imageNamed:@"default_hero_head@2x.png"]];
        imageview.tag = 100 + i;
        imageview.userInteractionEnabled = YES;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapPress:)];
        [imageview addGestureRecognizer:tap];
        
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10 +60 *i, 55, 40, 20)];
        label.textAlignment = NSTextAlignmentCenter;
        label.text = dic[@"key"];
        label.font = [UIFont boldSystemFontOfSize:13.0];
        [self.contentView addSubview:label];
        
    }
    
    //默认显示Q技能描述
    
    //数组中第一个字典
    
    NSDictionary *qDic = fightArray[0];
    
    self.nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 80, 200, 30)];
    
    self.nameLabel.text = qDic[@"name"];
    
    self.nameLabel.font = [UIFont boldSystemFontOfSize:15.0];
    
    [self.contentView addSubview:self.nameLabel];
    
    //技能描述
    
    //1.技能描述文字
    
    NSString *desString = qDic[@"desc"];
    
    //2.字体大小
    UIFont *font = [UIFont systemFontOfSize:15.0];
    
    /*
     
     3.根据文字与字体大小得到该label的位置
     
     1.宽和高中需要确定一个大小，其他的随之自适应（宽固定，高随之自适应）
     2.换行样式
     3.设置字体的样式（最基本的为字体）
     4.额外的参数
     
     */
    
    CGRect rect = [desString boundingRectWithSize:CGSizeMake(WIDTH - 20, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font}context:nil];
    
    //4.创建label
    
    //CGRectGetMaxY()得到最大值
    
    self.desLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(self.nameLabel.frame), rect.size.width, rect.size.height)];
    
    self.desLabel.text = desString;
    self.desLabel.font = font;
    
    self.desLabel.numberOfLines = 0;
    
    [self.contentView addSubview:self.desLabel];
    
    //cd
    
    self.cdLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(self.desLabel.frame), 200, 30)];
    self.cdLabel.font = font;
    self.cdLabel.text = qDic[@"cd"];
    
    [self.contentView addSubview:self.cdLabel];
    
    //消耗
    
    self.costLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(self.cdLabel.frame), 200, 30)];
    self.costLabel.font = font;
    self.costLabel.text = qDic[@"cost"];
    
    [self.contentView addSubview:self.costLabel];
}

//技能的点击事件

- (void)tapPress:(UITapGestureRecognizer *)tap{
    
    UIImageView *imageview = (UIImageView *)tap.view;
    
    int index = (int)imageview.tag - 100;
    
    //重置技能描述数据
   
    //技能名称
    self.nameLabel.text = self.skillArray[index][@"name"];
    
    //技能描述，需要重置坐标
    self.desLabel.text = self.skillArray[index][@"desc"];
    CGRect rect = [self.skillArray[index][@"desc"] boundingRectWithSize:CGSizeMake(WIDTH - 20, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15.0]}context:nil];
    self.desLabel.frame = CGRectMake(10, CGRectGetMaxY(self.nameLabel.frame), rect.size.width, rect.size.height);
    
    self.cdLabel.text = self.skillArray[index][@"cd"];
    self.cdLabel.frame = CGRectMake(10, CGRectGetMaxY(self.desLabel.frame), 200, 30);
    
    self.costLabel.text = self.skillArray[index][@"cost"];
    self.costLabel.frame = CGRectMake(10, CGRectGetMaxY(self.cdLabel.frame), 200, 30);
    
//    float costHeight = CGRectGetMaxY(self.costLabel.frame);
    
//    [[NSNotificationCenter defaultCenter]postNotificationName:@"HEIGHT" object:@(costHeight)];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

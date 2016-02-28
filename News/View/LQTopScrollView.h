//
//  LQTopScrollView.h
//  LOL
//
//  Created by GH on 16/2/22.
//  Copyright © 2016年 LIUQI. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LQTopScrollView : UIView

//滚动视图
@property(nonatomic,strong)UIScrollView* mainScrollView;

//分页控制器
@property(nonatomic,strong)UIPageControl* pageControl;

@property(nonatomic,copy)void(^block)(int );

- (instancetype)initWithFrame:(CGRect)frame andPicArr:(NSArray *)picArr;

@end

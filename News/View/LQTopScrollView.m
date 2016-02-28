//
//  LQTopScrollView.m
//  LOL
//
//  Created by GH on 16/2/22.
//  Copyright © 2016年 LIUQI. All rights reserved.
//

#import "LQTopScrollView.h"
#import "LQRecommModel.h"
#import "NSString+URLEncoding.h"

//匿名类别（作用：声明私有的属性及方法）

@interface LQTopScrollView()<UIScrollViewDelegate>
{

    //当前页数
    int page;
    
    //全局变量形式的可变数组
    NSArray *arr;
}


@end

@implementation LQTopScrollView

- (instancetype)initWithFrame:(CGRect)frame andPicArr:(NSArray *)picArr
{
    self = [super initWithFrame:frame];
    if (self) {
        
        //初始化全局变量
        page = 0;
        arr = picArr;
        
        float width = frame.size.width;
        float height = frame.size.height;
        
        //创建滚动视图
        self.mainScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, width, height)];
        self.mainScrollView.pagingEnabled = YES;
        self.mainScrollView.showsHorizontalScrollIndicator = NO;
        self.mainScrollView.showsVerticalScrollIndicator = NO;
        
        //滚动视图可以显示的大小
        self.mainScrollView.contentSize = CGSizeMake(width *picArr.count, height);
        self.mainScrollView.bounces = NO;
        
        [self addSubview:self.mainScrollView];
        
        //建立代理连接
        self.mainScrollView.delegate = self;
        
        //创建广告页
        for (int i = 0; i < picArr.count; i ++) {
            UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(width * i, 0, width, height)];
            [self.mainScrollView addSubview:imageView];
            
            //给予图片
            LQRecommModel *model = picArr[i];
            
            NSString *picURL = model.ban_img;
            
            
            [imageView setImageWithURL:[NSURL URLWithString:[picURL URLDecodedString]] placeholderImage:[UIImage imageNamed:@"top_page_view_default@2x.png"]];
            
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(width *i, height - 30, width, 30)];
            label.backgroundColor = [UIColor colorWithRed:231/255.0 green:231/255.0 blue:231/255.0 alpha:0.8];
            label.text = model.name;
            label.font = [UIFont boldSystemFontOfSize:15];
            [self.mainScrollView addSubview:label];
            
            //添加手势 开启用户交互
            imageView.userInteractionEnabled = YES;
            
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapPress:)];
            [imageView addGestureRecognizer:tap];
            
            //为了便于区分，添加tag值
            imageView.tag = 100+i;
        }
        
        //添加分页控制器
        self.pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(width - 100, height - 50, 80, 20)];
        self.pageControl.numberOfPages = picArr.count;
        self.pageControl.currentPage = 0;
        self.pageControl.currentPageIndicatorTintColor = [UIColor greenColor];
        self.pageControl.tintColor = [UIColor whiteColor];
        [self addSubview:self.pageControl];
    
        
        [self.pageControl addTarget:self action:@selector(pageChanged:) forControlEvents:UIControlEventValueChanged];
        
        [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(timerRefresh:) userInfo:nil repeats:YES];
        
        //scrollView contentInSet
    }
    return self;
}

#pragma mark -时间改变
- (void)timerRefresh:(NSTimer *)timer{
    
    self.pageControl.currentPage = page;
    
    self.mainScrollView.contentOffset = CGPointMake(page *self.frame.size.width, 0);
    
    if (page == arr.count - 1) {
        page = 0;
    }else{
        page ++;
    }
}

#pragma mark -点击手势
- (void)tapPress:(UITapGestureRecognizer *)tap{
    
    //1.获取当前点击的图片
    UIImageView *imageview = (UIImageView *)tap.view;
    
    //2.通过tag值区分点击的为第几张图片
    
    //3.跳转详情界面（一定不能跳转，自定义视图既不是视图控制器，也不是导航控制器）应该传递给BaseViewController进行跳转
    //反向传值 代理 通知 block 单例
    
    self.block((int)imageview.tag - 100);
    
}

//点击原点切换界面
- (void)pageChanged:(UIPageControl *)pageControl{
    
    float width = self.frame.size.width;
    float height = self.frame.size.height;
    
    [self.mainScrollView scrollRectToVisible:CGRectMake(pageControl.currentPage * width, 0, width, height) animated:YES];
}

#pragma mark -scrollDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    //更新页数
    
    float width = self.frame.size.width;
    
    self.pageControl.currentPage = scrollView.contentOffset.x / width;
    
}


@end

//
//  LQDetailViewController.m
//  LOL
//
//  Created by GH on 16/2/22.
//  Copyright © 2016年 LIUQI. All rights reserved.
//

#import "LQDetailViewController.h"
#import "UMSocial.h"

@interface LQDetailViewController ()<UMSocialUIDelegate>
//全局变量网页
@property(nonatomic,strong)UIWebView *webview;

@end

@implementation LQDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //设置背景颜色 ios7以后背景颜色默认为透明
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self createUI];
    
    [self createWebview];
    
}

- (void)createUI{
    
    self.title = @"新闻详情";
    
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
}

- (void)createWebview{
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.webview = [[UIWebView alloc]initWithFrame:CGRectMake(0, 64, WIDTH, HEIGHT - 64)];
    
    
    //加载网址
    //请求体
    [self.webview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:kNewsDetailUrlString,self.newsID]]]];
    
    [self.view addSubview: self.webview];
    
    //分享按钮
    UIButton *shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [shareButton setImage:[UIImage imageNamed:@"share_normal"] forState:UIControlStateNormal];
    shareButton.frame = CGRectMake(0, 0, 40, 40);
    
    [shareButton addTarget:self action:@selector(sharedClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:shareButton];
    
}

#pragma mark -分享操作
- (void)sharedClick:(id)sender{
    
     //社会化分享
    /*
     
     三方分享
     三方登陆
     实现方法：1.采用原生SDK方式
                    2.利用友盟 shareSDK等实现
     
     前期准备 分别到微信开放平台和腾讯开放平台申请账号获取APPID
     */
    
    /*
     
     执行分享
     1.展示在当前视图上
     2.appKey填写需要与appDelegate一致
     3.分享的文字
     4.分享的图片
     5.分享的渠道@［UMSocialToQQ，UMSocialToWechat……］
     6.代理（区分分享的代理渠道）
     
     */
    
    NSString *url = [NSString stringWithFormat:kNewsDetailUrlString,self.newsID];
    
    [UMSocialSnsService presentSnsIconSheetView:self appKey:@"56a9b28de0f55a80f10005ec" shareText:url shareImage:[UIImage imageNamed:@"Launch960@2x.png"] shareToSnsNames:@[UMShareToSina,UMShareToQQ,UMShareToQzone, UMShareToWechatSession,UMShareToWechatTimeline,UMShareToWechatFavorite,UMShareToRenren] delegate:self];
    
    
}

- (void)didFinishGetUMSocialDataResponse:(UMSocialResponseEntity *)response{
    NSLog(@"分享成功");
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = NO;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

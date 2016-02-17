//
//  NewsDetailViewController.m
//  新浪新闻
//
//  Created by qianfeng on 14-9-15.
//  Copyright (c) 2014年 申冠华. All rights reserved.
//

#import "NewsDetailViewController.h"
#import "SVProgressHUD.h" //第三方 正在加载控件

@interface NewsDetailViewController ()
{
    NSURLRequest *_request;
    UIImageView *navbg;
}
@end

@implementation NewsDetailViewController

- (id)initWithModel:(NewsToutiaoModel *)model{
    if (self=[super init]) {
        _newsModel=model;
    }
    return self;
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor whiteColor];
    [self.tabBarController.tabBar setHidden:YES];//隐藏tabBar
    //navigationBar的设置
    [self createNav];
    
    //使用UIWebView
    CGFloat height=[UIScreen mainScreen].bounds.size.height;
    UIWebView *webView=[[UIWebView alloc]initWithFrame:CGRectMake(0, 30, 320, height+18)];
    NSURL *url=[NSURL URLWithString:_newsModel.link]; //请求网址
    _request=[NSURLRequest requestWithURL:url];
    [webView loadRequest:_request];//加载
    webView.delegate=self;
    [self.view addSubview:webView];
}

#pragma mark -custom method
- (void)createNav{
    //navigationBar的设置
    self.navigationController.navigationBarHidden=YES;//隐藏系统的navigationBar,自己定制
    navbg=[[UIImageView alloc]initWithFrame:CGRectMake(0, 20, 320, 30)];
    [navbg setBackgroundColor:[UIColor whiteColor]];
    navbg.userInteractionEnabled=YES;
    //返回按钮
    UIButton *backBtn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    [backBtn setFrame:CGRectMake(15, 5, 20, 20)];
    [backBtn setBackgroundImage:[UIImage imageNamed:@"navigationbar_back_icon"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [navbg addSubview:backBtn];
    //喜欢按钮
    UIButton *likeBtn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    [likeBtn setFrame:CGRectMake(187, 5, 20, 20)];
    [likeBtn setBackgroundImage:[UIImage imageNamed:@"navigationBarItem_like_normal"] forState:UIControlStateNormal];
    [likeBtn addTarget:self action:@selector(likeBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [navbg addSubview:likeBtn];
    //收藏按钮
    UIButton *saveBtn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    [saveBtn setFrame:CGRectMake(237, 5, 20, 20)];
    [saveBtn setBackgroundImage:[UIImage imageNamed:@"navigationBarItem_favorite_normal"] forState:UIControlStateNormal];
    [saveBtn addTarget:self action:@selector(saveBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [navbg addSubview:saveBtn];
    //分享
    UIButton *shareBtn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    [shareBtn setFrame:CGRectMake(287, 5, 20, 20)];
    [shareBtn setBackgroundImage:[UIImage imageNamed:@"navigationbar_share_icon"] forState:UIControlStateNormal];
    [shareBtn addTarget:self action:@selector(shareBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [navbg addSubview:shareBtn];
    [self.navigationController.view addSubview:navbg];
}
- (void)backBtnClicked{ //返回
    [self.navigationController popViewControllerAnimated:NO];
}
- (void)likeBtnClicked{ //喜欢
}
- (void)saveBtnClicked{ //收藏
}
- (void)shareBtnClicked{ //分享
    UIActionSheet *share=[[UIActionSheet alloc]initWithTitle:@"分享" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"微信",@"新浪微博", nil];
    [share showInView:self.view];
}

#pragma mark -UIWebView delegate
- (void)webViewDidStartLoad:(UIWebView *)webView{
    //正在加载控件
    [SVProgressHUD showInView:self.view status:@"正在加载"];
    NSLog(@"正在加载....");
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [SVProgressHUD dismissWithSuccess:@"加载成功"];
     NSLog(@"加载成功!");
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [SVProgressHUD dismissWithError:@"加载失败"];
    NSLog(@"加载失败!");
}

#pragma mark -View的生命周期
- (void)viewWillDisappear:(BOOL)animated{
    [self.tabBarController.tabBar setHidden:NO];
    [navbg removeFromSuperview];
    self.navigationController.navigationBarHidden=NO;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

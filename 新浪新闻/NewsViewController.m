//
//  NewsViewController.m
//  新浪新闻
//
//  Created by qianfeng on 14-9-5.
//  Copyright (c) 2014年 申冠华. All rights reserved.
//

#import "NewsViewController.h"
#import "NewsView.h"
#import "AddNewsViewController.h"
#import "SliderButtonView.h"

#import "HeadLineViewController.h"
#import "EntertainmentViewController.h"
#import "SportsViewController.h"
#import "EconomicsViewController.h"
#import "ScienceViewController.h"
#import "CarViewController.h"
#import "ComedyViewController.h"
#import "BeijingViewController.h"

@interface NewsViewController ()<SliderButtonViewDelegate,NewsViewDelegate>
{
    NewsView *_newView;
    UIScrollView *_scrollView;
    UIButton *_addBtn;
    SliderButtonView *_slider;
}
@end

@implementation NewsViewController

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
    [self prepareScrollView];
    SliderButtonView *slider=[[SliderButtonView alloc]initWithTitles:@[@"头条",@"娱乐",@"体育",@"财经",@"科技",@"汽车",@"搞笑",@"北京"]];
    slider.delegate=self;
    [self.navigationItem setTitleView:slider];
    _slider=slider;
}

#pragma mark -custom Method
- (void)prepareScrollView{
    HeadLineViewController *vc1=[[HeadLineViewController alloc]init];
    [vc1 setNavc:self.navigationController];
    EntertainmentViewController *vc2=[[EntertainmentViewController alloc]init];
    [vc2 setNavc:self.navigationController];
    SportsViewController *vc3=[[SportsViewController alloc]init];
    [vc3 setNavc:self.navigationController];
    EconomicsViewController *vc4=[[EconomicsViewController alloc]init];
    [vc4 setNavc:self.navigationController];
    ScienceViewController *vc5=[[ScienceViewController alloc]init];
    [vc5 setNavc:self.navigationController];
    CarViewController *vc6=[[CarViewController alloc]init];
    [vc6 setNavc:self.navigationController];
    ComedyViewController *vc7=[[ComedyViewController alloc]init];
    [vc7 setNavc:self.navigationController];
    BeijingViewController *vc8=[[BeijingViewController alloc]init];
    [vc8 setNavc:self.navigationController];

    CGFloat height=[UIScreen mainScreen].bounds.size.height-64-49;
    _newView = [[NewsView alloc]initWithControllers:@[vc1,vc2,vc3,vc4,vc5,vc6,vc7,vc8]];
    _newView.frame = CGRectMake(0, 64, 320, height);
    _newView.delegate = self;
    [self.view addSubview:_newView];
    
    _addBtn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    _addBtn.frame=CGRectMake(290, 13, 25, 25);
    [_addBtn setBackgroundImage:[UIImage imageNamed:@"slideTab_rightButton"] forState:UIControlStateNormal];
    [_addBtn addTarget:self action:@selector(addBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationController.navigationBar addSubview:_addBtn];

}
#pragma mark -sliderButtonView  delegate
- (void)sliderButtonView:(SliderButtonView *)slider clickedAtIndex:(NSInteger)index{
    [_newView setSelected:index];
}
- (void)newsView:(NewsView *)view didSelected:(NSInteger)index{
    [_slider selectAtIndex:index];
   
}

#pragma mark -view的生命周期
- (void)viewWillDisappear:(BOOL)animated{//view将要消失的时候
    [_scrollView removeFromSuperview];
    [_addBtn removeFromSuperview];
}
- (void)viewWillAppear:(BOOL)animated{//view将要出现的时候
    [self.navigationController.navigationBar addSubview:_scrollView];
    [self.navigationController.navigationBar addSubview:_addBtn];
}
- (void)addBtnClicked{
    AddNewsViewController *addNews=[[AddNewsViewController alloc]init];
    [self.navigationController pushViewController:addNews animated:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

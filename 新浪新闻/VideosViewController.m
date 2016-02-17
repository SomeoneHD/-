//
//  VideosViewController.m
//  新浪新闻
//
//  Created by qianfeng on 14-9-5.
//  Copyright (c) 2014年 申冠华. All rights reserved.
//

#import "VideosViewController.h"
#import "VideosView.h"

#import "SliderButtonView.h"
#import "SelectionViewController.h"
#import "ComedyVideoViewController.h"
#import "SceneViewController.h"
#import "BriefViewController.h"

@interface VideosViewController () <SliderButtonViewDelegate,VideosViewDelegate>
{
    VideosView *_videosView;
    SliderButtonView *_slider;
}
@end

@implementation VideosViewController

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
    
    SliderButtonView *slider = [[SliderButtonView alloc]initWithTitles:[NSArray arrayWithObjects:@"精选",@"搞笑",@"现场",@"花絮", nil]];
    slider.delegate = self;
    [self.navigationItem setTitleView:slider];
    _slider = slider;
    
    CGFloat height=[UIScreen mainScreen].bounds.size.height-64-49;
    _videosView=[[VideosView alloc]initWithFrame:CGRectMake(0, 64, 320, height)];
    [self.view addSubview:_videosView];
    [self prepareScrollView];
}
- (void)prepareScrollView{
    SelectionViewController *vc1 = [[SelectionViewController alloc]init];
    [vc1 setNavc:self.navigationController];
    ComedyVideoViewController *vc2 = [[ComedyVideoViewController alloc]init];
    [vc2 setNavc:self.navigationController];
    SceneViewController *vc3 = [[SceneViewController alloc]init];
    [vc3 setNavc:self.navigationController];
    BriefViewController *vc4 = [[BriefViewController alloc]init];
    [vc4 setNavc:self.navigationController];
    
    CGFloat height=[UIScreen mainScreen].bounds.size.height-64-49;
    _videosView = [[VideosView alloc]initWithControllers:@[vc1,vc2,vc3,vc4]];
    _videosView.frame = CGRectMake(0, 64, 320, height);
    _videosView.delegate = self;
    [self.view addSubview:_videosView];
}
- (void)sliderButtonView:(SliderButtonView *)slider clickedAtIndex:(NSInteger)index{
    [_videosView setSelected:index];
}

- (void)videosView:(VideosView *)view didSelected:(NSInteger)index{
    [_slider selectAtIndex:index];
}

- (void)btnClicked:(UIButton *)btn{
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

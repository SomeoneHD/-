//
//  PhotosViewController.m
//  新浪新闻
//
//  Created by qianfeng on 14-9-5.
//  Copyright (c) 2014年 申冠华. All rights reserved.
//

#import "PhotosViewController.h"
#import "PhotosView.h"
#import "SliderButtonView.h"
#import "ImagesViewController.h"
#import "InterestViewController.h"
#import "BeautifulViewController.h"
#import "StoryViewController.h"
@interface PhotosViewController ()<SliderButtonViewDelegate,PhotosViewDelegate>
{
    PhotosView *_photoView;
    SliderButtonView *_slider;
}
@end

@implementation PhotosViewController

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
    
    SliderButtonView *slider = [[SliderButtonView alloc]initWithTitles:[NSArray arrayWithObjects:@"图片",@"趣图",@"美图",@"故事", nil]];
    slider.delegate = self;
    [self.navigationItem setTitleView:slider];
    _slider = slider;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareScrollView{
    ImagesViewController *vc1 = [[ImagesViewController alloc]init];
    [vc1 setNavc:self.navigationController];
    InterestViewController *vc2 = [[InterestViewController alloc]init];
    [vc2 setNavc:self.navigationController];
    BeautifulViewController *vc3 = [[BeautifulViewController alloc]init];
    [vc3 setNavc:self.navigationController];
    StoryViewController *vc4 = [[StoryViewController alloc]init];
    [vc4 setNavc:self.navigationController];
    
    CGFloat height=[UIScreen mainScreen].bounds.size.height-64-49;
    _photoView = [[PhotosView alloc]initWithControllers:@[vc1,vc2,vc3,vc4]];
    _photoView.frame = CGRectMake(0, 0, 320, height);
    _photoView.delegate = self;
    [self.view addSubview:_photoView];
}

- (void)sliderButtonView:(SliderButtonView *)slider clickedAtIndex:(NSInteger)index{
    [_photoView setSelected:index];
}

- (void)photosView:(PhotosView *)view didSelected:(NSInteger)index{
    [_slider selectAtIndex:index];
}
@end

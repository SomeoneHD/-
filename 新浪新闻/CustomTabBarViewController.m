//
//  CustomTabBarViewController.m
//  新浪新闻
//
//  Created by qianfeng on 14-9-5.
//  Copyright (c) 2014年 申冠华. All rights reserved.
//

#import "CustomTabBarViewController.h"
#import "NewsViewController.h"
#import "PhotosViewController.h"
#import "VideosViewController.h"
#import "PersonalViewController.h"

@interface CustomTabBarViewController (){
    NSArray *_tabBarControllers;
}

@end

@implementation CustomTabBarViewController

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
    [self configTabBarViewControllers];
}
#pragma  mark -custom mothod
//标签栏设置
- (void)configTabBarViewControllers{
    //设置标签栏文字颜色
    UIColor *colorSelected=[UIColor redColor];
    UIColor *colorUnselected=[UIColor darkGrayColor];
    //新闻
    NewsViewController *news=[[NewsViewController alloc]init];
    UINavigationController *nav1=[[UINavigationController alloc]initWithRootViewController:news];
    [nav1.tabBarItem setTitle:@"新闻"];
    [nav1.tabBarItem setFinishedSelectedImage:[UIImage imageNamed:@"tabbar_news_hl"] withFinishedUnselectedImage:[UIImage imageNamed:@"tabbar_news"]];
    [nav1.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:colorUnselected,UITextAttributeTextColor, nil] forState:UIControlStateNormal];
    [nav1.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:colorSelected,UITextAttributeTextColor, nil] forState:UIControlStateSelected];
    //图片
    PhotosViewController *photo=[[PhotosViewController alloc]init];
    UINavigationController *nav2=[[UINavigationController alloc]initWithRootViewController:photo];
    [nav2.tabBarItem setTitle:@"图片"];
    [nav2.tabBarItem setFinishedSelectedImage:[UIImage imageNamed:@"tabbar_picture_hl"] withFinishedUnselectedImage:[UIImage imageNamed:@"tabbar_picture"]];
    [nav2.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:colorUnselected,UITextAttributeTextColor, nil] forState:UIControlStateNormal];
    [nav2.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:colorSelected,UITextAttributeTextColor, nil] forState:UIControlStateSelected];
    //视频
    VideosViewController *video=[[VideosViewController alloc]init];
    UINavigationController *nav3=[[UINavigationController alloc]initWithRootViewController:video];
    [nav3.tabBarItem setTitle:@"视频"];
    [nav3.tabBarItem setFinishedSelectedImage:[UIImage imageNamed:@"tabbar_video_hl"] withFinishedUnselectedImage:[UIImage imageNamed:@"tabbar_video"]];
    [nav3.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:colorUnselected,UITextAttributeTextColor, nil] forState:UIControlStateNormal];
    [nav3.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:colorSelected,UITextAttributeTextColor, nil] forState:UIControlStateSelected];
    //我的
    PersonalViewController *personal=[[PersonalViewController alloc]init];
    UINavigationController *nav4=[[UINavigationController alloc]initWithRootViewController:personal];
    [nav4.tabBarItem setTitle:@"我的"];
    [nav4.tabBarItem setFinishedSelectedImage:[UIImage imageNamed:@"tabbar_setting_hl"] withFinishedUnselectedImage:[UIImage imageNamed:@"tabbar_setting"]];
    [nav4.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:colorUnselected,UITextAttributeTextColor, nil] forState:UIControlStateNormal];
    [nav4.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:colorSelected,UITextAttributeTextColor, nil] forState:UIControlStateSelected];
    _tabBarControllers=@[nav1,nav2,nav3,nav4];
    self.viewControllers=_tabBarControllers;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

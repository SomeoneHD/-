//
//  HeadLineViewController.h
//  新浪新闻
//
//  Created by qianfeng on 14-9-5.
//  Copyright (c) 2014年 申冠华. All rights reserved.
//头条页面

#import <UIKit/UIKit.h>

@interface HeadLineViewController : UIViewController
<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, weak) UINavigationController *navc; //接收NewsViewController的navigation,用于push到下一界面

@end

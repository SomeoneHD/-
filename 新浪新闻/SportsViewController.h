//
//  SportsViewController.h
//  新浪新闻
//
//  Created by qianfeng on 14-9-5.
//  Copyright (c) 2014年 申冠华. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SportsViewController : UIViewController
<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,weak) UINavigationController *navc;
@end

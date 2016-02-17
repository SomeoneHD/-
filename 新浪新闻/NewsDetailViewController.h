//
//  NewsDetailViewController.h
//  新浪新闻
//
//  Created by qianfeng on 14-9-15.
//  Copyright (c) 2014年 申冠华. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "NewsToutiaoModel.h"
@interface NewsDetailViewController : UIViewController <UIWebViewDelegate,UIActionSheetDelegate>

@property (nonatomic,weak) UITabBarController *tabBar; //用于隐藏tabBar
@property (nonatomic,strong) NewsToutiaoModel *newsModel;
- (id)initWithModel:(NewsToutiaoModel *)model;

@end

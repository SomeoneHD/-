//
//  VideosDetailViewController.h
//  新浪新闻
//
//  Created by qianfeng on 14-9-18.
//  Copyright (c) 2014年 申冠华. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VideosModel.h"

@interface VideosDetailViewController : UIViewController <UIWebViewDelegate,UIActionSheetDelegate>

@property (nonatomic,weak) UITabBarController *tabc;
@property (nonatomic,strong) VideosModel *videosModel;

- (id)initWithModel:(VideosModel *)model;
@end

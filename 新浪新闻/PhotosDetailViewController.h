//
//  PhotosDetailViewController.h
//  新浪新闻
//
//  Created by qianfeng on 14-9-18.
//  Copyright (c) 2014年 申冠华. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PhotosModel.h"

@interface PhotosDetailViewController : UIViewController <UIWebViewDelegate,UIActionSheetDelegate>

@property (nonatomic,weak) UITabBarController *tabBar; //用于隐藏tabBar
@property (nonatomic,strong) PhotosModel *photosModel;
- (id)initWithModel:(PhotosModel *)model;
@end

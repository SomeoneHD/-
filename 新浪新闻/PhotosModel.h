//
//  PhotosModel.h
//  新浪新闻
//
//  Created by qianfeng on 14-9-12.
//  Copyright (c) 2014年 申冠华. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PhotosModel : NSObject

@property (nonatomic,copy) NSString *picString;//图片地址
@property (nonatomic,copy) NSString *totalString;//图片个数
@property (nonatomic,copy) NSString *titleString;//标题
@property (nonatomic,copy) NSString *comment_totalString;
@property (nonatomic,copy) NSString *linkString;

@end

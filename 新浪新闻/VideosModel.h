//
//  VideosModel.h
//  新浪新闻
//
//  Created by qianfeng on 14-9-12.
//  Copyright (c) 2014年 申冠华. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VideosModel : NSObject

@property (nonatomic,copy) NSString *picString;//图片
@property (nonatomic,copy) NSString *titleString;//标题
@property (nonatomic,copy) NSString *playnumberString;
@property (nonatomic,copy) NSString *runtimeString;
@property (nonatomic,copy) NSString *linkString;//链接
@end

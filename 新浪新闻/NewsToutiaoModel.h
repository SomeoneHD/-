//
//  NewsToutiaoModel.h
//  新浪新闻
//
//  Created by qianfeng on 14-9-9.
//  Copyright (c) 2014年 申冠华. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewsToutiaoModel : NSObject

//顶部scrollView
@property (nonatomic,copy) NSString *title;//标题
@property (nonatomic,copy) NSString *pic;//图片
@property (nonatomic,copy) NSString *total;
@property (nonatomic,assign) BOOL is_focus;
@property (nonatomic,copy) NSString *id;
@property (nonatomic,copy) NSString *category;
//listCmsModel
@property (nonatomic,copy) NSString *comment_count_info;
@property (nonatomic,copy) NSString *intro;
@property (nonatomic,copy) NSString *long_title;
@property (nonatomic,copy) NSDictionary *pics;
@property (nonatomic,copy) NSString *link;
@end

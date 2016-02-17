//
//  NewsView.h
//  新浪新闻
//
//  Created by qianfeng on 14-9-5.
//  Copyright (c) 2014年 申冠华. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NewsView;
@protocol NewsViewDelegate <NSObject>

//协议方法:newsView里的各个View显示在newsView上时index
- (void)newsView:(NewsView *)view didSelected:(NSInteger)index;
@end

@interface NewsView : UIView <UIScrollViewDelegate>

@property (nonatomic,weak) id<NewsViewDelegate>delegate; //设置代理
- (id)initWithControllers:(NSArray *)controllerArray; //重写init方法  (属性设置)
- (void)setSelected:(NSInteger)index; //设置当前的newsView，下标确定
@end

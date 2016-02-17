//
//  VideosView.h
//  新浪新闻
//
//  Created by qianfeng on 14-9-12.
//  Copyright (c) 2014年 申冠华. All rights reserved.
//

#import <UIKit/UIKit.h>
@class VideosView;
@protocol VideosViewDelegate <NSObject>

- (void)videosView:(VideosView *)view didSelected:(NSInteger)index;

@end

@interface VideosView : UIView<UIScrollViewDelegate>

@property (nonatomic, weak) id<VideosViewDelegate>delegate;

- (id)initWithControllers:(NSArray *)controllerArray;
- (void)setSelected:(NSInteger)index;
@end
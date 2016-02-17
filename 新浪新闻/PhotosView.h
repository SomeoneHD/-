
//
//  PhotosView.h
//  新浪新闻
//
//  Created by qianfeng on 14-9-12.
//  Copyright (c) 2014年 申冠华. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PhotosView;
@protocol PhotosViewDelegate <NSObject>

- (void)photosView:(PhotosView *)view didSelected:(NSInteger)index;

@end

@interface PhotosView : UIView<UIScrollViewDelegate>

@property (nonatomic, weak) id<PhotosViewDelegate>delegate;

- (id)initWithControllers:(NSArray *)controllerArray;
- (void)setSelected:(NSInteger)index;
@end

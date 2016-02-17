//
//  SliderButtonView.h
//  新浪新闻
//
//  Created by qianfeng on 14-9-15.
//  Copyright (c) 2014年 申冠华. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SliderButtonView;

@protocol SliderButtonViewDelegate <NSObject>
- (void)sliderButtonView:(SliderButtonView *)slider clickedAtIndex:(NSInteger)index;
@end

@interface SliderButtonView : UIView
@property (nonatomic, weak) id<SliderButtonViewDelegate>delegate;
- (id)initWithTitles:(NSArray *)titleArray;
- (void)selectAtIndex:(NSInteger)index;
@end
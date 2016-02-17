//
//  PhotosView.m
//  新浪新闻
//
//  Created by qianfeng on 14-9-12.
//  Copyright (c) 2014年 申冠华. All rights reserved.
//

#import "PhotosView.h"


@implementation PhotosView{
    UIScrollView *_scrollView;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (id)initWithControllers:(NSArray *)controllerArray{
    if (self = [super init]) {
        CGFloat height=[UIScreen mainScreen].bounds.size.height-49;
        _scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, 320, height)];
        _scrollView.showsHorizontalScrollIndicator=NO;
        _scrollView.bounces=NO;
        _scrollView.pagingEnabled=YES;
        _scrollView.contentSize=CGSizeMake(320*4, height-64-49);
        _scrollView.delegate = self;
        for (NSInteger i = 0; i<controllerArray.count; i++) {
            UIViewController *vc = controllerArray[i];
            CGRect frame = vc.view.frame;
            frame.origin.x = 320*i;
            vc.view.frame = frame;
            [_scrollView addSubview:vc.view];
        }
        [self addSubview:_scrollView];
    }
    return self;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSInteger currentPage = scrollView.contentOffset.x/320;
    if ([_delegate respondsToSelector:@selector(photosView:didSelected:)]) {
        [_delegate photosView:self didSelected:currentPage];
    }
}

- (void)setSelected:(NSInteger)index{
    [_scrollView setContentOffset:CGPointMake(320*index, -64) animated:YES];
}

@end

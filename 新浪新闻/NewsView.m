//
//  NewsView.m
//  新浪新闻
//
//  Created by qianfeng on 14-9-5.
//  Copyright (c) 2014年 申冠华. All rights reserved.
//

#import "NewsView.h"

@implementation NewsView{
    UIScrollView *_scrollView;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
       
    }
    return self;
}
- (id)initWithControllers:(NSArray *)controllerArray{ //重写init方法
    if (self=[super init]) {
        CGFloat height=[UIScreen mainScreen].bounds.size.height-49;
        _scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, -64, 320, height)];
        _scrollView.showsHorizontalScrollIndicator=NO;
        _scrollView.bounces=NO;
        _scrollView.pagingEnabled=YES;
        _scrollView.contentSize=CGSizeMake(320*8, height-64-49);
        _scrollView.delegate=self;
        for (NSInteger i=0; i<controllerArray.count; i++) {
            UIViewController *vc=controllerArray[i];
            CGRect frame=vc.view.frame;
            frame.origin.x=320*i;
            vc.view.frame=frame;
            [_scrollView addSubview:vc.view];
        }
        [self addSubview:_scrollView];
    }
    return self;
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSInteger currentPage=scrollView.contentOffset.x/320;
    if ([_delegate respondsToSelector:@selector(newsView:didSelected:)]) {
        [_delegate newsView:self didSelected:currentPage];
    }
}
- (void)setSelected:(NSInteger)index{
    [_scrollView setContentOffset:CGPointMake(320*index, -64) animated:YES];
}
@end

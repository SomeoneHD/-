//
//  NewsToutiaoView.m
//  新浪新闻
//
//  Created by qianfeng on 14-9-10.
//  Copyright (c) 2014年 申冠华. All rights reserved.
//

#import "NewsToutiaoView.h"
#import "UIImageView+WebCache.h"
#import "NewsToutiaoModel.h"

@implementation NewsToutiaoView{
    UIScrollView *_scrollView;
    UIPageControl *_pageControl;
    UILabel *_titleLabel;
    NSArray *_modelArray;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, 320, 162)];
        _scrollView.delegate=self;
        _scrollView.showsHorizontalScrollIndicator=NO;
        _scrollView.pagingEnabled=YES;
        [self addSubview:_scrollView];
    
        _titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 132, 320, 30)];
        _titleLabel.backgroundColor=[UIColor darkTextColor];
        [_titleLabel setTextColor:[UIColor whiteColor]];
        [_titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:15]];
        [self addSubview:_titleLabel];
        
        _pageControl=[[UIPageControl alloc]initWithFrame:CGRectMake(260, 110, 50, 20)];
        _pageControl.currentPageIndicatorTintColor=[UIColor redColor];
        _pageControl.pageIndicatorTintColor=[UIColor whiteColor];
        [self addSubview:_pageControl];
    }
    return self;
}

- (void)sendEventArray:(NSArray *)array{
    _scrollView.contentSize=CGSizeMake(320*array.count, 162);
    _modelArray = [array copy];
    [_titleLabel setText:[NSString stringWithFormat:@"  %@",((NewsToutiaoModel *)array[0]).title]];
    for (NSInteger i=0; i<array.count; i++) {
        NewsToutiaoModel *model=array[i];
        UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(320*i, 0, 320, 162)];
        [imageView setImageWithURL:[NSURL URLWithString:model.pic]];
        [_scrollView addSubview:imageView];
        [_pageControl setNumberOfPages:array.count];
    }
}

#pragma mark -scrollView delegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSInteger pageindex = scrollView.contentOffset.x/320;
    if (_pageControl.numberOfPages>=pageindex) {
        [_pageControl setCurrentPage:pageindex];
    }
    [_titleLabel setText:[NSString stringWithFormat:@"  %@",((NewsToutiaoModel *)_modelArray[pageindex]).title]];

}
@end

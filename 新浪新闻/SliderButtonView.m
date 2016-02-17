//
//  SliderButtonView.m
//  新浪新闻
//
//  Created by qianfeng on 14-9-15.
//  Copyright (c) 2014年 申冠华. All rights reserved.
//

#import "SliderButtonView.h"

@implementation SliderButtonView{
    UIScrollView *_scrollView;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

#pragma mark -custom method
- (id)initWithTitles:(NSArray *)titleArray{ //重写init方法
    if (self = [super init]) {
        _scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, 260, 44)];
        _scrollView.showsHorizontalScrollIndicator=NO; //不显示横向滚动条
        for (int i=0; i<titleArray.count;i++) {
            _scrollView.contentSize=CGSizeMake(67*i, 44);
            UIButton *btn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
            btn.frame=CGRectMake(45*i+15*i, 15, 45, 25);
            btn.tag=100+i;
            [btn setTitle:titleArray[i] forState:UIControlStateNormal];
            btn.titleLabel.font=[UIFont systemFontOfSize:16];
            [btn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
            [btn setTintColor:[UIColor colorWithWhite:0.9 alpha:1]];
            [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
            [_scrollView addSubview:btn];
        }
        self.frame = _scrollView.bounds;
        [self addSubview:_scrollView];
        [self selectAtIndex:0];
    }
    return self;
}

- (void)selectAtIndex:(NSInteger)index{
    for (UIView *obj in _scrollView.subviews) {
        if ([obj isKindOfClass:[UIButton class]]) {
            UIButton *btn = (UIButton *)obj;
            [btn setSelected:NO];
        }
    }
    UIButton *btn = (UIButton *)[_scrollView viewWithTag:100+index];
    [btn setSelected:YES];
    if (index==4) {
        _scrollView.contentOffset=CGPointMake(67*3, 0);
    }
    if (index<4) {
        _scrollView.contentOffset=CGPointMake(0, 0);
    }
}

#pragma mark -SliderButtonViewDelegate
- (void)btnClicked:(UIButton *)sender{
    [self selectAtIndex:sender.tag-100];
    if ([_delegate respondsToSelector:@selector(sliderButtonView:clickedAtIndex:)]) {
        [_delegate sliderButtonView:self clickedAtIndex:sender.tag-100];
    }
}

@end

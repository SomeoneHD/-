//
//  AddNewsViewController.m
//  新浪新闻
//
//  Created by qianfeng on 14-9-15.
//  Copyright (c) 2014年 申冠华. All rights reserved.
//

#import "AddNewsViewController.h"

@interface AddNewsViewController (){
    UILabel *_label;
    UIButton *_add;
}

@end

@implementation AddNewsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor whiteColor];
    [self createNav];
}
- (void)createNav{
    _label=[[UILabel alloc]initWithFrame:CGRectMake(145, 13, 40, 20)];
    [_label setText:@"更多"];
    _label.font=[UIFont systemFontOfSize:18];
    [self.navigationController.navigationBar addSubview:_label];
    
    _add=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    _add.frame=CGRectMake(270, 20, 40, 10);
    [_add setTitle:@"添加" forState:UIControlStateNormal];
    _add.titleLabel.font=[UIFont systemFontOfSize:17];
    [_add setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.navigationController.navigationBar addSubview:_add];

}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewWillAppear:(BOOL)animated{
    [self.tabBarController.tabBar setHidden:YES];
}
- (void)viewWillDisappear:(BOOL)animated{
    [_label removeFromSuperview];
    [_add removeFromSuperview];
    [self.tabBarController.tabBar setHidden:NO];
}
@end

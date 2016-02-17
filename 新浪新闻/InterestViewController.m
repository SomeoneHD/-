//
//  ImagesViewController.m
//  新浪新闻
//
//  Created by qianfeng on 14-9-5.
//  Copyright (c) 2014年 申冠华. All rights reserved.
//

#import "InterestViewController.h"
#import "PhotosDetailViewController.h"
#import "BlockHttpRequest.h"
#import "UIImageView+WebCache.h"
#import "PhotosModel.h"
#import "PhotosViewCell.h"
@interface InterestViewController ()
{
    UITableView *_tableView;
    NSMutableArray *_dataArray;
    BlockHttpRequest *_httpRequest;
    UIRefreshControl *_refreshControl;
}
@end

@implementation InterestViewController

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
    _dataArray=[[NSMutableArray alloc]init];
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, 455) style:UITableViewStylePlain];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    self.automaticallyAdjustsScrollViewInsets=NO;
    [self.view addSubview:_tableView];
    
    //下拉刷新 (系统自带的,ios6之后)
    _refreshControl=[[UIRefreshControl alloc]init];
    _refreshControl.attributedTitle=[[NSAttributedString alloc]initWithString:@"下拉刷新"];
    [_refreshControl addTarget:self action:@selector(refreshData) forControlEvents:UIControlEventValueChanged];
    [_tableView addSubview:_refreshControl];//加到tableView上，会自动布局
    
    _httpRequest=[[BlockHttpRequest alloc]initWithUrlString:[NSString stringWithFormat:kUrlString,@"hdpic_funny"] finishedBlock:^(NSData *data){
        NSDictionary *dic=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSDictionary *Data=dic[@"data"];
        NSArray *list=Data[@"list"];
        for (NSDictionary *perDic in list) {
            PhotosModel *model=[[PhotosModel alloc]init];
            model.picString=perDic[@"pic"];
            model.titleString=perDic[@"title"];
            model.linkString=perDic[@"link"];
            model.totalString=[perDic[@"pics"]objectForKey:@"total"];
            model.comment_totalString=[perDic[@"comment_count_info"] objectForKey:@"total"];
            [_dataArray addObject:model];
        }
        [_tableView reloadData];
    }failedBlock:^(NSString *errorMessage){
        NSLog(@"error:%@",errorMessage);
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -下拉刷新
- (void)refreshData{
    [_refreshControl beginRefreshing];//开始刷新
    NSLog(@"开始刷新");
    _refreshControl.attributedTitle=[[NSAttributedString alloc]initWithString:@"刷新中"];
    [self performSelector:@selector(addData) withObject:nil afterDelay:1.5];
}
- (void)addData{
    [_tableView reloadData];
    [_refreshControl endRefreshing];//结束刷新
    NSLog(@"刷新结束");
    _refreshControl.attributedTitle=[[NSAttributedString alloc]initWithString:@"刷新完成"];
}

#pragma mark -tableView delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 200;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    PhotosModel *model=_dataArray[indexPath.row];
    PhotosDetailViewController *photosDetail=[[PhotosDetailViewController alloc]initWithModel:model];
    [photosDetail setTabBar:self.tabBarController];
    [self.navc pushViewController:photosDetail animated:NO];
}
#pragma mark -tableView dataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell;
    PhotosViewCell *photosViewCell=[tableView dequeueReusableCellWithIdentifier:@"PhotosViewCell"];
    if (photosViewCell==nil) {
        photosViewCell=[[[NSBundle mainBundle]loadNibNamed:@"PhotosViewCell" owner:self options:nil]lastObject];
    }
    PhotosModel *model=_dataArray[indexPath.row];
    [photosViewCell.picImageView setImageWithURL:[NSURL URLWithString:model.picString]];
    [photosViewCell.titleLabel setText:[NSString stringWithFormat:@"  %@",model.titleString]];
    [photosViewCell.totalLabel setText:[NSString stringWithFormat:@"%@图",model.totalString]];
    [photosViewCell.commentLabel setText:[NSString stringWithFormat:@"%@",model.comment_totalString]];
    cell=photosViewCell;
    return cell;
}

@end

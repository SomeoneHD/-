//
//  HeadLineViewController.m
//  新浪新闻
//
//  Created by qianfeng on 14-9-5.
//  Copyright (c) 2014年 申冠华. All rights reserved.
//

#import "HeadLineViewController.h"
#import "NewsDetailViewController.h"
#import "BlockHttpRequest.h"
#import "UIImageView+WebCache.h"
#import "NewsToutiaoModel.h"
#import "NewsToutiaoView.h"
#import "listCmsCell.h"
#import "listCmsCell1.h"
#import "MJRefresh.h" //使用第三方的下拉刷新

@interface HeadLineViewController ()
{
    NSMutableArray *_headDataArray;//顶部热点图片的数据源 headView
    NSMutableArray *_listDataArray;//tableView的数据源
    UITableView *_tableView;
    BlockHttpRequest *_httpRequest;
    NewsToutiaoView *_newsHeadView;
}
@end

@implementation HeadLineViewController

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
    //顶部图片
    _newsHeadView=[[NewsToutiaoView alloc]initWithFrame:CGRectMake(0, 0, 320, 162)];
    _headDataArray=[[NSMutableArray alloc]init];
    _listDataArray=[[NSMutableArray alloc]init];
    
    //表格
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, 455) style:UITableViewStylePlain];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.tableHeaderView = _newsHeadView;//设置成headView
    [_tableView addHeaderWithTarget:self action:@selector(headerRereshing)];//下拉刷新
    [self.view addSubview:_tableView];
    
    [self httpRequest];//请求网络
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -BlockHttpRequest请求
- (void)httpRequest{
    //BlockHttpRequest请求  （Json解析）
    _httpRequest=[[BlockHttpRequest alloc]initWithUrlString:[NSString stringWithFormat:kUrlString,@"news_toutiao"] finishedBlock:^(NSData *data){
        NSDictionary *dic=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSDictionary *data1=dic[@"data"];
        NSArray *array=data1[@"list"];
        for (NSDictionary *perDic in array) {
            NewsToutiaoModel *model=[[NewsToutiaoModel alloc]init];
            [model setValuesForKeysWithDictionary:perDic];
            model.total=[perDic[@"pics"] objectForKey:@"total"];
            model.comment_count_info=[perDic[@"comment_count_info"] objectForKey:@"total"];
            if (model.is_focus) { //顶部图片
                [_headDataArray addObject:model];
            }else{ //顶部下方表格
                [_listDataArray addObject:model];
            }
        }
        [_newsHeadView sendEventArray:_headDataArray];
        [_tableView reloadData];
    }failedBlock:^(NSString *errorMessage){
        NSLog(@"error:%@",errorMessage);
    }];
}

#pragma mark -刷新
- (void)headerRereshing{
    [_listDataArray removeAllObjects];//每次刷新前先将上次数据清空
    [_headDataArray removeAllObjects];
    NSLog(@"刷新请求网络");
    [self httpRequest];//刷新 重新请求网络
    
    [_tableView headerEndRefreshing];//结束刷新
}
#pragma mark -tableView delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _listDataArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NewsToutiaoModel *model=_listDataArray[indexPath.row];
    if ([model.category isEqualToString:@"hdpic"]) {
        return 125;
    }
    return 80;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NewsToutiaoModel *model=_listDataArray[indexPath.row];
    NewsDetailViewController *newsDetail=[[NewsDetailViewController alloc]initWithModel:model];
    [newsDetail setTabBar:self.tabBarController];  //设置newsDetail的tabBar,其本身没有tabBar
    [self.navc pushViewController:newsDetail animated:NO];  //要将self的superViewController的navigation传给self
}

#pragma mark -tableView dataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell;
    NewsToutiaoModel *model=_listDataArray[indexPath.row];
    if ([model.category isEqualToString:@"hdpic"]){
        listCmsCell1 *cmsCell1=[tableView dequeueReusableCellWithIdentifier:@"listCmsCell1"];
        if (cmsCell1==nil) {
            cmsCell1=[[[NSBundle mainBundle]loadNibNamed:@"listCmsCell1" owner:self options:nil]lastObject];
        }
        [cmsCell1.introLabel setText:model.long_title];
        [cmsCell1.commentLabel setText:[NSString stringWithFormat:@"%@",model.comment_count_info]];
        [cmsCell1.totalLabel setText:[NSString stringWithFormat:@"%@",model.total]];
        NSArray *list=model.pics[@"list"];
        [cmsCell1.pic1ImageView setImageWithURL:[NSURL URLWithString:[list[0] objectForKey:@"pic"]]];
        [cmsCell1.pic2ImageView setImageWithURL:[NSURL URLWithString:[list[1] objectForKey:@"pic"]]];
        [cmsCell1.pic3ImageView setImageWithURL:[NSURL URLWithString:[list[2] objectForKey:@"pic"]]];
        cell=cmsCell1;
    }else{
        listCmsCell *cmsCell=[tableView dequeueReusableCellWithIdentifier:@"listCmsCell"];
        if (cmsCell==nil) {
            cmsCell=[[[NSBundle mainBundle]loadNibNamed:@"listCmsCell" owner:self options:nil]lastObject];
        }
        [cmsCell.picImageView setImageWithURL:[NSURL URLWithString:model.pic]];
        [cmsCell.titleLabel setText:model.title];
        [cmsCell.introLabel setText:model.intro];
        [cmsCell.commentLabel setText:[NSString stringWithFormat:@"%@", model.comment_count_info]];
        
        if ([model.category isEqualToString:@"video"]) {
            [cmsCell.categroyImageView setImage:[UIImage imageNamed:@"feed_cell_video_mark"]];
            [cmsCell.categroyLabel setText:@"视频"];
            [cmsCell.categroyLabel setTextColor:[UIColor colorWithRed:35.0/255 green:120.0/255 blue:250.0/255 alpha:1]];
        }else if ([model.category isEqualToString:@"subject"]){
            [cmsCell.categroyImageView setImage:[UIImage imageNamed:@"feed_cell_subject_mark"]];
            [cmsCell.categroyLabel setText:@"专题"];
            [cmsCell.categroyLabel setTextColor:[UIColor redColor]];
        }else{//占位的作用
            [cmsCell.categroyImageView setImage:[UIImage imageNamed:@" "]];
            [cmsCell.categroyLabel setText:@" "];
        }
        cell=cmsCell;
    }
    return cell;
}

@end

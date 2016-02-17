//
//  SelectionViewController.m
//  新浪新闻
//
//  Created by qianfeng on 14-9-5.
//  Copyright (c) 2014年 申冠华. All rights reserved.
//

#import "BriefViewController.h"
#import "VideosDetailViewController.h"
#import "BlockHttpRequest.h"
#import "VideosModel.h"
#import "VideosCell.h"
#import "UIImageView+WebCache.h"

@interface BriefViewController ()
{
    BlockHttpRequest *_httpRequest;
    NSMutableArray *_dataArray;
    UITableView *_tableView;
}
@end

@implementation BriefViewController

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
	_dataArray=[[NSMutableArray alloc]init];
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, 455) style:UITableViewStylePlain];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    [self.view addSubview:_tableView];
    _httpRequest=[[BlockHttpRequest alloc]initWithUrlString:[NSString stringWithFormat:kUrlString,@"video_highlights"] finishedBlock:^(NSData *data){
        NSDictionary *dic=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSDictionary *data1=dic[@"data"];
        NSArray *list=data1[@"list"];
        for (NSDictionary *perDic in list) {
            VideosModel *model=[[VideosModel alloc]init];
            model.picString=perDic[@"pic"];
            model.titleString=perDic[@"title"];
            model.linkString=perDic[@"link"];
            model.playnumberString=[perDic[@"video_info"] objectForKey:@"playnumber"];
            model.runtimeString=[perDic[@"video_info"] objectForKey:@"runtime"];
            [_dataArray addObject:model];
        }
        [_tableView reloadData];
    }failedBlock:^(NSString *errorMessage){
        NSLog(@"errorMessage:%@",errorMessage);
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -tableView delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 200;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    VideosModel *model=_dataArray[indexPath.row];
    VideosDetailViewController *videosDetail=[[VideosDetailViewController alloc]initWithModel:model];
    [videosDetail setTabc:self.tabBarController];
    [self.navc pushViewController:videosDetail animated:NO];
}
#pragma mark -tableView dataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell;
    VideosCell *videosCell=[tableView dequeueReusableCellWithIdentifier:@"VideosCell"];
    if (videosCell==nil) {
        videosCell=[[[NSBundle mainBundle]loadNibNamed:@"VideosCell" owner:self options:nil]lastObject];
    }
    VideosModel *model=_dataArray[indexPath.row];
    [videosCell.picImageVIew setImageWithURL:[NSURL URLWithString:model.picString]];
    [videosCell.titleLabel setText:[NSString stringWithFormat:@"   %@",model.titleString]];
    [videosCell.playnumberLabel setText:model.playnumberString];
    [videosCell.runtimeLabel setText:model.runtimeString];
    cell=videosCell;
    return cell;
}


@end

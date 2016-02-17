//
//  PersonalViewController.m
//  新浪新闻
//
//  Created by qianfeng on 14-9-5.
//  Copyright (c) 2014年 申冠华. All rights reserved.
//

#import "PersonalViewController.h"
#import "PersonalCell.h"
@interface PersonalViewController (){
    UITableView *_tableView;
    NSMutableArray *_dataArray1;
    NSMutableArray *_dataArray2;
    NSMutableArray *_dataArray3;
    NSMutableArray *_dataArray4;
}

@end

@implementation PersonalViewController

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
    self.navigationController.navigationBarHidden=YES;
    
    //section==0
    _dataArray1= [[NSMutableArray alloc] init];
    NSArray *array1 = [NSArray arrayWithObject:@""];
    [_dataArray1 addObject:array1];
    //section==1
    _dataArray2=[[NSMutableArray alloc]init];
    NSArray *array2=@[@"离线下载",@"夜间模式",@"头条推送",@"仅Wi-Fi下载图片",@"离线设置",@"正文字号",@"清除缓存"];
    [_dataArray2 addObject:array2];
    //section==2
    _dataArray3=[[NSMutableArray alloc]init];
    NSArray *array3=[NSArray arrayWithObjects:@"反馈",@"检查更新",@"关于", nil];
    [_dataArray3 addObject:array3];
    //section==3
    _dataArray4=[[NSMutableArray alloc]init];
    NSString *str=@"应用中心";
    [_dataArray4 addObject:str];
    
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, 550) style:UITableViewStylePlain];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    [self.view addSubview:_tableView];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -tableView delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return 1;
    }else if (section==1){
        return 7;
    }else if (section==2){
        return 3;
    }
    else
        return 1;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        return 230;
    }
    return 44;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (section==0) {
        return nil;
    }
    return @" ";
}

#pragma mark -tableView dataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        UITableViewCell *cell;
        PersonalCell *personalCell=[tableView dequeueReusableCellWithIdentifier:@"PersonalCell"];
        if (personalCell == nil) {
            personalCell = [[[NSBundle mainBundle] loadNibNamed:@"PersonalCell" owner:self options:nil]lastObject];
        }
        cell=personalCell;
        return cell;
    }else if (indexPath.section==1){
        static NSString *cellIde=@"cell";
        UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellIde];
        if (cell==nil) {
            cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIde];
        }
        if (indexPath.row==0||indexPath.row==4||indexPath.row==5) {
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        }
        if (indexPath.row>0&&indexPath.row<4) {
            //开关控件
            UISwitch *st=[[UISwitch alloc]initWithFrame:CGRectMake(250, 6, 0, 0)];
            if (indexPath.row==2) {
                st.on=YES;
            }
            [cell addSubview:st];
        }
        cell.textLabel.text=_dataArray2[0][indexPath.row];
        cell.textLabel.textColor=[UIColor darkGrayColor];
        return cell;
    }else if (indexPath.section==2){
        static NSString *cellIde=@"cell";
        UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellIde];
        if (cell==nil) {
            cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIde];
        }
        if (indexPath.row==0||indexPath.row==2) {
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        }
        cell.textLabel.text=_dataArray3[0][indexPath.row];
        cell.textLabel.textColor=[UIColor darkGrayColor];
        return cell;
    }
    else{
        static NSString *cellIde=@"cell";
        UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellIde];
        if (cell==nil) {
            cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIde];
        }
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.text=_dataArray4[indexPath.row];
        cell.textLabel.textColor=[UIColor darkGrayColor];
        return cell;
    }
}

@end

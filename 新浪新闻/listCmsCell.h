//
//  listCmsCell.h
//  新浪新闻
//
//  Created by qianfeng on 14-9-11.
//  Copyright (c) 2014年 申冠华. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface listCmsCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *picImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *introLabel;
@property (weak, nonatomic) IBOutlet UILabel *commentLabel;
@property (weak, nonatomic) IBOutlet UIImageView *categroyImageView;
@property (weak, nonatomic) IBOutlet UILabel *categroyLabel;

@end

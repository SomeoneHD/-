
//
//  NSFileManager+pathMethod.m
//  新浪新闻
//
//  Created by qianfeng on 14-9-5.
//  Copyright (c) 2014年 申冠华. All rights reserved.
//

#import "NSFileManager+pathMethod.h"

@implementation NSFileManager (pathMethod)

+(BOOL)isTimeOutWithPath:(NSString *)path time:(NSTimeInterval)time{
    NSDictionary *dic =[[NSFileManager defaultManager] attributesOfItemAtPath:path error:nil];
    //NSFileModificationDate 获取文件的修改时间
    NSDate *date =[dic objectForKey:NSFileModificationDate];
    NSDate *currentDate = [NSDate date];
    //算时间差
    NSTimeInterval current= [currentDate timeIntervalSinceDate:date];
    if (current>time) {
        //超时
        return YES;
    }else{
        return NO;
    }
}

@end

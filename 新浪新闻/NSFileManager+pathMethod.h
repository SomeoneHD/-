//
//  NSFileManager+pathMethod.h
//  新浪新闻
//
//  Created by qianfeng on 14-9-5.
//  Copyright (c) 2014年 申冠华. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSFileManager (pathMethod)

//类别方法:判断指定路径下的文件，是否超出了规定的时间
+(BOOL)isTimeOutWithPath:(NSString *)path time:(NSTimeInterval)time;

@end

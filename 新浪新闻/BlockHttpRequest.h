//
//  BlockHttpRequest.h
//  新浪新闻
//
//  Created by qianfeng on 14-9-5.
//  Copyright (c) 2014年 申冠华. All rights reserved.
//

#import <Foundation/Foundation.h>

//用block封装网络请求
typedef void(^DownloadFinishedBlock)(NSData *data);//请求成功
typedef void(^DownloadFailedBlock)(NSString *errorMessage);//请求失败

@interface BlockHttpRequest : NSObject <NSURLConnectionDataDelegate>

- (id)initWithUrlString:(NSString *)urlString finishedBlock:(DownloadFinishedBlock)finished failedBlock:(DownloadFailedBlock)failed; //重写init方法，(网络请求)

@end

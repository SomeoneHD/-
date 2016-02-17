//
//  BlockHttpRequest.m
//  新浪新闻
//
//  Created by qianfeng on 14-9-5.
//  Copyright (c) 2014年 申冠华. All rights reserved.
//

#import "BlockHttpRequest.h"
#import "NSString+Hashing.h"//MD5加密处理
#import "NSFileManager+pathMethod.h"

@implementation BlockHttpRequest{
    NSMutableData *_downloadData;//数据
    NSURLConnection *_urlConnection;
    DownloadFinishedBlock _finishedBlock;//接收外部传过来的值
    DownloadFailedBlock _failedBlock;
    NSString *fileNameString;//定义文件名，用于获取本地缓存文件数据
}

//返回数据在本地的存储路径(文件名MD5加密)
+ (NSString *)pathWithFileName:(NSString *)fileName{
    return [NSHomeDirectory() stringByAppendingFormat:@"/Documents/%@",[fileName MD5Hash]];//沙盒目录
}

#pragma mark -custom Method
- (id)initWithUrlString:(NSString *)urlString finishedBlock:(DownloadFinishedBlock)finished failedBlock:(DownloadFailedBlock)failed {
    fileNameString=urlString;
    self=[super init];
    if (self) {
        _downloadData=[[NSMutableData alloc]init];//初始化_downloadData
        if (_finishedBlock!=finished) {
            _finishedBlock=nil;
            _finishedBlock=finished;
        }
        if (_failedBlock!=failed) {
            _failedBlock=nil;
            _failedBlock=failed;
        }
        NSString *path=[BlockHttpRequest pathWithFileName:urlString];
        //如果指定路径下文件存在并且没有超过规定时间,则使用本地缓存  :在规定的时间内找到缓存了
        if ([[NSFileManager defaultManager]fileExistsAtPath:path] && ([NSFileManager isTimeOutWithPath:path time:60*60]==NO)) {
            NSLog(@"使用本地缓存数据");
            NSData *data=[NSData dataWithContentsOfFile:path];
            //直接使用本地数据
            [_downloadData setLength:0]; //清空请求
            [_downloadData appendData:data];//得到本地缓存数据
            _finishedBlock(_downloadData);//回调，数据可视化显示在view上
        }else{ //否则请求网络数据
            NSLog(@"请求网络数据");
            if (urlString.length==0) {
                NSLog(@"没有请求地址!");
                return nil;
            }
            NSURL *url=[NSURL URLWithString:urlString];
            NSURLRequest *request=[NSURLRequest requestWithURL:url];
            _urlConnection=[[NSURLConnection alloc]initWithRequest:request delegate:self];
        }
    }
    return self;
}

#pragma mark -NSURLConnection dataDelegate
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    if (_downloadData) {
        [_downloadData setLength:0];//清空以前的数据
    }
}
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    [_downloadData appendData:data];//获取现在的数据
}
- (void)connectionDidFinishLoading:(NSURLConnection *)connection{
    NSString *path=[BlockHttpRequest pathWithFileName:[NSString stringWithFormat:@"%@",fileNameString]];
    [_downloadData writeToFile:path atomically:YES];//将网络请求下来的数据写入缓存中
    _finishedBlock(_downloadData);
}
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    NSLog(@"connection error:%@",error.description);
}
@end

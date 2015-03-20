//
//  DownloadManager.m
//  NSOperation
//
//  Created by 王钱钧 on 15/3/20.
//  Copyright (c) 2015年 Arthur. All rights reserved.
//

#import "DownloadManager.h"

/**
 *  只要将一个NSOperation（实际开中需要使用其子类NSInvocationOperation、NSBlockOperation）放到NSOperationQueue这个队列中线程就会依次启动。
 
    NSOperationQueue负责管理、执行所有的NSOperation，在这个过程中可以更加容易的管理线程总数和控制线程之间的依赖关系
 
    NSOperation有两个常用子类用于创建线程操作：NSInvocationOperation和NSBlockOperation，两种方式本质没有区别，但是是后者使用Block形式进行代码组织，使用相对方便。
 */

@implementation DownloadManager

+ (instancetype)manager
{
    static dispatch_once_t onceToken;
    static DownloadManager *_manager = nil;
    
    dispatch_once(&onceToken, ^{
        _manager = [[DownloadManager alloc] init];
    });
    
    return _manager;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    
    return self;
}

- (void)downloadWithMultiThread {
    NSInvocationOperation *invocationOperation = [[NSInvocationOperation alloc]initWithTarget:self selector:@selector(downloadSingle) object:nil];
    //创建完NSInvocationOperation对象并不会调用，它由一个start方法启动操作，但是注意如果直接调用start方法，则此操作会在主线程中调用，一般不会这么操作,而是添加到NSOperationQueue中
    
//    [invocationOperation start];
    
    // 创建操作队列
    NSOperationQueue *operationQueue = [[NSOperationQueue alloc]init];
    [operationQueue addOperation:invocationOperation];

}

- (void)downloadSingle {
    NSLog(@"downloadSingle");
}
@end

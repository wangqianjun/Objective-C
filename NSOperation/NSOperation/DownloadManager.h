//
//  DownloadManager.h
//  NSOperation
//
//  Created by 王钱钧 on 15/3/20.
//  Copyright (c) 2015年 Arthur. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DownloadManager : NSObject

+ (instancetype)manager;


- (void)downloadWithMultiThread;
@end

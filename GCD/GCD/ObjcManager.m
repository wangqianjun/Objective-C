//
//  ObjcManager.m
//  GCD
//
//  Created by 王钱钧 on 15/1/21.
//  Copyright (c) 2015年 Arthur. All rights reserved.
//

#import "ObjcManager.h"


@implementation ObjcManager


+ (instancetype)shareManager
{
    static ObjcManager *shareManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{ // 保证线程安全
        shareManager = [[ObjcManager alloc]init];
    });
    
    return shareManager;
}

- (id)init
{
    self = [super init];
    if (self) {
        self.mArrary = [[NSMutableArray alloc]initWithCapacity:0];
        
        self.concurrentRWQueue =
        dispatch_queue_create("readerWriterQueue", DISPATCH_QUEUE_CONCURRENT);
//        dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0);
    }
    
    return self;
}

- (void)writers:(NSString *)obj
{
    [self.mArrary addObject:obj];
}

- (void)readers
{
    NSLog(@"arr: \n %@", self.mArrary);
}
@end

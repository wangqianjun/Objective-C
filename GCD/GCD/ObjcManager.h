//
//  ObjcManager.h
//  GCD
//
//  Created by 王钱钧 on 15/1/21.
//  Copyright (c) 2015年 Arthur. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ObjcManager : NSObject


@property (strong, nonatomic) NSMutableArray *mArrary;
@property (strong, nonatomic) dispatch_queue_t concurrentRWQueue;
+ (instancetype)shareManager;

- (void)readers;
- (void)writers:(NSString *)obj;
@end

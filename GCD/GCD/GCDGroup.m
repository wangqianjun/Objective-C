//
//  GCDGroup.m
//  GCD
//
//  Created by 王钱钧 on 15/3/19.
//  Copyright (c) 2015年 Arthur. All rights reserved.
//

#import "GCDGroup.h"

static dispatch_group_t _taskGroup;
static dispatch_group_t _enterGroup;
static dispatch_queue_t _task1Queue;
static dispatch_queue_t _task2Queue;
static dispatch_queue_t _task3Queue;

@implementation GCDGroup

- (instancetype)init
{
    self = [super init];
    if (self) {
        _taskGroup = dispatch_group_create();
        _enterGroup = dispatch_group_create();
        _task1Queue = dispatch_queue_create("arthur.test.q1", NULL);
        _task2Queue = dispatch_queue_create("arthur.test.q2", NULL);
        _task3Queue = dispatch_queue_create("arthur.test.q3", NULL);
    }
    
    return self;
}

/*
 手动管理group关联的block的运行状态（或计数），进入和退出group次数必须匹配
 
 dispatch_group_enter(group);
 
 dispatch_group_leave(group);
 
 所以下面的两种调用其实是等价的，
 
 A)
 
 dispatch_group_async(group, queue, ^{
 
 　　// 。。。
 
 });
 
 B)
 
 dispatch_group_enter(group);
 
 dispatch_async(queue, ^{
 
 　　//。。。
 
 　　dispatch_group_leave(group);
 
 });
 
 所以，可以利用dispatch_group_enter、 dispatch_group_leave和dispatch_group_wait来实现同步，具体例子：http://stackoverflow.com/questions/10643797/wait-until-multiple-operations-executed-including-completion-block-afnetworki/10644282#10644282。
 */


- (void)testDispatchGroup
{
    [self task1];
    [self task2];
//    [self task3];
    dispatch_group_enter(_enterGroup);
    dispatch_async(_task3Queue, ^{
        for (int i = 0; i<10; i++) {
            NSLog(@"task3:   i = %d", i);
        }
        
//        dispatch_group_leave(_enterGroup);
    });
}

- (void)task1 {
    
    dispatch_group_async(_taskGroup, _task1Queue, ^{
        for (int i = 0; i<10; i++) {
            NSLog(@"task1: i = %d", i);
        }
    });

}

- (void)task2 {
    dispatch_group_async(_taskGroup,_task2Queue, ^{
        for (int i = 0; i<10; i++) {
            NSLog(@"task2:  i = %d", i);
        }
    });
    
}

- (void)task3 {
    dispatch_group_async(_enterGroup,_task3Queue, ^{
        for (int i = 0; i<10; i++) {
            NSLog(@"task3:   i = %d", i);
        }
    });
    
}
@end

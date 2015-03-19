//
//  ViewController.m
//  GCD
//
//  Created by 王钱钧 on 15/1/21.
//  Copyright (c) 2015年 Arthur. All rights reserved.
//

#import "ViewController.h"
#import "ObjcManager.h"
#import "GCDGroup.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    GCDGroup *testGroup = [[GCDGroup alloc]init];
    [testGroup testDispatchGroup];
    
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
//        NSLog(@"1");
//    });
//    
//    NSLog(@"2");

//    [self group];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)dispach
{
    dispatch_barrier_async([ObjcManager shareManager].concurrentRWQueue, ^{
        for (int i = 0; i<1000; i++) {
            [[ObjcManager shareManager] writers:[NSString stringWithFormat:@"%d", i]];
        }
    });
    
    dispatch_async([ObjcManager shareManager].concurrentRWQueue, ^{
        [[ObjcManager shareManager] readers];
    });
    
//    NSLog(@"actually arr:\n%@", [ObjcManager shareManager].mArrary );
}

- (void)group
{
    dispatch_group_t group = dispatch_group_create();
    dispatch_queue_t queue = dispatch_queue_create("com.test.arthur", 0);
    
    // task1
    dispatch_group_async(group, queue, ^{
        for (int i = 0; i<100; i++) {
            NSLog(@"i = %d",i);
        }
    });
    
    // task2
    dispatch_group_async(group, queue, ^{
        for (int i = 1000; i<10000; i++) {
            NSLog(@"i = %d",i);
        }
    });
    
    // 当task1 和 task2 都结束时调用
    dispatch_group_notify(group, queue, ^{
        NSLog(@"任务结束！");
    });

}

@end

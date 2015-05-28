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
#import <libkern/OSAtomic.h>
#import "ASEThread.h"
#import "DispatchSource.h"
@interface ViewController ()

@property (strong, nonatomic) DispatchSource *dispatchSource;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

//    GCDGroup *testGroup = [[GCDGroup alloc]init];
//    [testGroup testDispatchGroup];

//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
//        NSLog(@"1");
//    });
//    
//    NSLog(@"2");

//    [self group];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSAssert(NSThread.isMainThread,
             @"Error: Method needs to be called on the main thread. %@",
             [NSThread callStackSymbols]);
    
//    [self testApply];
    [self testSource];
    
    
    /*
    dispatch_queue_t queue = dispatch_get_main_queue();
    
    // 3
    static dispatch_source_t source = nil;
    
    // 4
    __typeof(self) __weak weakSelf = self;
    
    // 5
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        // 6
        source = dispatch_source_create(DISPATCH_SOURCE_TYPE_SIGNAL, SIGSTOP, 0, queue);
        
        // 7
        if (source)
        {
            // 8
            dispatch_source_set_event_handler(source, ^{
                // 9
                NSLog(@"Hi, I am: %@", weakSelf);
            });
            dispatch_resume(source); // 10
        }
    });
     
     */
    
//    GCDTimer *gcdTimer = [[GCDTimer alloc]init];
//    [gcdTimer startTimer];

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


#pragma mark - Thread
- (void)testThread
{
//    NSArray
//    NSMutableSet *threads = [NSMutableSet set];
//    NSUInteger numberCount = self.nu
}


#pragma mark - Apply
- (void)testApply
{
    //用时 2.118s
    for (size_t y = 0; y < 100; ++y) {
        for (size_t x = 0; x < 100; ++x) {
            // Do something with x and y here
            NSLog(@"           x = %zu y = %zu",x,y);
        }
    }
    
    // 用时 1.593s ， 性能明显提升
    dispatch_apply(100, dispatch_get_global_queue(0, 0), ^(size_t y) {
        for (size_t x = 0; x < 100; x++) {
            NSLog(@"x = %zu y = %zu",x,y);
        }
    });
}


#pragma mark - 监视文件
- (void)testSource
{
    self.dispatchSource = [[DispatchSource alloc]init];
    [self.dispatchSource startTimer];
}




@end

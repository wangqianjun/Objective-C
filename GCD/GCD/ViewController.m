//
//  ViewController.m
//  GCD
//
//  Created by 王钱钧 on 15/1/21.
//  Copyright (c) 2015年 Arthur. All rights reserved.
//

#import "ViewController.h"
#import "ObjcManager.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        NSLog(@"1");
    });
    
    NSLog(@"2");//    [self dispach];

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

@end

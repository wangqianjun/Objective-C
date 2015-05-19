//
//  ViewController.m
//  ASETimeIntervalButton
//
//  Created by 王钱钧 on 15/5/12.
//  Copyright (c) 2015年 Arthur. All rights reserved.
//

#import "ViewController.h"
#import "ASETimeIntervalButton.h"


@interface ViewController ()
{
    NSTimer *m_pTimerObject;
}

@property (nonatomic, strong) dispatch_queue_t q;

@property (strong, nonatomic) NSTimer *timer;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    ASETimeIntervalButton *aseButton = [[ASETimeIntervalButton alloc]initWithFrame:CGRectMake(0, 100, 200, 50)];
    aseButton.backgroundColor = [UIColor redColor];
    
    [aseButton addTarget:self action:@selector(startTimer) forControlEvents:UIControlEventTouchDown];
    [aseButton addTarget:self action:@selector(pauseTimer) forControlEvents:UIControlEventTouchUpInside];
    [aseButton addTarget:self action:@selector(pauseTimer) forControlEvents:UIControlEventTouchUpOutside];
    [self.view addSubview:aseButton];
    
    
//    self.q = dispatch_get_global_queue(0,0);
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSTimer *)timer
{
    if (!_timer) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(send) userInfo:nil repeats:YES];
    }
    return _timer;
}

- (void)tap:(id)sender {
    
//    ASETimeIntervalButton *button = (ASETimeIntervalButton *)sender;
//    
//    [self pauseTimer];
//    
//    if (button.deltaInterval >= 0.5) {
//       
////        [self send];
//        NSLog(@"send");
//        
//    } else {
////        [self.timer setFireDate:[NSDate distantPast]]; //
//        [self resumeTimer];
//    }
    
}

- (void)send
{
    NSLog(@"send");
//    [self pauseTimer];
//    [self.timer setFireDate:[NSDate distantFuture]];
}


- (void)startTimer
{
    m_pTimerObject = [NSTimer scheduledTimerWithTimeInterval:0.3f target:self  selector:@selector(send) userInfo:nil repeats:YES];
}

- (void)fireTimer:(NSTimer *)inTimer
{
    // Timer is fired.
}

- (void)resumeTimer
{
    if(m_pTimerObject)
    {
        [m_pTimerObject invalidate];
        m_pTimerObject = nil;
    }
    m_pTimerObject = [NSTimer scheduledTimerWithTimeInterval:0.3f target:self  selector:@selector(send) userInfo:nil repeats:YES];
}

- (void)pauseTimer
{
    [m_pTimerObject invalidate];
    m_pTimerObject = nil;
}

@end

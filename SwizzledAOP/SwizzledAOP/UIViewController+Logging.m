//
//  UIViewController+Logging.m
//  SwizzledAOP
//
//  Created by 王钱钧 on 15/9/11.
//  Copyright (c) 2015年 王钱钧. All rights reserved.
//

#import "UIViewController+Logging.h"
#import "Aspects.h"

static  NSTimeInterval _begain;
static  NSTimeInterval _end;
static  NSTimeInterval _time;

@implementation UIViewController (Logging)

+ (void)loadViewLogging
{
    [UIViewController aspect_hookSelector:@selector(loadView) withOptions:AspectPositionBefore usingBlock:^(id<AspectInfo>aspectInfo, BOOL animated){
        NSLog(@"View Controller %@ will appear animated: %tu", [aspectInfo.instance class], animated);
        NSLog(@"arguments:%@",[aspectInfo arguments]);
        NSLog(@"originalInvocation:%@",[aspectInfo originalInvocation]);
    } error:NULL];

}

+ (void)viewDidloadLogging
{
    [UIViewController aspect_hookSelector:@selector(viewDidLoad) withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo>aspectInfo, BOOL animated){
        NSLog(@"View Controller %@ will appear animated: %tu", [aspectInfo.instance class], animated);
        NSLog(@"arguments:%@",[aspectInfo arguments]);
        NSLog(@"originalInvocation:%@",[aspectInfo originalInvocation]);
    } error:NULL];
}


+ (void)viewDidAppearLogging
{
    [[self class] aspect_hookSelector:@selector(viewDidAppear:) withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo>aspectInfo, BOOL animated){
        _end = CACurrentMediaTime();
        
        NSLog(@"_end = %f",_end);
        
        
        _time = _end - _begain;
        
        NSLog(@"_time = %f",_time);

        
        NSLog(@"View Controller %@ did appear animated: %tu", [aspectInfo.instance class], animated);
        NSLog(@"arguments:%@",[aspectInfo arguments]);
        NSLog(@"originalInvocation:%@",[aspectInfo originalInvocation]);
    } error:NULL];
}
@end

//
//  ViewController.m
//  NSRegularExpression
//
//  Created by 王钱钧 on 15/1/8.
//  Copyright (c) 2015年 Arthur. All rights reserved.
//


/*
 从iOS 4开始，原生SDK提供了NSRegularExpression用于处理一些跟正则表达式相关的操作，比如字符查找、数字匹配等等。但是NSRegularExpression的用法比较繁冗。RegEx Categories提供了一系列十分简便的方法来进行正则表达式操作。
 
 比如：
 
 用NSRegularExpression来判断字符串中是否存在数字：
 
 NSString* string = @"I have 2 dogs.";
 
 NSRegularExpression *regex = [NSRegularExpression regular ExpressionWithPattern:@"\\d+" options:NSRegularExpressionCaseInsensitive error:&error;];
 
 NSTextCheckingResult *match = [regex firstMatchInString:string options:0 range:NSMakeRange(0, [string length])];
 
 BOOL isMatch = match != nil;
 
 
 
 利用RegEx Categories只需要一句代码：
 
 BOOL isMatch = [@"I have 2 dogs." isMatch:RX(@"\\d+")];
 */
#import "ViewController.h"
#import "RegExCategories.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self useRegularExpreesion];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)useRegularExpreesion {
    NSString *staString = [NSString stringWithUTF8String:"[self.label setText: @\"hello world\"];"];
    NSString *pattern = @"(\\s)*(\\[)(\\s)*(self)(\\s)*(.)(\\s)*(label)(\\s)*(setText)(\\s)*(:)(\\s)*(@)(\\s)*(\".*\")(\\s)*(\\])(\\s)*(;)(\\s)*";
    NSError *error = nil;
    NSRegularExpression *rx = [NSRegularExpression regularExpressionWithPattern:pattern options:0 error:&error];
    
    NSArray *match = [rx matchesInString:staString options:NSMatchingReportCompletion range:NSMakeRange(0, [staString length])];
    
    if (match.count != 0)
    {    
        for (NSTextCheckingResult *matc in match)
        {
            NSRange range = [matc range];
            NSLog(@"%lu,%lu,%@",(unsigned long)range.location,(unsigned long)range.length,[staString substringWithRange:range]);
        }  
    }
}

- (void)useRegExCategories {
    Rx *rx = RX(@"\\d");
    Rx *rx1 = [Rx rx:@"\\d"];
    Rx *rx2 = [Rx rx:@"\\d" ignoreCase:YES];
}

@end

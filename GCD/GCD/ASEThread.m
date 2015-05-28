//
//  ASEThread.m
//  GCD
//
//  Created by 王钱钧 on 15/5/19.
//  Copyright (c) 2015年 Arthur. All rights reserved.
//

#import "ASEThread.h"

@implementation ASEThread {
    NSArray *_numbers;
}

- (instancetype)initWithNumbers:(NSArray *)numbers
{
    self = [super init];
    if (self) {
        _numbers = numbers;
    }
    
    return self;
}

- (void)main
{
    NSUInteger min;
    NSUInteger max;
    self.min = min;
    self.max = max;
}

@end

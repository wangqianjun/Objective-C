//
//  ASEThread.h
//  GCD
//
//  Created by 王钱钧 on 15/5/19.
//  Copyright (c) 2015年 Arthur. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ASEThread : NSThread

@property (nonatomic) NSUInteger min;
@property (nonatomic) NSUInteger max;

- (instancetype)initWithNumbers:(NSArray *)numbers;

@end

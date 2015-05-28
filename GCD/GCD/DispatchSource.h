//
//  DispatchSource.h
//  GCD
//
//  Created by 王钱钧 on 15/5/26.
//  Copyright (c) 2015年 Arthur. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DispatchSource : NSObject

#pragma mark - dispatch timer
- (void)startTimer;
- (void)cancelTimer;

#pragma mark - dispatch file read and write


@end

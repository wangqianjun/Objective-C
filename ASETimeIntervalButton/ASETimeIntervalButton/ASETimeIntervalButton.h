//
//  ASETimeIntervalButton.h
//  ASETimeIntervalButton
//
//  Created by 王钱钧 on 15/5/12.
//  Copyright (c) 2015年 Arthur. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ASETimeIntervalButton : UIButton

@property (assign, nonatomic) NSTimeInterval deltaInterval;

@end

@interface Canceller : NSObject
{
    BOOL _shouldCancel;
}

- (void)setShouldCancel:(BOOL)shouldCancel;
- (BOOL)shouldCancel;

@end
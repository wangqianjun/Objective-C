//
//  ASETimeIntervalButton.m
//  ASETimeIntervalButton
//
//  Created by 王钱钧 on 15/5/12.
//  Copyright (c) 2015年 Arthur. All rights reserved.
//

#import "ASETimeIntervalButton.h"

@interface ASETimeIntervalButton ()

@property (assign, nonatomic) NSTimeInterval lastBeganTouch;
@property (assign, nonatomic) NSTimeInterval currentBeganTouch;

@end

@implementation ASETimeIntervalButton

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
    }
    
    return self;
}

#pragma mark touch event

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    self.currentBeganTouch = [event timestamp];
    
     self.deltaInterval = (self.lastBeganTouch == 0) ? 0 : (self.currentBeganTouch - self.lastBeganTouch);
    
//    NSLog(@" self.currentBeganTouch = %f", self.currentBeganTouch);
//    NSLog(@" self.lastBeganTouch = %f", self.lastBeganTouch);

    NSLog(@"deltaInterval = %f",self.deltaInterval);
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];
    NSTimeInterval touchBeginEndInterval = [event timestamp] - self.currentBeganTouch;
    
    self.lastBeganTouch = self.currentBeganTouch;
//    NSLog(@"touchBeginEndInterval = %f",touchBeginEndInterval);
}

@end




@implementation Canceller

- (void)setShouldCancel:(BOOL)shouldCancel
{
    _shouldCancel = shouldCancel;
}

- (BOOL)shouldCancel
{
    return  _shouldCancel;
}

@end

//
//  ASETextView.m
//  CoreText
//
//  Created by 王钱钧 on 15/1/13.
//  Copyright (c) 2015年 Arthur. All rights reserved.
//

//http://geeklu.com/2013/03/core-text/

#import "ASETextView.h"
#import <CoreText/CoreText.h>
#pragma mark - C Methods

void RunDelegateDeallocCallback(void *refCon) {
    
}

CGFloat RunDelegateGetAscentCallback(void *refCon) {
    NSString *imageName = (__bridge NSString *)refCon;
    return [UIImage imageNamed:imageName].size.height;
}

CGFloat RunDelegateGetDescentCallback(void *refCon) {
    return 0;
}

CGFloat RunDelegateGetWidthCallback(void *refCon){
    NSString *imageName = (__bridge NSString *)refCon;
    return [UIImage imageNamed:imageName].size.width;
}

#pragma mark - ASETextView

@implementation ASETextView

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //这四行代码只是简单测试drawRect中context的坐标系
    
}

@end

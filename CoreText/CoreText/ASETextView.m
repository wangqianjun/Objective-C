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
    CGContextSetRGBFillColor(context, 1, 0, 0, 1);
    CGContextFillRect(context, CGRectMake(0, 200, 200, 100));
    CGContextSetRGBFillColor(context, 0, 0, 1, 5);
    CGContextFillRect(context, CGRectMake(0, 200, 100, 200));
    
    //设置字形变换矩阵为CGAffineTransformIdentity，也就是说每一个字形都不做图形变换
    CGContextSetTextMatrix(context, CGAffineTransformIdentity);
    
    CGAffineTransform flipVertical = CGAffineTransformMake(1, 0, 0, -1, 0, self.bounds.size.height);
    //将当前context的坐标系进行flip
    CGContextConcatCTM(context, flipVertical);
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:@"测试文本显示"];
    
    //为所有文本设置字体
    UIFont *font = [UIFont systemFontOfSize:24.0f];
    CTFontRef fontRef = CTFontCreateWithName((__bridge CFStringRef)font.fontName, font.pointSize, NULL);
    [attributedString addAttribute:(__bridge NSString *)kCTFontAttributeName value:(__bridge id)(fontRef) range:NSMakeRange(0, [attributedString length])];
    
    // 设置‘测试’为蓝色
    [attributedString addAttribute:(__bridge NSString *)kCTForegroundColorAttributeName value:(__bridge id)([UIColor blueColor].CGColor) range:NSMakeRange(0, 2)];
    
    //为图片设置CTRunDelegate,delegate决定留给图片的空间大小
    NSString *imageName = @"[击掌].png";
    CTRunDelegateCallbacks imageCallbacks;
    imageCallbacks.version = kCTRunDelegateVersion1;
    imageCallbacks.dealloc = RunDelegateDeallocCallback;
    imageCallbacks.getAscent = RunDelegateGetAscentCallback;
    imageCallbacks.getDescent = RunDelegateGetDescentCallback;
    imageCallbacks.getWidth = RunDelegateGetWidthCallback;
    
    CTRunDelegateRef runDelegate = CTRunDelegateCreate(&imageCallbacks, (__bridge void *)(imageName));
    NSMutableAttributedString *imageAttributedString = [[NSMutableAttributedString alloc]initWithString:@" "];//空格用于给图片留位置
    [imageAttributedString addAttribute:(__bridge NSString *)kCTRunDelegateAttributeName value:(__bridge id)runDelegate range:NSMakeRange(0, 1)];
    CFRelease(runDelegate);
    
    [imageAttributedString addAttribute:@"imageName" value:imageName range:NSMakeRange(0, 1)];
    
    [attributedString insertAttributedString:imageAttributedString atIndex:1];
    
    // 设置CTFrameSetter
    CTFramesetterRef ctFramesetter = CTFramesetterCreateWithAttributedString((__bridge CFMutableAttributedStringRef)attributedString);
    
    // 设置CGPath
    CGMutablePathRef path = CGPathCreateMutable();
    CGRect bounds = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
    CGPathAddRect(path, NULL, bounds);
    CTFrameRef ctFrame = CTFramesetterCreateFrame(ctFramesetter, CFRangeMake(0, 0), path, NULL);
    
    // 画
    CTFrameDraw(ctFrame, context);
    
    CFArrayRef lines = CTFrameGetLines(ctFrame);
    CGPoint lineOrigins[CFArrayGetCount(lines)];
    CTFrameGetLineOrigins(ctFrame, CFRangeMake(0, 0), lineOrigins);
    
    for (int i = 0; i < CFArrayGetCount(lines); i++) {
        // 获取 line
        CTLineRef line = CFArrayGetValueAtIndex(lines, i);
        CGFloat lineAscent;
        CGFloat lineDescent;
        CGFloat lineLeading;
        CTLineGetTypographicBounds(line, &lineAscent, &lineDescent, &lineLeading);
        
        // 获取 runs
        CFArrayRef runs = CTLineGetGlyphRuns(line);
        for (int j = 0; j < CFArrayGetCount(runs); j++) {
            CGFloat runAscent;
            CGFloat runDescent;
            CGPoint lineOrigin = lineOrigins[i];
            CTRunRef run = CFArrayGetValueAtIndex(runs, j);
            NSDictionary *attributes = (__bridge NSDictionary *)CTRunGetAttributes(run);
            
            CGRect runRect;
            runRect.size.width = CTRunGetTypographicBounds(run, CFRangeMake(0, 0), &runAscent, &runDescent, NULL);
            runRect = CGRectMake(lineOrigin.x + CTLineGetOffsetForStringIndex(line, CTRunGetStringRange(run).location, NULL), lineOrigin.y-runDescent, runRect.size.width, runAscent + runDescent);
            
            NSString *imageName = [attributes objectForKey:@"imageName"];
            
            // 图片渲染逻辑
            if (imageName) {
                UIImage *image = [UIImage imageNamed:imageName];
                if (image) {
                    CGRect imageDrawRect;
                    imageDrawRect.size = image.size;
                    imageDrawRect.origin.x = runRect.origin.x + lineOrigin.x;
                    imageDrawRect.origin.y = lineOrigin.y;
                    CGContextDrawImage(context, imageDrawRect, image.CGImage);
                }
            }
        }
    }
    
    CFRelease(fontRef);
    CFRelease(ctFrame);
    CFRelease(path);
    CFRelease(ctFramesetter);
}

@end

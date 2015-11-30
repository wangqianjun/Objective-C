//
//  ViewController.h
//  NSObjectRefCount
//
//  Created by 王钱钧 on 15/11/5.
//  Copyright © 2015年 王钱钧. All rights reserved.
//

#import <UIKit/UIKit.h>

extern void _objc_autoreleasePoolPrint();
extern int _objc_rootRetainCount(id obj);

@interface ViewController : UIViewController


@end


//
//  ViewController.h
//  OC_Predicate
//
//  Created by 王钱钧 on 15/2/28.
//  Copyright (c) 2015年 Arthur. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController


@end

@interface User : NSObject

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *age;

- (instancetype)initWithName:(NSString *)name age:(NSString *)age;

@end

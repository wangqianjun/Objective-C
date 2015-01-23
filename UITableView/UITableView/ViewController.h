//
//  ViewController.h
//  UITableView
//
//  Created by 王钱钧 on 15/1/21.
//  Copyright (c) 2015年 Arthur. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController


@end

@interface User : NSObject

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *uid;

- (instancetype)initWithName:(NSString *)name uid:(NSString *)uid;
@end


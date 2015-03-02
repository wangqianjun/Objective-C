//
//  ViewController.m
//  OC_Predicate
//
//  Created by 王钱钧 on 15/2/28.
//  Copyright (c) 2015年 Arthur. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    User *u1 = [[User alloc]initWithName:@"name1" age:@"1"];
    User *u2 = [[User alloc]initWithName:@"aaaname2" age:@"2"];
    User *u3 = [[User alloc]initWithName:@"name" age:@"2"];
    User *u4 = [[User alloc]initWithName:@"dsfdsname" age:@"2"];
    User *u5 = [[User alloc]initWithName:@"name" age:@"2"];
    
    NSMutableArray *users = [[NSMutableArray alloc] init];
    [users addObject:u1];
    [users addObject:u2];
    [users addObject:u3];
    [users addObject:u4];
    [users addObject:u5];
    NSString *key = @"name";
    
//    NSArray *filterArr = [users filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(User *evaluatedObject, NSDictionary *bindings) {
////        return [evaluatedObject.name hasPrefix:@"name1"];
//        NSLog(@"bindings = %@",bindings);
//        return [evaluatedObject.name containsString:@"name"];
//    }]];
    
//    NSLog(@"filter = %@", filterArr);
    
    [users sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        User * usr1 = (User *)obj1;
         User *  usr2 = (User *)obj2;
        
        if ([usr1.name isEqualToString:key]) {
            return NO;
        } else {
            if ([usr2.name isEqualToString:key]) {
                return YES;
            } else {
                if ([usr1.name hasPrefix:key]) {
                    return NO;
                } else {
                    if ([usr2.name hasPrefix:key]) {
                        return YES;
                    }else {
                        if ([usr1.name containsString:key]) {
                            return NO;
                        } else {
                            if ([usr2.name containsString:key]) {
                                return YES;
                            }else {
                                return NO;
                            }
                        }
                    }
                }
            }
        }
        
    }];
    
    for (User *user in users) {
        NSLog(@"name = %@", user.name);
    }

    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end


@implementation User


- (instancetype)initWithName:(NSString *)name age:(NSString *)age
{
    
    self = [super init];
    if (self) {
        self.name = name;
        self.age = age;
    }
    
    return self;
}

@end

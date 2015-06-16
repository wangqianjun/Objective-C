//
//  Stack.h
//  OC-Template
//
//  Created by 王钱钧 on 15/6/16.
//  Copyright (c) 2015年 YOHO！. All rights reserved.
//

#import <Foundation/Foundation.h>

// 泛型
@interface Stack<ObjectType> : NSObject

- (void)pushObject:(ObjectType)object;
- (ObjectType)popObject;
@property (nonatomic, readonly) NSArray<ObjectType> *allObjects;

@end


//@interface Stack<ObjectType:NSNumber*> : NSObject
//
//
//
//@end
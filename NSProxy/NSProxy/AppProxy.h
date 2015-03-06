//
//  MyProxy.h
//  NSProxy
//
//  Created by 王钱钧 on 15/3/5.
//  Copyright (c) 2015年 Arthur. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppProxy : NSProxy

+ (instancetype)sharedProxy;

- (void)registerHandlerProtocol:(Protocol *)protocol handler:(id)handler;

@end

//
//  FakeMessage.h
//  RuntimeMessage
//
//  Created by 王钱钧 on 16/3/23.
//  Copyright © 2016年 ASE. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FakeMessage : NSObject

- (void)sendMessage:(NSString *)message;

- (void)sendFakeMessage:(NSString *)fakeMsg;

@end

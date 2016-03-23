//
//  FakeMessage.m
//  RuntimeMessage
//
//  Created by 王钱钧 on 16/3/23.
//  Copyright © 2016年 ASE. All rights reserved.
//

#import "FakeMessage.h"

@implementation FakeMessage

- (void)sendMessage:(NSString *)message
{
    NSLog(@"%s", __func__);

    NSLog(@"This is a message: %@", message);

}

- (void)sendFakeMessage:(NSString *)fakeMsg
{
    NSLog(@"%s", __func__);

    NSLog(@"This is fake message: %@", fakeMsg);
}

@end

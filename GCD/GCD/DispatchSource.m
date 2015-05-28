//
//  DispatchSource.m
//  GCD
//
//  Created by 王钱钧 on 15/5/26.
//  Copyright (c) 2015年 Arthur. All rights reserved.
//

#import "DispatchSource.h"

#pragma mark - C methods
dispatch_source_t CreateDispatchTimer(uint64_t interval,
                                      uint64_t leeway,
                                      dispatch_queue_t queue,
                                      dispatch_block_t block)

{
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    if (timer) {
        dispatch_source_set_timer(timer, dispatch_walltime(NULL, 0), interval, leeway);
        dispatch_source_set_event_handler(timer, block);
        dispatch_resume(timer);
    }
    
    return timer;
}

#pragma mark - dispatch file read and write

bool MyProcessFileData(char *buffer, ssize_t actual)
{
    return YES;
}

dispatch_source_t ProcessContentsOfFile(const char *filename)
{
    //prepare the file for reading
    int fd = open(filename, O_RDONLY);
    if (fd == -1) {
        return NULL;
    }
    
    fcntl(fd, F_SETFL, O_NONBLOCK);
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t readSource = dispatch_source_create(DISPATCH_SOURCE_TYPE_READ, fd, 0, queue);
    
    if (!readSource) {
        close(fd);
        return NULL;
    }
    
    // Install the event handler
    dispatch_source_set_event_handler(readSource, ^{
        size_t estimated = dispatch_source_get_data(readSource) + 1;
        
        //read the data into a text buffer
        char *buffer = (char *)malloc(estimated);
        if (buffer) {
            ssize_t actual = read(fd, buffer, (estimated));
            Boolean done = MyProcessFileData(buffer, actual);
            
            free(buffer);
            
            if (done) {
                dispatch_source_cancel(readSource);
            }
        }
    });
    
    
    dispatch_source_set_cancel_handler(readSource, ^{
        //start reading the file
        close(fd);
    });
    
    dispatch_resume(readSource);
    return readSource;
}

@implementation DispatchSource
{
    dispatch_source_t _timer;
}


#pragma mark - dispatch timer
- (void)startTimer
{
    /*
     简单来说，dispatch source是一个监视某些类型事件的对象,当这些事件发生时，它自动将一个block放入一个dispatch queue的执行例程中
     */
    
    //注意，because in ARC, when it falls out of scope, it is released。
    _timer = CreateDispatchTimer(10 * NSEC_PER_SEC,
                                 1ull * NSEC_PER_SEC / 10,
                                 dispatch_get_main_queue(),
                                 ^{ MyPeriodicTask(); });}

- (void)cancelTimer
{
    if (_timer) {
        dispatch_source_cancel(_timer);
        // Remove this if you are on a Deployment Target of iOS6 or OSX 10.8 and above
        _timer = nil;
    }
}


void MyPeriodicTask()
{
    NSLog(@"periodic task");
}


#pragma mark - 监视文件

dispatch_source_t MonitorNameChangesToFile(const char* filename)
{
    int fd = open(filename, O_EVTONLY);
    if (fd == -1)
        return NULL;
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t source = dispatch_source_create(DISPATCH_SOURCE_TYPE_VNODE,
                                                      fd, DISPATCH_VNODE_RENAME, queue);
    if (source)
    {
        // Copy the filename for later use.
        size_t length = strlen(filename);
        char* newString = (char*)malloc(length + 1);
        newString = strcpy(newString, filename);
        dispatch_set_context(source, newString);
        
        // Install the event handler to process the name change
        dispatch_source_set_event_handler(source, ^{
            const char*  oldFilename = (char*)dispatch_get_context(source);
            MyUpdateFileName(oldFilename, fd);
        });
        
        // Install a cancellation handler to free the descriptor
        // and the stored string.
        dispatch_source_set_cancel_handler(source, ^{
            char* fileStr = (char*)dispatch_get_context(source);
            free(fileStr);
            close(fd);
        });
        
        // Start processing events.
        dispatch_resume(source);
    }
    else
        close(fd);
    
    return source;
}

void MyUpdateFileName(const char *oldFilename, int fd)
{
    
}

@end

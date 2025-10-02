//
//  WBReceiveRedEnvelopOperation.m
//  WeChatRedEnvelop
//
//  Created by wordbeyondyoung on 17/2/22.
//  Copyright © 2017年 swiftyper. All rights reserved.
//

#import "WBReceiveRedEnvelopOperation.h"
#import "WeChatRedEnvelopParam.h"
#import "WBRedEnvelopConfig.h"
#import "WeChatRedEnvelop.h"
#import <objc/objc-runtime.h>

@interface WBReceiveRedEnvelopOperation ()

@property (assign, nonatomic, getter=isExecuting) BOOL executing;
@property (assign, nonatomic, getter=isFinished) BOOL finished;

@property (strong, nonatomic) WeChatRedEnvelopParam *redEnvelopParam;
@property (assign, nonatomic) unsigned int delaySeconds;

@end

@implementation WBReceiveRedEnvelopOperation

@synthesize executing = _executing;
@synthesize finished = _finished;

- (instancetype)initWithRedEnvelopParam:(WeChatRedEnvelopParam *)param delay:(unsigned int)delaySeconds {
    if (self = [super init]) {
        _redEnvelopParam = param;
        _delaySeconds = delaySeconds;
    }
    return self;
}

- (void)start {
    if (self.isCancelled) {
        self.finished = YES;
        self.executing = NO;
        return;
    }
    
    [self main];
    
    self.executing = YES;
    self.finished = NO;
}

// 在WBReceiveRedEnvelopOperation.m中
- (void)start {
    if (self.isCancelled) {
        self.finished = YES;
        return;
    }
    [self willChangeValueForKey:@"isExecuting"];
    _executing = YES;
    [self didChangeValueForKey:@"isExecuting"];
    
    [self performSelectorInBackground:@selector(main) withObject:nil];
}

- (void)main {
    @autoreleasepool {
        sleep(self.delaySeconds);
        // 执行抢红包逻辑...
        
        [self willChangeValueForKey:@"isExecuting"];
        _executing = NO;
        [self didChangeValueForKey:@"isExecuting"];
        
        [self willChangeValueForKey:@"isFinished"];
        _finished = YES;
        [self didChangeValueForKey:@"isFinished"];
    }
}// 在WBReceiveRedEnvelopOperation.m中
- (void)start {
    if (self.isCancelled) {
        self.finished = YES;
        return;
    }
    [self willChangeValueForKey:@"isExecuting"];
    _executing = YES;
    [self didChangeValueForKey:@"isExecuting"];
    
    [self performSelectorInBackground:@selector(main) withObject:nil];
}

- (void)main {
    @autoreleasepool {
        sleep(self.delaySeconds);
        // 执行抢红包逻辑...
        
        [self willChangeValueForKey:@"isExecuting"];
        _executing = NO;
        [self didChangeValueForKey:@"isExecuting"];
        
        [self willChangeValueForKey:@"isFinished"];
        _finished = YES;
        [self didChangeValueForKey:@"isFinished"];
    }
}

- (void)cancel {
    self.finished = YES;
    self.executing = NO;
}

- (void)setFinished:(BOOL)finished {
    [self willChangeValueForKey:@"isFinished"];
    _finished = finished;
    [self didChangeValueForKey:@"isFinished"];
}

- (void)setExecuting:(BOOL)executing {
    [self willChangeValueForKey:@"isExecuting"];
    _executing = executing;
    [self didChangeValueForKey:@"isExecuting"];
}

- (BOOL)isAsynchronous {
    return YES;
}

@end

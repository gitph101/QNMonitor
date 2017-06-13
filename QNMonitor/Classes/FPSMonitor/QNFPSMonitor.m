//
//  QNFPSMonitor.m
//  Pods
//
//  Created by 研究院01 on 17/5/26.
//
//

#import "QNFPSMonitor.h"
#import "QNWeakProxy.h"

@interface QNFPSMonitor()

@property(nonatomic, strong) CADisplayLink *link;
@property(nonatomic, assign)NSTimeInterval lastTime;
@property(nonatomic, assign)NSUInteger count;
@property(nonatomic, assign, readwrite)float fps;

@end

@implementation QNFPSMonitor

+ (instancetype)sharedMonitor
{
    static QNFPSMonitor * sharedMonitor;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        sharedMonitor = [[self alloc]init];
    });
    return sharedMonitor;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.link = [CADisplayLink displayLinkWithTarget:[QNWeakProxy proxyWithTarget:self] selector:@selector(displayLinkTick:)];
        self.link.frameInterval = 1;
        [self.link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    }
    return self;
}

- (void)stopMonitoring
{
    [self.link invalidate];
    self.link = nil;
}

- (void)displayLinkTick:(CADisplayLink *)link
{
    if (_lastTime == 0) {
        _lastTime = link.timestamp;
        return;
    }
    _count++;
    NSTimeInterval delta = link.timestamp - _lastTime;
    if (delta < 1) return;
    _lastTime = link.timestamp;
    
    self.fps = _count / delta;
    
    _count = 0;
    
    if ([self.delegate respondsToSelector:@selector(updateFPS:fps:)]) {
        [self.delegate updateFPS:self fps:self.fps];
    }
}

- (void)dealloc
{
    [self.link invalidate];
}

@end

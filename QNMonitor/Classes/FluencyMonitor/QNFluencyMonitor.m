//
//  QNFluencyMonitor.m
//  Pods
//
//  Created by 研究院01 on 17/5/26.
//
//

#import "QNFluencyMonitor.h"
//#import "BSBacktraceLogger.h"

@interface QNFluencyMonitor()

@property(nonatomic, strong)dispatch_semaphore_t semaphore;
@property(nonatomic, assign)CFRunLoopActivity activity;
@property(nonatomic, assign)NSInteger countTime;
@property(nonatomic, assign)CFRunLoopObserverRef observer;

@end

@implementation QNFluencyMonitor

+ (instancetype)sharedInstance
{
    static dispatch_once_t once;
    static id sharedInstance;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;

}

+ (void) startMonitor
{
    [[self sharedInstance] addRunLoopObserver];
}


+ (void) endMonitor
{
    [[self sharedInstance] endMonitor];

}

-(void)endMonitor
{
    if (!_observer) {
        return;
    }
    CFRunLoopRemoveObserver(CFRunLoopGetMain(), _observer, kCFRunLoopCommonModes);
    CFRelease(_observer);
    _observer = NULL;
}

static void runLoopObserverCallBack(CFRunLoopObserverRef observer, CFRunLoopActivity activity, void *info)
{
    QNFluencyMonitor *instrance = [QNFluencyMonitor sharedInstance];
    instrance->_activity = activity;
    dispatch_semaphore_t semaphore = instrance->_semaphore;
    dispatch_semaphore_signal(semaphore);

}

- (void)addRunLoopObserver
{
    CFRunLoopObserverContext context = {0,(__bridge void*)self,NULL,NULL};
    CFRunLoopObserverRef observer = CFRunLoopObserverCreate(kCFAllocatorDefault,
                                                            kCFRunLoopAllActivities,
                                                            YES,
                                                            0,
                                                            &runLoopObserverCallBack,
                                                            &context);
    CFRunLoopAddObserver(CFRunLoopGetMain(), observer, kCFRunLoopCommonModes);
    
    _semaphore = dispatch_semaphore_create(0);
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        while (YES) {
            long st = dispatch_semaphore_wait(_semaphore, dispatch_time(DISPATCH_TIME_NOW, 50*NSEC_PER_MSEC));
            if (st != 0) {
                if (_activity==kCFRunLoopBeforeSources || _activity==kCFRunLoopAfterWaiting){
                    if (++_countTime < 5)
                        continue;
                    [self logStack];
                    NSLog(@"something lag");
                }
            }
        }
    });

}


- (void)logStack
{
//    NSString *statck = [BSBacktraceLogger bs_backtraceOfMainThread];
//    NSLog(@"堆栈信息：%@",statck);
}
@end

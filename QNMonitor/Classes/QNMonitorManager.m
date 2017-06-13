//
//  QNMonitorManager.m
//  Pods
//
//  Created by 研究院01 on 17/5/27.
//
//

#import "QNMonitorManager.h"
#import "UIDevice+QNTools.h"
#import "QNFPSMonitor.h"
#import "QNTopWindow.h"
#import "QNMonitorDisplayer.h"

#define MEMOVALUE (1024 * 1024.0)

@interface QNMonitorManager ()<QNFPSMonitorDelegate>

@property (nonatomic, assign, readwrite) float cpu;
@property (nonatomic, assign, readwrite) float memory;
@property (nonatomic, assign, readwrite) float fps;

@property(nonatomic, strong) QNMonitorDisplayer *monitorView;

@end

@implementation QNMonitorManager

+(instancetype)shareManager
{
    static QNMonitorManager *shareManager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareManager = [[self alloc]init];
    });
    return shareManager;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.monitorView = [[QNMonitorDisplayer alloc]init];
        self.monitorView.bounds = CGRectMake(0, 0, 200, 30);
        self.monitorView.center = CGPointMake(120, 60);
        [[QNTopWindow topWindow]addSubview:self.monitorView];
        [QNFPSMonitor sharedMonitor].delegate = self;
    }
    return self;
}

- (void)startMonitoring
{
        
    self.cpu = [[UIDevice currentDevice] cpuUsage];
    self.memory = [[UIDevice currentDevice] memoryUsed]/1000/1000;
    self.fps = [QNFPSMonitor sharedMonitor].fps;
    [self.monitorView showValueFPS:self.fps cpu:self.cpu memory:self.memory];
    
}

- (void)stopMonitoring
{
    [[QNFPSMonitor sharedMonitor] stopMonitoring];
    [self.monitorView removeFromSuperview];
    self.monitorView = nil;
}

//QNFPSMonitorDelegate
-(void)updateFPS:(QNFPSMonitor *)monitor fps:(NSInteger)fps
{
    self.cpu = [[UIDevice currentDevice] cpuUsage];
    self.memory = [[UIDevice currentDevice] usedMemory]/MEMOVALUE;
    self.fps = [QNFPSMonitor sharedMonitor].fps;
    [self.monitorView showValueFPS:self.fps cpu:self.cpu memory:self.memory];
}


@end

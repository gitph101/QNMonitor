//
//  QNMonitorManager.h
//  Pods
//
//  Created by 研究院01 on 17/5/27.
//
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, LXDResourceMonitorType)
{
    QNMonitorTypeDefault = (1 << 2) | (1 << 3),
    QNMonitorTypeSystemCpu = 1 << 0,   ///<    监控系统CPU使用率，优先级低
    QNMonitorTypeSystemMemory = 1 << 1,    ///<    监控系统内存使用率，优先级低
    QNMonitorTypeSystemFPS = 1 << 2,    ///<    监控系统内存使用率，优先级低
};

@interface QNMonitorManager : NSObject

- (void)startMonitoring;
+(instancetype)shareManager;

@property (nonatomic, assign, readonly) float  cpu;
@property (nonatomic, assign, readonly) float  memory;
@property (nonatomic, assign, readonly) float fps;

@end

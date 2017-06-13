//
//  QNMonitorManager.h
//  Pods
//
//  Created by 研究院01 on 17/5/27.
//
//

#import <Foundation/Foundation.h>

@interface QNMonitorManager : NSObject

+(instancetype)shareManager;
- (void)startMonitoring;

@property (nonatomic, assign, readonly) float cpu;
@property (nonatomic, assign, readonly) float memory;
@property (nonatomic, assign, readonly) float fps;

@end

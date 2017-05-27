//
//  QNFPSMonitor.h
//  Pods
//
//  Created by 研究院01 on 17/5/26.
//
//

#import <Foundation/Foundation.h>

@class QNFPSMonitor;

@protocol QNFPSMonitorDelegate <NSObject>

@optional

-(void)updateFPS:(QNFPSMonitor *)monitor fps:(NSInteger)fps;

@end


@interface QNFPSMonitor : NSObject

+ (instancetype)sharedMonitor;

@property(strong,nonatomic) id<QNFPSMonitorDelegate>delegate;

@property(nonatomic, assign, readonly)float fps;

- (void)stopMonitoring;

@end

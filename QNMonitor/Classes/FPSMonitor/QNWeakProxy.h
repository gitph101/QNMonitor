//
//  QNWeakProxy.h
//  Pods
//
//  Created by 研究院01 on 17/5/26.
//
//

#import <Foundation/Foundation.h>

@interface QNWeakProxy : NSProxy

@property (nonatomic, weak, readonly) id target;

- (instancetype)initWithTarget:(id)target;

+ (instancetype)proxyWithTarget:(id)target;

@end

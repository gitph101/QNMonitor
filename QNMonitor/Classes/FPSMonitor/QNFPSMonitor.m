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

+ (instancetype)sharedMonitor {
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
        _link = [CADisplayLink displayLinkWithTarget:[QNWeakProxy proxyWithTarget:self] selector:@selector(displayLinkTick:)];
        _link.frameInterval = 1;
        [_link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    }
    return self;
}

- (void)dealloc {
    [_link invalidate];
}


/*
#pragma mark - Public
- (void)startMonitoring {

}
*/
- (void)stopMonitoring {
    [_link invalidate];
    _link = nil;
}



- (void)displayLinkTick:(CADisplayLink *)link {
    
    
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
    
    CGFloat progress = self.fps / 60.0;
    
    if ([self.delegate respondsToSelector:@selector(updateFPS:fps:)]) {
        [self.delegate updateFPS:self fps:self.fps];
    }
    
    /*
    UIColor *color = [UIColor colorWithHue:0.27 * (progress - 0.2) saturation:1 brightness:0.9 alpha:1];
    
    NSString *text1 = [NSString stringWithFormat:@"%d FPS",(int)round(fps)];
    NSLog(@"%@", text1);
    
    
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%d FPS",(int)round(fps)]];
    [text addAttribute:NSForegroundColorAttributeName value:color range:NSMakeRange(0, text.length - 3)];
    [text addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(text.length - 3, 3)];
    [text addAttribute:NSFontAttributeName value:_font range:NSMakeRange(0, text.length)];
    [text addAttribute:NSFontAttributeName value:_subFont range:NSMakeRange(text.length - 4, 1)];
    self.attributedText = text; 
     */
}


@end

//
//  QNTopWindow.m
//  Pods
//
//  Created by 研究院01 on 17/5/27.
//
//

#import "QNTopWindow.h"

static QNTopWindow * top_window;

@implementation QNTopWindow

+ (instancetype)topWindow
{
#if DEBUG
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        top_window = [[super allocWithZone: NSDefaultMallocZone()] initWithFrame: [UIScreen mainScreen].bounds];
    });
#endif
    return top_window;
}


- (instancetype)copy {
    return [[self class] topWindow];
}

- (instancetype)initWithFrame: (CGRect)frame
{
    if (self = [super initWithFrame: frame]) {
        [super setUserInteractionEnabled: NO];
        [super setWindowLevel: CGFLOAT_MAX];
        
        self.rootViewController = [UIViewController new];
        [self makeKeyAndVisible];
    }
    return self;
}

- (void)setWindowLevel: (UIWindowLevel)windowLevel { }
- (void)setBackgroundColor: (UIColor *)backgroundColor { }
- (void)setUserInteractionEnabled: (BOOL)userInteractionEnabled { }


@end

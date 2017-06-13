//
//  QNFPSDisplayer.m
//  Pods
//
//  Created by 研究院01 on 17/5/26.
//
//

#import "QNFPSDisplayer.h"
#import "QNFPSMonitor.h"

#define QN_FPS_DISPLAYER_SIZE CGSizeMake(54, 20)


@interface QNFPSDisplayer()<QNFPSMonitorDelegate>

@property(nonatomic, strong) UILabel *fpsLabel;
@property(nonatomic, strong) UIFont *font;
@property(nonatomic, strong) UIFont *subFont;

@end

@implementation QNFPSDisplayer

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.backgroundColor = [UIColor redColor];
        self.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 80, 20, 60, 30);
        self.layer.cornerRadius = 5;
        self.clipsToBounds = YES;
        self.userInteractionEnabled = NO;
        self.font = [UIFont fontWithName:@"Menlo" size:14];
        self.subFont = [UIFont fontWithName:@"Menlo" size:14];
        if (self.font) {
            self.subFont = [UIFont fontWithName:@"Menlo" size:4];
        } else {
            self.font = [UIFont fontWithName:@"Courier" size:14];
            self.subFont = [UIFont fontWithName:@"Courier" size:4];
        }
        [self addSubview:self.fpsLabel];
        [QNFPSMonitor sharedMonitor].delegate = self;
        [self updateFPS:nil fps:60];
    }
    return self;
}

+(void)showView:(UIView *)presentView
{
    QNFPSDisplayer *disView = [[QNFPSDisplayer alloc]init];
    [presentView addSubview:disView];
}

-(void)updateFPS:(QNFPSMonitor *)monitor fps:(NSInteger)fps
{
    self.fpsLabel.attributedText = [self attributedStringFPS:fps];
}

-(NSMutableAttributedString *)attributedStringFPS:(NSInteger)fps
{
    
    UIColor *color = [UIColor colorWithHue:0.27 * (fps/100.0 - 0.2) saturation:1 brightness:0.9 alpha:1];
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%d FPS",(int)round(fps)]];
    [text addAttribute:NSForegroundColorAttributeName value:color range:NSMakeRange(0, text.length - 3)];
    [text addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(text.length - 3, 3)];
    [text addAttribute:NSFontAttributeName value:_font range:NSMakeRange(0, text.length)];
    [text addAttribute:NSFontAttributeName value:_subFont range:NSMakeRange(text.length - 4, 1)];
    return text;
}


#pragma - Get and Set


-(UILabel *)fpsLabel
{
    if (!_fpsLabel) {
        _fpsLabel = [[UILabel alloc]initWithFrame:self.bounds];
        _fpsLabel.textAlignment = NSTextAlignmentCenter;
        _fpsLabel.backgroundColor = [UIColor colorWithWhite:0.000 alpha:0.700];
    }
    return _fpsLabel;
}
@end

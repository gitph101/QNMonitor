//
//  QNMonitorDisplayer.m
//  Pods
//
//  Created by 研究院01 on 17/5/27.
//
//

#import "QNMonitorDisplayer.h"


@interface QNMonitorDisplayer()

@property(nonatomic, strong) UILabel *monitorLabel;
@property(nonatomic, strong) UIFont *font;
@property(nonatomic, strong) UILabel *subFont;

@end


@implementation QNMonitorDisplayer

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.backgroundColor = [UIColor redColor];
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
        [self addSubview:self.monitorLabel];
        
        _monitorLabel.frame =  self.bounds;

    }
    return self;
}



-(void)showValueFPS:(float)fps cpu:(float) cpu memory:(float)memory{
    
    self.monitorLabel.frame = self.bounds;

    NSMutableAttributedString *attributedStringFPS = [self attributedStringFPS:fps];
    NSMutableAttributedString *attributedStringCPU = [self attributedStringCPU:cpu];
    
    NSMutableAttributedString *attributedStringMemory = [self attributedStringMemory:memory];
    
    [attributedStringCPU appendAttributedString:attributedStringMemory];
    [attributedStringCPU appendAttributedString:attributedStringFPS];
    
    self.monitorLabel.attributedText = attributedStringCPU;
}



-(NSMutableAttributedString *)attributedStringFPS:(float)fps{
    
    UIColor *color = [UIColor colorWithHue:0.27 * (fps/100.0 - 0.2) saturation:1 brightness:0.9 alpha:1];
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%d FPS",(int)round(fps)]];
    [text addAttribute:NSForegroundColorAttributeName value:color range:NSMakeRange(0, text.length - 3)];
    [text addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(text.length - 3, 3)];
    [text addAttribute:NSFontAttributeName value:_font range:NSMakeRange(0, text.length)];
    [text addAttribute:NSFontAttributeName value:_subFont range:NSMakeRange(text.length - 4, 1)];
    return text;
}

-(NSMutableAttributedString *)attributedStringCPU:(float)cpu{
    
    UIColor *color = [UIColor colorWithHue:0.27 * (cpu/100.0 - 0.2) saturation:1 brightness:0.9 alpha:1];
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%.2f CPU",(float)cpu]];
    [text addAttribute:NSForegroundColorAttributeName value:color range:NSMakeRange(0, text.length - 3)];
    [text addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(text.length - 3, 3)];
    [text addAttribute:NSFontAttributeName value:_font range:NSMakeRange(0, text.length)];
    [text addAttribute:NSFontAttributeName value:_subFont range:NSMakeRange(text.length - 4, 1)];
    return text;
}

-(NSMutableAttributedString *)attributedStringMemory:(float)memory{
    
    UIColor *color = [UIColor colorWithHue:0.27 * (memory/100.0 - 0.2) saturation:1 brightness:0.9 alpha:1];
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%.2f MEM",(float)memory]];
    [text addAttribute:NSForegroundColorAttributeName value:color range:NSMakeRange(0, text.length - 3)];
    [text addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(text.length - 3, 3)];
    [text addAttribute:NSFontAttributeName value:_font range:NSMakeRange(0, text.length)];
    [text addAttribute:NSFontAttributeName value:_subFont range:NSMakeRange(text.length - 4, 1)];
    return text;
}



#pragma ger and set

-(UILabel *)monitorLabel{
    if (!_monitorLabel) {
        _monitorLabel = [[UILabel alloc]initWithFrame:self.bounds];
        _monitorLabel.textAlignment = NSTextAlignmentCenter;
        _monitorLabel.backgroundColor = [UIColor colorWithWhite:0.000 alpha:0.700];
        
    }
    return _monitorLabel;
}

@end

//
//  CDL_paoView.m
//  JingFM-RoundEffect
//
//  Created by ChenJs92 on 17/5/24.
//  Copyright © 2017年 isaced. All rights reserved.
//

#import "CDL_paoView.h"

#define FONT_SIZE 13.0f
#define HORIZONTAL_PADDING 7.0f
#define VERTICAL_PADDING 3.0f
#define LABEL_MARGIN 5.0f
#define BOTTOM_MARGIN 5.0f
#define BACKGROUND_COLOR [UIColor colorWithRed:0.083 green:0.624 blue:0.695 alpha:1.000]
#define BACKGROUND_COLOR1 [UIColor colorWithRed:0.070 green:0.366 blue:0.597 alpha:1.000]
#define TEXT_COLOR [UIColor colorWithWhite:1.000 alpha:1.000]
#define TEXT_SHADOW_COLOR [UIColor whiteColor]
#define TEXT_SHADOW_OFFSET CGSizeMake(0.0f, 0.0f)
#define BORDER_COLOR [UIColor lightGrayColor].CGColor
#define BORDER_WIDTH 0.0f
#define CORNER_RADIUS 10.0f

@interface CDL_paoView ()

@property (assign, nonatomic) BOOL gotPreviousFrame;
@property(nonatomic,assign)CGRect previousFrame;


@end

@implementation CDL_paoView


- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

-(void)setSourcesList:(NSArray<CDL_paoMessModel *> *)sourcesList{
    if (!sourcesList) {
        return;
    }
    _sourcesList = sourcesList;
    
    for (int i=0; i<sourcesList.count; i++) {
        CDL_paoMessModel *d = [sourcesList objectAtIndex:i];
        [self performSelector:@selector(insertLable:) withObject:d afterDelay:_speed*i];
    }
    
}

-(void)insertLable:(CDL_paoMessModel *)messModel
{
    
    float totalHeight = 0;
    
    if (_gotPreviousFrame != YES) {
        _previousFrame = CGRectZero;
    }
    //初始化 btn
    UIButton *btn = [[UIButton alloc]init];
    btn.userInteractionEnabled = YES;
    btn.titleLabel.font = [UIFont systemFontOfSize:FONT_SIZE];
    [btn setTitleColor:TEXT_COLOR forState:UIControlStateNormal];
    [btn setTitle:messModel.paoTitle forState:UIControlStateNormal];
    
    [btn.layer setMasksToBounds:YES];
    [btn.layer setCornerRadius:CORNER_RADIUS];
    [btn.layer setBorderColor:BORDER_COLOR];
    [btn.layer setBorderWidth: BORDER_WIDTH];
    
    //文字 Size
    CGSize textSize = [self backTextSizeWith:messModel.paoTitle];
    textSize.width += HORIZONTAL_PADDING*2;
    textSize.height += VERTICAL_PADDING*2;
    
    //lable frame
    if (!_gotPreviousFrame) {
        [btn setFrame:CGRectMake(10, 0, textSize.width, textSize.height)];
        totalHeight = textSize.height;
    } else {
        CGRect newRect = CGRectZero;
        if (_previousFrame.origin.x + _previousFrame.size.width + textSize.width + LABEL_MARGIN > self.frame.size.width) {
            newRect.origin = CGPointMake(10, _previousFrame.origin.y + textSize.height + BOTTOM_MARGIN);
            totalHeight += textSize.height + BOTTOM_MARGIN;
        } else {
            newRect.origin = CGPointMake(_previousFrame.origin.x + _previousFrame.size.width + LABEL_MARGIN, _previousFrame.origin.y);
        }
        newRect.size = textSize;
        [btn setFrame:newRect];
    }
    
    _previousFrame = btn.frame;
    _gotPreviousFrame = YES;
    
    //背景色
    if (messModel.paoType == 0) {
        [btn setBackgroundColor:BACKGROUND_COLOR1];
    }
    if (messModel.paoType != 0) {
        [btn setBackgroundColor:BACKGROUND_COLOR];
    }
    
    //事件
    [btn addTarget:self action:@selector(jsdlj:) forControlEvents:UIControlEventTouchUpInside];

    
    //背景动画、tag
    [btn.layer addAnimation:[self backAnimation] forKey:nil];
    btn.tag = messModel.paoSourceId;
    [self addSubview:btn];
    
}

-(CGSize)backTextSizeWith:(NSString *)str{
   
    return  [str sizeWithFont:[UIFont systemFontOfSize:FONT_SIZE] constrainedToSize:CGSizeMake(self.frame.size.width, 1500) lineBreakMode:NSLineBreakByWordWrapping];
}

//由小变大在变小动画
-(CAKeyframeAnimation *)backAnimation{
    CAKeyframeAnimation *popAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    popAnimation.duration = 0.4;
    popAnimation.values = @[[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.01f, 0.01f, 1.0f)],
                            [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.1f, 1.1f, 1.0f)],
                            [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9f, 0.9f, 1.0f)],
                            [NSValue valueWithCATransform3D:CATransform3DIdentity]];
    popAnimation.keyTimes = @[@0.2f, @0.5f, @0.75f, @1.0f];
    popAnimation.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                     [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                     [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    return popAnimation;
}


-(void)jsdlj:(UIButton *)sender{
    
    [self.delagate selectPaoViewWith:sender.tag];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

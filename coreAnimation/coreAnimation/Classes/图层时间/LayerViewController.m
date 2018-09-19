//
//  LayerViewController.m
//  coreAnimation
//
//  Created by chensx on 17/3/31.
//  Copyright © 2017年 coreAnimation. All rights reserved.
//

#import "LayerViewController.h"

@interface LayerViewController ()<CAAnimationDelegate>
@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet UITextField *durationField;
@property (weak, nonatomic) IBOutlet UITextField *repeatField;
@property (weak, nonatomic) IBOutlet UIButton *startButton;

@property (nonatomic, strong) CALayer *shipLayer;

@end

@implementation LayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //[self addIconImageLayer];
    
    [self autoDoor];
}

- (IBAction)clickButton:(id)sender {
    [self.durationField resignFirstResponder];
    [self.repeatField resignFirstResponder];
    
    [self start];
}

#pragma mark - 相对时间
/**
 
 beginTime指定了动画开始之前的的延迟时间。这里的延迟从动画添加到可见图层的那一刻开始测量，默认是0（就是说动画会立刻执行）。
 speed是一个时间的倍数，默认1.0，减少它会减慢图层/动画的时间，增加它会加快速度。如果2.0的速度，那么对于一个duration为1的动画，实际上在0.5秒的时候就已经完成了。
 timeOffset和beginTime类似，但是和增加beginTime导致的延迟动画不同，增加timeOffset只是让动画快进到某一点，例如，对于一个持续1秒的动画来说，设置timeOffset为0.5意味着动画将从一半的地方开始。+
 
 和beginTime不同的是，timeOffset并不受speed的影响。所以如果你把speed设为2.0，把timeOffset设置为0.5，那么你的动画将从动画最后结束的地方开始，因为1秒的动画实际上被缩短到了0.5秒。然而即使使用了timeOffset让动画从结束的地方开始，它仍然播放了一个完整的时长，这个动画仅仅是循环了一圈，然后从头开始播放。
 */

#pragma mark - 

/**
 创建重复动画的另一种方式是使用repeatDuration属性，它让动画重复一个指定的时间，而不是指定次数。
 autoreverses
 */
- (void)autoDoor {
    
    CALayer *doorLayer = [CALayer layer];
    doorLayer.frame = CGRectMake(0, 0, 128, 256);
    doorLayer.position = CGPointMake(150 - 64, 150);
    doorLayer.anchorPoint = CGPointMake(0.2, 0.5);
    doorLayer.contents = (__bridge id)[UIImage imageNamed: @"door.jpg"].CGImage;
    [self.containerView.layer addSublayer:doorLayer];
    
    //apply perspective transform
    CATransform3D perspective = CATransform3DIdentity;
    perspective.m34 = -1.0 / 500.0;
    self.containerView.layer.sublayerTransform = perspective;
    
    //apply swinging animation
    CABasicAnimation *animation = [CABasicAnimation animation];
    animation.keyPath = @"transform.rotation.y";
    animation.toValue = @(-M_PI_2);
    animation.duration = 2.0;
    animation.repeatDuration = INFINITY;//无穷大
    animation.autoreverses = YES;// 动画结束时执行逆动画
    [doorLayer addAnimation:animation forKey:nil];
    
}

#pragma mark - duration & repeatCount 关系

/**
 CAMediaTiming另外还有一个属性叫做repeatCount，代表动画重复的迭代次数。如果duration是2，repeatCount设为3.5（三个半迭代），那么完整的动画时长将是7秒。
 duration和repeatCount默认都是0。但这不意味着动画时长为0秒，或者0次，这里的0仅仅代表了“默认”，也就是0.25秒和1次
 */
- (void)start {
    CFTimeInterval duration = [self.durationField.text doubleValue];
    float repeatCount = [self.repeatField.text floatValue];
    CABasicAnimation *animation = [CABasicAnimation animation];
    animation.keyPath = @"transform.rotation";
    animation.duration = duration;
    animation.repeatCount = repeatCount;
    animation.byValue = @(M_PI * 2);
    animation.delegate = self;
    [self.shipLayer addAnimation:animation forKey:@"rotateAnimation"];
    
    [self setControlsEnabled:NO];
    
}

- (void)setControlsEnabled:(BOOL)enabled {
    for (UIControl *control in @[self.durationField, self.repeatField, self.startButton]) {
        control.enabled = enabled;
        control.alpha = enabled ? 1.0f :0.25f;
    }
}

- (void)addIconImageLayer {
    self.shipLayer = [CALayer layer];
    self.shipLayer.frame = CGRectMake(0, 0, 120, 120);
    self.shipLayer.position = CGPointMake(150, 150);
    self.shipLayer.contents = (__bridge id)[UIImage imageNamed:@"Icon-120.png"].CGImage;
    [self.containerView.layer addSublayer:self.shipLayer];
}

#pragma mark - CAAnimationDelegate
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    [self setControlsEnabled:YES];
}

@end

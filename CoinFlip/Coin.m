//
//  Coin.m
//  CoinFlip
//
//  Created by Matt Glover on 05/10/2012.
//  Copyright (c) 2012 Duchy Software Ltd. All rights reserved.
//

#import "Coin.h"

@interface Coin ()
@property (nonatomic, assign) CoinSize coinSize;

- (void)setup;
@end

@implementation Coin
@synthesize coinSize = _coinSize;

+ (Coin *)coinWithSize:(CoinSize)coinSize {
    
    Coin *coin = nil;
    
    switch (coinSize) {
        case CoinSizeSmall:
            coin = [[[Coin alloc] initWithFrame:CGRectMake(0, 0, 50, 50) coinSize:coinSize] autorelease];
            break;
            
        case CoinSizeMedium:
            coin = [[[Coin alloc] initWithFrame:CGRectMake(0, 0, 100, 100) coinSize:coinSize] autorelease];
            break;
            
        case CoinSizeLarge:
            coin = [[[Coin alloc] initWithFrame:CGRectMake(0, 0, 150, 150) coinSize:coinSize] autorelease];
            break;
            
        case CoinSizeExtraLarge:
            coin = [[[Coin alloc] initWithFrame:CGRectMake(0, 0, 200, 200) coinSize:coinSize] autorelease];
            break;
            
        default:
            break;
    }
    
    return coin;
}

- (id)initWithFrame:(CGRect)frame coinSize:(CoinSize)coinSize
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setCoinSize:coinSize];
        [self setup];
    }
    return self;
}

- (void)setup {
    
    CALayer *coinLayer = [CALayer layer];
    [coinLayer setBounds:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    [coinLayer setCornerRadius:self.frame.size.width/2];
    [coinLayer setBackgroundColor:[UIColor lightGrayColor].CGColor];
    [coinLayer setPosition:self.center];
    [coinLayer setBorderColor:[UIColor darkGrayColor].CGColor];
    [coinLayer setBorderWidth:2.0f];
    [coinLayer setDoubleSided:YES];
    [coinLayer setMasksToBounds:YES];
    [coinLayer setName:@"coin"];
    
    CAGradientLayer *gradientOverlay = [CAGradientLayer layer];
    [gradientOverlay setBounds:CGRectMake(0, 0, self.frame.size.width * 2, self.frame.size.height * 2)];
    [gradientOverlay setCornerRadius:self.frame.size.width];
    [gradientOverlay setPosition:CGPointMake(coinLayer.position.x, -coinLayer.position.y)];
    [gradientOverlay setColors:[NSArray arrayWithObjects: (id)[UIColor whiteColor].CGColor, (id)[UIColor clearColor].CGColor, nil]];
    
    CATextLayer *textLayer = [CATextLayer layer];
    [textLayer setBounds:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.width * .6)];
    [textLayer setString:@"I"];
    [textLayer setAlignmentMode:@"center"];
    [textLayer setFont:[UIFont boldSystemFontOfSize:18].fontName];
    [textLayer setFontSize:self.bounds.size.width * .70];
    [textLayer setPosition:coinLayer.position];
    [textLayer setForegroundColor:[UIColor whiteColor].CGColor];
    [textLayer setShadowColor:[UIColor blackColor].CGColor];
    [textLayer setShadowOffset:CGSizeMake(0.0f, -1.0f)];
    [textLayer setShadowOpacity:0.7];
    [textLayer setShadowRadius:1.0];
    
    [coinLayer addSublayer:textLayer];
    [coinLayer addSublayer:gradientOverlay];
    
    [self.layer addSublayer:coinLayer];
    
}

- (void)startAnimating {
    
    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    [animationGroup setAnimations:[NSArray arrayWithObjects: [self riseAndFallAnimation], [self coinFlipAnimation], [self fadeOutAnimation], nil]];
    [animationGroup setDuration:4.5];
    [[self.layer.sublayers objectAtIndex:0] addAnimation:animationGroup forKey:nil];
    
   // [(CALayer *)[self.layer.sublayers objectAtIndex:0] addAnimation:[self coinFlipAnimation] forKey:nil];
    
}

- (CAAnimation *)coinFlipAnimation {
   
    CAKeyframeAnimation* flipAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation.x"];
    
    flipAnimation.duration = 0.3;
    flipAnimation.repeatCount = 10;
    
    flipAnimation.values = [NSArray arrayWithObjects:
                            [NSNumber numberWithFloat:(0.0 / 180.0) * M_PI],
                            //  [NSNumber numberWithFloat:(90.0 / 180.0) * M_PI],
                            //  [NSNumber numberWithFloat:(180.0 / 180.0) * M_PI],
                            //  [NSNumber numberWithFloat:(270.0 / 180.0) * M_PI],
                            [NSNumber numberWithFloat:(359.0 / 180.0) * M_PI], nil];

    return flipAnimation;
}


- (CAAnimation *)riseAndFallAnimation {
    
    CAKeyframeAnimation *riseAndFallAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];

    [riseAndFallAnimation setValues:[NSArray arrayWithObjects:
                                     [NSValue valueWithCATransform3D:CATransform3DIdentity],
                                     [NSValue valueWithCATransform3D:CATransform3DMakeScale(2.0, 2.0, 1.0)],
                                     nil]];

    [riseAndFallAnimation setAutoreverses:YES];
    [riseAndFallAnimation setDuration:1.5];
    
    return riseAndFallAnimation;
}

- (CAAnimation *)fadeOutAnimation {
    
    CABasicAnimation *opacityAnim = [CABasicAnimation animationWithKeyPath:@"opacity"];
    [opacityAnim setFromValue:[NSNumber numberWithFloat:1.0]];
    [opacityAnim setToValue:[NSNumber numberWithFloat:0.8]];
    
    [opacityAnim setDuration:1.5];
    [opacityAnim setAutoreverses:YES];
    
    return opacityAnim;
}

- (void)stopAnimating {
    
}

- (void)flipCoinByAngle:(CGFloat)angle {
    
    CATransform3D transform = CATransform3DIdentity;
    transform.m34 = 1.0f / -800.0f;
    
    transform = CATransform3DRotate(transform, degreesToRadians(angle), 1.0f, 0.0f, 0.0f);
    
    [self.layer setTransform:transform];
    
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */

@end

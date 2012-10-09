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
    
    CGFloat coinBorderWidth = 2.0;
    /*
    CALayer *coinLayer = [CALayer layer];
    [coinLayer setBounds:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    [coinLayer setCornerRadius:self.frame.size.width/2];
    [coinLayer setPosition:self.center];
    [coinLayer setDoubleSided:YES];
    [coinLayer setMasksToBounds:YES];
    [coinLayer setName:@"coin"];
    */
    
    CATransformLayer *coinLayer = [CATransformLayer layer];
    [coinLayer setBounds:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    [coinLayer setPosition:self.center];
    [coinLayer setName:@"coin"];
    
    
    CAGradientLayer *gradientOverlay = [CAGradientLayer layer];
    [gradientOverlay setBounds:CGRectMake(0, 0, self.frame.size.width * 2, self.frame.size.height * 2)];
    [gradientOverlay setCornerRadius:self.frame.size.width];
    [gradientOverlay setPosition:CGPointMake(coinLayer.position.x, -coinLayer.position.y)];
    [gradientOverlay setColors:[NSArray arrayWithObjects: (id)[UIColor whiteColor].CGColor, (id)[UIColor clearColor].CGColor, nil]];
    
    CALayer *frontLayer = [CALayer layer];
    [frontLayer setBounds:coinLayer.bounds];
    [frontLayer setCornerRadius:self.frame.size.width/2];
    [frontLayer setBackgroundColor:[UIColor lightGrayColor].CGColor];
    [frontLayer setPosition:self.center];
    [frontLayer setBorderColor:[UIColor darkGrayColor].CGColor];
    [frontLayer setBorderWidth:coinBorderWidth];
    [frontLayer setDoubleSided:NO];
    [frontLayer setMasksToBounds:YES];
    
    CATextLayer *frontTextLayer = [CATextLayer layer];
    [frontTextLayer setBounds:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.width * .6)];
    [frontTextLayer setString:@"F"];
    [frontTextLayer setAlignmentMode:@"center"];
    [frontTextLayer setFont:[UIFont boldSystemFontOfSize:18].fontName];
    [frontTextLayer setFontSize:self.bounds.size.width * .70];
    [frontTextLayer setPosition:coinLayer.position];
    [frontTextLayer setForegroundColor:[UIColor whiteColor].CGColor];
    [frontTextLayer setShadowColor:[UIColor blackColor].CGColor];
    [frontTextLayer setShadowOffset:CGSizeMake(0.0f, -1.0f)];
    [frontTextLayer setShadowOpacity:0.7];
    [frontTextLayer setShadowRadius:1.0];
    
    CALayer *backLayer = [CALayer layer];
    [backLayer setBounds:coinLayer.bounds];
    [backLayer setCornerRadius:self.frame.size.width/2];
    [backLayer setBackgroundColor:[UIColor greenColor].CGColor];
    [backLayer setPosition:self.center];
    [backLayer setBorderColor:[UIColor darkGrayColor].CGColor];
    [backLayer setBorderWidth:coinBorderWidth];
    [backLayer setDoubleSided:NO];
    [backLayer setMasksToBounds:YES];
    
    CATextLayer *backTextLayer = [CATextLayer layer];
    [backTextLayer setBounds:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.width * .6)];
    [backTextLayer setString:@"B"];
    [backTextLayer setAlignmentMode:@"center"];
    [backTextLayer setFont:[UIFont boldSystemFontOfSize:18].fontName];
    [backTextLayer setFontSize:self.bounds.size.width * .70];
    [backTextLayer setPosition:coinLayer.position];
    [backTextLayer setForegroundColor:[UIColor whiteColor].CGColor];
    [backTextLayer setShadowColor:[UIColor blackColor].CGColor];
    [backTextLayer setShadowOffset:CGSizeMake(0.0f, -1.0f)];
    [backTextLayer setShadowOpacity:0.7];
    [backTextLayer setShadowRadius:1.0];
    
    
    [frontLayer addSublayer:frontTextLayer];
    [frontLayer addSublayer:gradientOverlay];
    
    [backLayer addSublayer:backTextLayer];
    [backLayer addSublayer:gradientOverlay];
    
    [coinLayer addSublayer:backLayer];
    [coinLayer addSublayer:frontLayer];
    
    [self.layer addSublayer:coinLayer];
    
}

- (void)startAnimating {
    
    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    [animationGroup setAnimations:[NSArray arrayWithObjects: [self riseAndFallAnimation], [self coinFlipAnimation], [self fadeOutAnimation], nil]];
    [animationGroup setDuration:4.5];
    
    CALayer *coinLayer = [self.layer.sublayers objectAtIndex:0];
    [coinLayer addAnimation:animationGroup forKey:nil];
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
    [opacityAnim setToValue:[NSNumber numberWithFloat:1.0]];
    
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

@end

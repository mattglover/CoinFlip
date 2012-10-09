//
//  CALayer+CAReflectionLayer.m
//  OceanBattles
//
//  Created by Matt Glover on 22/09/2012.
//  Copyright (c) 2012 Duchy Software Ltd. All rights reserved.
//

#import "CALayer+CAReflectionLayer.h"

#define REFLECTION_Y_OFFSET 2

@implementation CALayer (CAReflectionLayer)

+ (CALayer *)CAReflectionLayerWithImage:(UIImage *)image cornerRadius:(CGFloat)cornerRadius {
    
    CALayer *layer = [CALayer layer];
    [layer setBounds:CGRectMake(0, 0, image.size.width, (image.size.height * 2) + REFLECTION_Y_OFFSET)];
    
    CALayer *imageLayer = [CALayer layer];
    [imageLayer setBounds:CGRectMake(0, 0, image.size.width, image.size.height)];
    [imageLayer setPosition:CGPointMake(image.size.width / 2, image.size.height /2)];
    [imageLayer setContents:(id)[image CGImage]];
    [imageLayer setMasksToBounds:YES];
    [imageLayer setCornerRadius:cornerRadius];
    [layer addSublayer:imageLayer];
    
    
    CALayer *reflectionLayer = [CALayer layer];
    [reflectionLayer setBounds:imageLayer.bounds];
    [reflectionLayer setPosition:CGPointMake(imageLayer.bounds.size.width/2, imageLayer.bounds.size.height + (imageLayer.bounds.size.height / 2) + REFLECTION_Y_OFFSET)];
    [reflectionLayer setContents:(id)[image CGImage]];
    [reflectionLayer setMasksToBounds:YES];
    [reflectionLayer setCornerRadius:imageLayer.cornerRadius];
    [reflectionLayer setOpacity:0.50];
    
    CAGradientLayer *gradMask = [CAGradientLayer layer];
    [gradMask setBounds:reflectionLayer.bounds];
    [gradMask setPosition:CGPointMake(reflectionLayer.bounds.size.width / 2, 
                                      reflectionLayer.bounds.size.height / 2)];
    [gradMask setColors:[NSArray arrayWithObjects:(id)[UIColor clearColor].CGColor, (id)[UIColor blackColor].CGColor, nil]];
    [reflectionLayer setMask:gradMask];
    
    CATransform3D transform = CATransform3DIdentity;
    transform = CATransform3DRotate(transform, -(M_PI * 180.0f / 180.0), 1.0f, 0.0f, 0.0f);
    [reflectionLayer setTransform:transform];
    
    [layer addSublayer:reflectionLayer];
    
    return layer;
}

@end

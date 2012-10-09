//
//  CALayer+CAReflectionLayer.h
//  OceanBattles
//
//  Created by Matt Glover on 22/09/2012.
//  Copyright (c) 2012 Duchy Software Ltd. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@interface CALayer (CAReflectionLayer)

+ (CALayer *)CAReflectionLayerWithImage:(UIImage *)image cornerRadius:(CGFloat)cornerRadius;

@end

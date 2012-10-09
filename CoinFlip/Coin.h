//
//  Coin.h
//  CoinFlip
//
//  Created by Matt Glover on 05/10/2012.
//  Copyright (c) 2012 Duchy Software Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    CoinSizeSmall = 1,
    CoinSizeMedium = 2,
    CoinSizeLarge = 3,
    CoinSizeExtraLarge = 4,
} CoinSize;

@interface Coin : UIView

+ (Coin *)coinWithSize:(CoinSize)coinSize;

- (id)initWithFrame:(CGRect)frame coinSize:(CoinSize)coinSize;

- (void)flipCoinByAngle:(CGFloat)angle;
- (void)startAnimating;
- (void)stopAnimating;

@end

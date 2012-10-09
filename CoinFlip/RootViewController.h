//
//  RootViewController.h
//  CoinFlip
//
//  Created by Matt Glover on 05/10/2012.
//  Copyright (c) 2012 Duchy Software Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RootViewController : UIViewController

@property (retain, nonatomic) IBOutlet UISlider *slider;

- (IBAction)sliderValueChanged:(id)sender;
- (IBAction)resetButtonPressed:(id)sender;
@end

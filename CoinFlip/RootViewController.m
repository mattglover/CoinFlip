//
//  RootViewController.m
//  CoinFlip
//
//  Created by Matt Glover on 05/10/2012.
//  Copyright (c) 2012 Duchy Software Ltd. All rights reserved.
//

#import "RootViewController.h"

#import "Coin.h"

@interface RootViewController ()

@end

@implementation RootViewController
@synthesize slider;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    Coin *coin = [Coin coinWithSize:CoinSizeMedium];
    [coin setCenter:self.view.center];
    [coin setTag:1];
    
    [self.view addSubview:coin];
}

- (void)viewDidUnload
{
    [self setSlider:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc {
    [slider release];
    [super dealloc];
}
- (IBAction)sliderValueChanged:(id)sender {
    
//    CGFloat xAngle = (([self.slider value] - 0.5) * 100.0f) * 3.6;
      CGFloat xAngle = (([self.slider value] - 0.5) * 100.0f) * 1.8;
    
    [(Coin *)[self.view viewWithTag:1] flipCoinByAngle:xAngle];
}

- (IBAction)resetButtonPressed:(id)sender {
    [(Coin *)[self.view viewWithTag:1] startAnimating];
}

@end

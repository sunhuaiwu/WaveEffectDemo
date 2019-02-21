//
//  ViewController.m
//  WaveEffect
//
//  Created by caimao on 2019/2/19.
//  Copyright © 2019 sunhw. All rights reserved.
//

#import "ViewController.h"
#import "WaveEffectView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    WaveEffectView *waveView = [[WaveEffectView alloc] initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, 300)];
    [self.view addSubview:waveView];

    [waveView startAnimation];
    
}


@end

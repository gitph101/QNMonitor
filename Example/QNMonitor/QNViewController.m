//
//  QNViewController.m
//  QNMonitor
//
//  Created by gitph101 on 05/26/2017.
//  Copyright (c) 2017 gitph101. All rights reserved.
//

#import "QNViewController.h"
#import "QNMonitorManager.h"
#import "QNFluencyMonitor.h"

@interface QNViewController ()

@end

@implementation QNViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [QNFluencyMonitor startMonitor];
    [[QNMonitorManager shareManager] startMonitoring];


	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

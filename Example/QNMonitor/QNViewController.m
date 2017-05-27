//
//  QNViewController.m
//  QNMonitor
//
//  Created by gitph101 on 05/26/2017.
//  Copyright (c) 2017 gitph101. All rights reserved.
//

#import "QNViewController.h"
#import "QNFluencyMonitor.h"
#import "QNFPSDisplayer.h"
#import "QNMonitorManager.h"

@interface QNViewController ()

@end

@implementation QNViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [QNFluencyMonitor startMonitor];
    
//    for (NSInteger i = 0; i < 60000 ; i++) {
//        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 4, 4)];
//        view.backgroundColor = [UIColor redColor];
//        [self.view addSubview:view];
//    }
//    for (NSInteger i = 0; i < 60000 ; i++) {
//        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 1, 1)];
//        [self.view addSubview:view];
//    }
//    for (NSInteger i = 0; i < 60000 ; i++) {
//        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 4, 4)];
//        view.backgroundColor = [UIColor redColor];
//        [self.view addSubview:view];
//    }
//    for (NSInteger i = 0; i < 60000 ; i++) {
//        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 4, 4)];
//        view.backgroundColor = [UIColor redColor];
//        [self.view addSubview:view];
//    }
//    for (NSInteger i = 0; i < 60000 ; i++) {
//        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 4, 4)];
//        view.backgroundColor = [UIColor redColor];
//        [self.view addSubview:view];
//    }
//    for (NSInteger i = 0; i < 60000 ; i++) {
//        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 4, 4)];
//        view.backgroundColor = [UIColor redColor];
//        [self.view addSubview:view];
//    }
//    
    
//    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(20, 20, 40, 40)];
//    view.backgroundColor = [UIColor redColor];
//    [self.view addSubview:view];
//    
//    [QNFPSDisplayer showView:self.view];
//  
    
    [[QNMonitorManager shareManager] startMonitoring];


	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

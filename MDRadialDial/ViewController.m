//
//  ViewController.m
//  MDRadialDial
//
//  Created by Michael Diakonov on 12/4/14.
//  Copyright (c) 2014 Michael Diakonov. All rights reserved.
//

#import "ViewController.h"
#import "MDRadialDial.h"

@interface ViewController ()

@end

@implementation ViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if(!self) return nil;
    
    
    return self;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    MDRadialDial *radialDial = [[MDRadialDial alloc] initWithFrame:CGRectMake(5, 5, 300, 300) delegate:self minValue:0 maxValue:100];
    [self.view addSubview:radialDial];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

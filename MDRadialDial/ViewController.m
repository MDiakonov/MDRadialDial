//
//  ViewController.m
//  MDRadialDial
//
//  Created by Michael Diakonov on 12/4/14.
//  Copyright (c) 2014 Michael Diakonov. All rights reserved.
//

#import "ViewController.h"
#import "Common.h"
#import "MDRadialDial.h"

@interface ViewController () <MDRadialDialDelegate>

@end

@implementation ViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if(!self) return nil;
    
    
    return self;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGSize size = CGSizeMake(300, 300);
    MDRadialDial *radialDial = [[MDRadialDial alloc] initWithFrame:CGRectMake(5,20,size.width,size.height) delegate:self initialValue:0];
    [self.view addSubview:radialDial];
    
}
- (void)radialDial:(MDRadialDial *)radialDial didChangeWithValue:(double)value{
    
    DLog(@"RadialDial value: %f", value);
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

//
//  MDRadialDial.m
//  MDRadialDial
//
//  Created by Michael Diakonov on 12/4/14.
//  Copyright (c) 2014 Michael Diakonov. All rights reserved.
//

#import "MDRadialDial.h"

#import "Common.h"


@interface MDRadialDial ()

@property (assign) int minValue;
@property (assign) int maxValue;


@end

@implementation MDRadialDial

- (instancetype)initWithFrame:(CGRect)frame delegate:(id)delegate minValue:(int)minValue maxValue:(int)maxValue{
    
    self = [super initWithFrame:frame];
    if(!self) return nil;
    
    self.backgroundColor = [UIColor colorWithRed:.65 green:.65 blue:.65 alpha:1.0];
    
    _delegate = delegate;
    _minValue = minValue;
    _maxValue = maxValue;
    
    return self;
    
}

- (instancetype)init{
    
    return [self initWithFrame:kDefaultSize delegate:nil minValue:0 maxValue:100];
    
}

- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    [super drawRect:rect];
    
    CGRect frame = self.bounds;
    
    //Create and save context
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSaveGState(ctx);
    
    //Draw glow circle
    CGContextAddArc(ctx, frame.size.width/2, frame.size.height/2, frame.size.width/4 - 8 , 0, 2 * M_PI, 1);
    CGContextSetLineWidth(ctx, 8);
    CGContextSetLineCap(ctx, kCGLineCapButt);
    [[UIColor greenColor] setStroke];
    CGContextDrawPath(ctx, kCGPathStroke);
    
    //Draw glow effect
    CGContextSetShadowWithColor(ctx, CGSizeMake(0, 0), 4.0f, [UIColor greenColor].CGColor);
    CGContextAddArc(ctx, frame.size.width/2, frame.size.height/2, frame.size.width/4 - 8 , 0, 2 * M_PI, 1);
    CGContextSetLineWidth(ctx, 8);
    CGContextSetLineCap(ctx, kCGLineCapButt);
    [[UIColor greenColor] setStroke];
    CGContextDrawPath(ctx, kCGPathStroke);
    
    //Restore and re-save the clean context state
    CGContextRestoreGState(ctx);
    CGContextSaveGState(ctx);
    
    //Draw dial and shadow
    CGContextSetShadow(ctx, CGSizeMake(8, 10), 10.0f);
    CGContextAddArc(ctx, frame.size.width/2, frame.size.height/2, frame.size.width/4 - 12 , 0, 2 * M_PI, 1);
    CGContextSetLineWidth(ctx, 8);
    CGContextSetLineCap(ctx, kCGLineCapButt);
    [[UIColor grayColor] setFill];
    CGContextDrawPath(ctx, kCGPathFill);    
    
    //Restore and re-save the clean context state
    CGContextRestoreGState(ctx);
    CGContextSaveGState(ctx);
    
    //Apply radial gradient to dial
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGFloat components[] = {
                            1.0,1.0,1.0,0.10,
                            1.0,1.0,1.0,0.02
                           };
    
    CGFloat locations[] = {0.0, 1.0};
    CGGradientRef gradient = CGGradientCreateWithColorComponents(colorSpace, components, locations, 2);
    CGPoint start = CGPointMake(frame.size.width/3, frame.size.height/3);
    CGPoint end = CGPointMake(frame.size.width/3, frame.size.height/3);
    CGContextDrawRadialGradient(ctx, gradient, start, 5.0, end, 70.0, kCGGradientDrawsBeforeStartLocation);
    CGGradientRelease(gradient);
    CGColorSpaceRelease(colorSpace);
    
    //Restore and re-save the clean context state
    CGContextRestoreGState(ctx);
    CGContextSaveGState(ctx);
    
    //Draw dial indicator
    CGContextAddArc(ctx, frame.size.width/2 - 32, frame.size.height/2 + 25, 14 , 0, 2 * M_PI, 1);
    CGContextSetLineWidth(ctx, 1);
    CGContextSetLineCap(ctx, kCGLineCapButt);
    CGContextSetRGBFillColor(ctx, .57, .57, .57, 1.0);
    CGContextDrawPath(ctx, kCGPathFill);
    
}

//-----------------------------------------------
#pragma mark - UIControl Tracking touch methods
//-----------------------------------------------

- (BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event{
    
    [super beginTrackingWithTouch:touch withEvent:event];
    
    return YES;
    
}
- (BOOL)continueTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event{
    
    [super continueTrackingWithTouch:touch withEvent:event];
    
    return YES;
    
}
- (void)endTrackingWithTouch:(UITouch *)touches withEvent:(UIEvent *)event{
    
    [super endTrackingWithTouch:touches withEvent:event];
    
    
}

@end

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

@property (assign) double minValue;
@property (assign) double maxValue;
@property (assign) double initialValue;
@property (assign) int lineWidth;

@end

@implementation MDRadialDial

- (instancetype)initWithFrame:(CGRect)frame delegate:(id<MDRadialDialDelegate>)delegate minValue:(double)minValue maxValue:(double)maxValue
                 initialValue:(double)initialValue{
    
    self = [super initWithFrame:frame];
    if(!self) return nil;
    
    self.backgroundColor = [UIColor colorWithRed:.65 green:.65 blue:.65 alpha:1.0];
    //self.backgroundColor = [UIColor clearColor];
    _delegate = delegate;
    _minValue = minValue;
    _maxValue = maxValue;
    _initialValue  = initialValue;
    
    _lineWidth = (self.frame.size.width / 50) + 3;
    
    return self;
    
}

- (instancetype)init{
    
    CGSize size = kDefaultSize;
    return [self initWithFrame:CGRectMake(5, 5, size.width, size.height) delegate:nil minValue:0 maxValue:100 initialValue:0];
    
}

- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    [super drawRect:rect];
    
    CGRect frame = self.bounds;
    
    //Create and save context
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSaveGState(ctx);
    
    //Draw glow holder circle i.e. circle below the glow
    CGContextAddArc(ctx, frame.size.width/2, frame.size.height/2, frame.size.width/2 - _lineWidth, 0, 2 * M_PI, 1);
    CGContextSetLineWidth(ctx, _lineWidth);
    CGContextSetLineCap(ctx, kCGLineCapButt);
    CGContextSetRGBStrokeColor(ctx, .375, .375, .375, 1.0);
    CGContextDrawPath(ctx, kCGPathStroke);
    
    CGContextAddArc(ctx, frame.size.width/2, frame.size.height/2, frame.size.width/2 - _lineWidth , 0, 2 * M_PI, 1);
    CGContextSetLineWidth(ctx, _lineWidth/2);
    CGContextSetLineCap(ctx, kCGLineCapButt);
    [[UIColor whiteColor] setStroke];
    CGContextSetAlpha(ctx, 0.025f);
    CGContextDrawPath(ctx, kCGPathStroke);
    
    //Restore and re-save the clean context state
    CGContextRestoreGState(ctx);
    CGContextSaveGState(ctx);
    
    //Draw glow circle
    CGContextAddArc(ctx, frame.size.width/2, frame.size.height/2, frame.size.width/2 - _lineWidth , 0, 2 * M_PI, 1);
    CGContextSetLineWidth(ctx, _lineWidth);
    CGContextSetLineCap(ctx, kCGLineCapButt);
    CGContextSetRGBStrokeColor(ctx, 124/255.0, 252/255.0, 0/255.0, 1.0);
    CGContextDrawPath(ctx, kCGPathStroke);
    
    //Draw glow effect
    CGContextSetShadowWithColor(ctx, CGSizeMake(0, 0), 5.0f, [UIColor greenColor].CGColor);
    CGContextAddArc(ctx, frame.size.width/2, frame.size.height/2, frame.size.width/2 - _lineWidth , 0, 2 * M_PI, 1);
    CGContextSetLineWidth(ctx, _lineWidth);
    CGContextSetLineCap(ctx, kCGLineCapButt);
    CGContextSetRGBStrokeColor(ctx, 124/255.0, 252/255.0, 0/255.0, 1.0);
    CGContextDrawPath(ctx, kCGPathStroke);
    
    //Restore and re-save the clean context state
    CGContextRestoreGState(ctx);
    CGContextSaveGState(ctx);

    //Draw dial and shadow
    CGContextSetShadow(ctx, CGSizeMake(8, 10), 14.0f);
    CGContextAddArc(ctx, frame.size.width/2, frame.size.height/2, frame.size.width/2 - (_lineWidth + (_lineWidth / 2)) , 0, 2 * M_PI, 1);
    CGContextSetLineWidth(ctx, _lineWidth);
    CGContextSetLineCap(ctx, kCGLineCapButt);
    [[UIColor grayColor] setFill];
    CGContextDrawPath(ctx, kCGPathFill);
    
    //Restore and re-save the clean context state
    CGContextRestoreGState(ctx);
    CGContextSaveGState(ctx);

    //Draw dial outline
    CGContextAddArc(ctx, frame.size.width/2, frame.size.height/2, frame.size.width/2 - (_lineWidth + (_lineWidth / 2)) , 0, 2 * M_PI, 1);
    CGContextSetLineWidth(ctx, 1);
    CGContextSetLineCap(ctx, kCGLineCapButt);
    [[UIColor blackColor] setStroke];
    CGContextSetAlpha(ctx, 0.06f);
    CGContextDrawPath(ctx, kCGPathStroke);
    
    //Restore and re-save the clean context state
    CGContextRestoreGState(ctx);
    CGContextSaveGState(ctx);
//
//    //Draw dial indicator
//    CGContextAddArc(ctx, frame.size.width/2 - 32, frame.size.height/2 + 25, 14 , 0, 2 * M_PI, 1);
//    CGContextSetLineWidth(ctx, 1);
//    CGContextSetLineCap(ctx, kCGLineCapButt);
//    CGContextSetRGBFillColor(ctx, .466, .466, .466, 1.0);
//    CGContextDrawPath(ctx, kCGPathFill);
//    
    //Create clipping mask for radial gradient
    UIGraphicsBeginImageContext(self.frame.size);
    CGContextRef maskCtx = UIGraphicsGetCurrentContext();
    
    CGContextSetShadow(maskCtx, CGSizeMake(8, 10), 10.0f);
    CGContextAddArc(maskCtx, frame.size.width/2, frame.size.height/2, frame.size.width/2 - (_lineWidth + (_lineWidth / 2)), 0, 2 * M_PI, 1);
    CGContextSetLineWidth(maskCtx, _lineWidth);
    CGContextSetLineCap(maskCtx, kCGLineCapButt);
    [[UIColor redColor] setFill];
    CGContextDrawPath(maskCtx, kCGPathFill);
    
    CGImageRef mask = CGBitmapContextCreateImage(UIGraphicsGetCurrentContext());
    UIGraphicsEndImageContext();
    
    //Clip context
    CGContextClipToMask(ctx, self.bounds, mask);
    CGImageRelease(mask);
    
    //Apply radial gradient to dial
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGFloat components[] = {
                            1.0,1.0,1.0,0.1,
                            1.0,1.0,1.0,0.02
                           };
    
    CGFloat locations[] = {0.0,0.25,0.5,0.75,1.0};
    CGGradientRef gradient = CGGradientCreateWithColorComponents(colorSpace, components, locations, 2);
    CGPoint startPoint = CGPointMake(_lineWidth, _lineWidth);
    CGPoint endPoint = CGPointMake(_lineWidth, _lineWidth);
    CGContextDrawRadialGradient(ctx, gradient, startPoint, 1, endPoint, frame.size.width/2 + frame.size.width / 8, kCGGradientDrawsBeforeStartLocation);
    CGGradientRelease(gradient);
    CGColorSpaceRelease(colorSpace);
    
    //Restore and re-save the clean context state
    CGContextRestoreGState(ctx);
    CGContextSaveGState(ctx);

    
}

//-----------------------------------------------
#pragma mark - UIControl Tracking touch methods
//-----------------------------------------------

- (BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event{
    
    [super beginTrackingWithTouch:touch withEvent:event];
    
    CGPoint touchLocation = [touch locationInView:self];
    
    return YES;
    
}
- (BOOL)continueTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event{
    
    [super continueTrackingWithTouch:touch withEvent:event];
    
    CGPoint touchLocation = [touch locationInView:self];
    
    return YES;
    
}
- (void)endTrackingWithTouch:(UITouch *)touches withEvent:(UIEvent *)event{
    
    [super endTrackingWithTouch:touches withEvent:event];
    
    CGPoint touchLocation = [touches locationInView:self];
    
}

@end

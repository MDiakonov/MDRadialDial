/**
 * @file MDRadialDial.h
 * @author Michael Diakonov
 * @version 1.0
 *
 * @section LICENSE
 *
 * The MIT License (MIT)
 *
 * Copyright (c) 2014 Michael Diakonov
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 *
 */

#import <UIKit/UIKit.h>

#define kMDRadialDialDefaultSize      CGSizeMake(100, 100)
#define kMDRadialDialExtraSmallSize   CGSizeMake(50, 50)
#define kMDRadialDialSmallSize        kMDRadialDialDefaultSize
#define kMDRadialDialMediumSize       CGSizeMake(200, 200)
#define kMDRadialDialLargeSize        CGSizeMake(300, 300)
#define kMDRadialDialExtraLargeSize   CGSizeMake(400, 400)

@class MDRadialDial;

@protocol MDRadialDialDelegate <NSObject>
@required
- (void)radialDial:(MDRadialDial *)radialDial didChangeWithValue:(double)value;
@end

@interface MDRadialDial : UIControl


//** Sets the color of the glow ring that surrounds the dial */
@property (nonatomic, strong) UIColor *glowColor;
//** Sets the color of the dial */
@property (nonatomic, strong) UIColor *dialColor;
//** Sets the required delegate */
@property (nonatomic, weak) id <MDRadialDialDelegate> delegate;

/**
 * Creates a radial dial with the specified parameters.
 *
 * @param frame        (CGRect) The frame which specifies the size of the radial dial
 * @param delegate     (id <MDRadialDialDelegate>) The objects delegate. Must implement the required protocol methods
 * @param initialValue (double) The initialValue at which to set the dial indicator and current value. Specify a value between 0.0 and 1.0
 * 
 * @returns MDRadialDial instance
 *
*/
- (instancetype)initWithFrame:(CGRect)frame
                     delegate:(id<MDRadialDialDelegate>)delegate
                 initialValue:(double)initialValue;

@end

/**
 * @file MDRadialDial.h
 * @author  Michael Diakonov
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


#define kDefaultSize      CGSizeMake(100, 100)
#define kExtraSmallSize   CGSizeMake(50, 50)
#define kSmallSize        CGSizeMake(100, 100)
#define kMediumSize       CGSizeMake(200, 200)
#define kLargeSize        CGSizeMake(300, 300)

@class MDRadialDial;

@protocol MDRadialDialDelegate <NSObject>
@required
- (void)radialDial:(MDRadialDial *)radialDial didChangeWithValue:(int)value;
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
 * @param frame        (CGRect) The frame which specifies the size of the radial dial.
 * @param delegate     (id <MDRadialDialDelegate>) The objects delegate. Must implement the required protocol methods
 * @param minValue     (double) The minimum value of the radial dial
 * @param maxValue     (double) The maximum value of the radial dial
 * @param initialValue (double) The initialValue at which to set the dial indicator and current value
 * 
 * @returns MDRadialDial instance
 *
*/
- (instancetype)initWithFrame:(CGRect)frame
                     delegate:(id<MDRadialDialDelegate>)delegate
                     minValue:(double)minValue
                     maxValue:(double)maxValue
                 initialValue:(double)initialValue;

@end

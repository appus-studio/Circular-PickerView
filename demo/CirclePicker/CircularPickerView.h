//
//  CircularPickerView.h
//  CirclePicker
//
//  Created by vladyslav.anokhin on 9/22/15.
//  Copyright (c) 2015 Appus. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

IB_DESIGNABLE
@interface CircularPickerView : UIControl

/** APPEARANCE
 *  @lineColor - color of active hand
 *  @bgColor   - The color of the background circle
 *  @lineWidth - The width of active hand and background circle
 */

@property(nonatomic)IBInspectable UIColor* lineColor;
@property(nonatomic)IBInspectable UIColor* bgColor;
@property(nonatomic)IBInspectable CGFloat lineWidth;

/** STATES
 *  @maxValue     - The high value allowed for selection
 *  @minValue     - The lowest value allowed for selection
 *  @defaultValue - The value which the view will displaye be default
 *  @step         - The step which can be select value
 *  @autocomplete - Complete selected value to nearest step value
 *  @currentValue -
 */

@property(nonatomic)IBInspectable NSInteger minValue;
@property(nonatomic)IBInspectable NSInteger maxValue;
@property(nonatomic)IBInspectable NSInteger defaultValue;

@property(nonatomic)IBInspectable NSUInteger step;
@property(nonatomic)IBInspectable BOOL autocomplete;

@property(nonatomic, readonly)CGFloat currentValue;

@end



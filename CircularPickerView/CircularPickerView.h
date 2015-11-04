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

///  -lineColor - color of active hand
@property(nonatomic)IBInspectable UIColor* lineColor;

///  -bgColor   - The color of the background circle
@property(nonatomic)IBInspectable UIColor* bgColor;

///  -lineWidth - The width of active hand and background circle
@property(nonatomic)IBInspectable CGFloat lineWidth;

///   -maxValue  - The high value allowed for selection
@property(nonatomic)IBInspectable NSInteger minValue;

///   -minValue  - The lowest value allowed for selection
@property(nonatomic)IBInspectable NSInteger maxValue;

///   -defaultValue - The value which the view will displaye be default
@property(nonatomic)IBInspectable NSInteger defaultValue;

///   -step      - The step which can be select value
@property(nonatomic)IBInspectable NSUInteger step;

///   -autocomplete - Complete selected value to nearest step value
@property(nonatomic)IBInspectable BOOL autocomplete;

///   -currentValue -
@property(nonatomic, readonly)CGFloat currentValue;

@end



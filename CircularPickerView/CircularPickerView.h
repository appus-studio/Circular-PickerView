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

@property(nonatomic)IBInspectable UIColor* lineColor;
@property(nonatomic)IBInspectable UIColor* bgColor;
@property(nonatomic)IBInspectable CGFloat lineWidth;

@property(nonatomic)IBInspectable NSInteger minValue;
@property(nonatomic)IBInspectable NSInteger maxValue;
@property(nonatomic)IBInspectable NSInteger defulatValue;

@property(nonatomic)IBInspectable NSUInteger step;
@property(nonatomic)IBInspectable BOOL autocomplete;

@property(nonatomic, readonly)CGFloat currentValue;

@end



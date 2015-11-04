//
//  CircularPickerView.m
//  CirclePicker
//
//  Created by vladyslav.anokhin on 9/22/15.
//  Copyright (c) 2015 Appus. All rights reserved.
//

#import "CircularPickerView.h"
#import <math.h>

#define DEGREES_TO_RADIANS(angle) ((angle) / 180.f * M_PI)
#define RADIANS_TO_DEGREES(dgr) ((dgr) * 180.f / M_PI)

@interface CircularPickerView()

@property(nonatomic)CGFloat angle;
/// -coef -
@property(nonatomic)CGFloat coef;

@property(nonatomic, readwrite)CGFloat currentValue;

@end

@implementation CircularPickerView


- (void)setAngle:(CGFloat)newAngle{
    _angle = newAngle;
    [self setNeedsDisplay];
}

-(void)setLineWidth:(CGFloat)lineWidth{
   _lineWidth = lineWidth;
    [self setNeedsDisplay];
}

#pragma makr - Touches

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    CGPoint point      = [self pointFromTouches:touches];
    float currentAngle = [self angleFromPoint:point];
    
    [self setAngle:currentAngle];
    
    self.currentValue = [self getCurrentValue];
    [self sendActionsForControlEvents:UIControlEventValueChanged];
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    CGPoint point      = [self pointFromTouches:touches];
    float currentAngle = [self angleFromPoint:point];
    
    if(self.autocomplete){
         currentAngle = [self autocompleteAngle:currentAngle];
    }
   
    [self setAngle:currentAngle];

    self.currentValue = [self getCurrentValue];
    [self sendActionsForControlEvents:UIControlEventValueChanged];
}

#pragma mark - self methods

-(NSInteger)autocompleteAngle:(CGFloat)angle{
    
    NSInteger degreesPerStep = 360 / ((labs(self.minValue) + labs(self.maxValue))/self.step);
    
    NSInteger minStepValue = angle / degreesPerStep;
    NSInteger maxStepValue = minStepValue +1;
    
    NSInteger dMin = angle - (minStepValue * degreesPerStep);
    NSInteger dMax = (maxStepValue * degreesPerStep) - angle;
    
    return dMin < dMax ? minStepValue * degreesPerStep : maxStepValue *degreesPerStep;
    
}

-(CGFloat)getCurrentValue{
    return (self.angle * self.coef) + self.minValue; // if min value differs from 0 we should cobsider
}

-(CGPoint)pointFromTouches:(NSSet*)touches{
    UITouch *touch = [touches anyObject];
    return [touch locationInView:self];
}

- (float)angleFromPoint:(CGPoint)tapPoint{
    
    float degrees = RADIANS_TO_DEGREES([self radiansFromPoint:tapPoint]);
    degrees = degrees > 0.f ? (360.f - degrees) :  -degrees;
    
    return degrees;
}

-(float)radiansFromPoint:(CGPoint)tapPoint{
    CGPoint defualtVector = CGPointMake(0,-1);
    
    float radians = atan2(defualtVector.y, defualtVector.x) -
    atan2(tapPoint.y - self.bounds.size.height/2, tapPoint.x - self.bounds.size.width/2);
    return radians;
}

-(CGFloat)getArcRadius{
    return MIN(CGRectGetWidth(self.frame)/2, CGRectGetHeight(self.frame)/2) - self.lineWidth;
}

#pragma mark Darwing

-(void)drawArcBg{
    [self drawArcWithRadius:[self getArcRadius]
                   endAngle:360.f
                  lineWidth:self.lineWidth
                  lineColor:self.bgColor];
}

-(void)drawActiveArc{
    [self drawArcWithRadius:[self getArcRadius]
                   endAngle:self.angle
                  lineWidth:self.lineWidth
                  lineColor:self.lineColor];
}

-(void)drawArcWithRadius:(CGFloat)radius
                endAngle:(CGFloat)endAngle
               lineWidth:(CGFloat)width
               lineColor:(UIColor*)color{
    
    CGPoint center = CGPointMake(CGRectGetWidth(self.frame)/2, CGRectGetHeight(self.frame)/2);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetLineWidth(context, width);
    CGContextSetRGBFillColor(context, 0.f, 0.f, 0.f, 0.f);
    CGContextSetLineCap(context, kCGLineCapButt);
    CGContextSetStrokeColorWithColor(context, color.CGColor);
    
    CGContextAddArc(context,
                    center.x,
                    center.y,
                    radius,
                    -M_PI_2,
                    -M_PI_2 + DEGREES_TO_RADIANS(endAngle),
                    NO);
    
    CGContextStrokePath(context);
}

#pragma mark - lifecycle

-(void)awakeFromNib{
    self.coef = (self.maxValue - self.minValue) / 360.f;// part of sector in one degrees
    self.angle = ( self.defaultValue - self.minValue ) / self.coef;
    
    if(!self.step){
        self.step = 1;
    }
}

- (void)drawRect:(CGRect)rect{
    [super drawRect:rect];

    [self drawArcBg];
    [self drawActiveArc];
    
}

@end

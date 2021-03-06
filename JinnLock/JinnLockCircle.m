/***************************************************************************************************
 **  Copyright © 2016年 Jinn Chang. All rights reserved.
 **  Giuhub: https://github.com/jinnchang
 **
 **  FileName: JinnLockCircle.m
 **  Description: 圆圈
 **
 **  History
 **  -----------------------------------------------------------------------------------------------
 **  Author: jinnchang
 **  Date: 16/4/28
 **  Version: 1.0.0
 **  Remark: Create
 **************************************************************************************************/

#import "JinnLockCircle.h"
#import "JinnLockConfig.h"

@interface JinnLockCircle ()

@end

@implementation JinnLockCircle

- (instancetype)initWithDiameter:(CGFloat)diameter
{
    self = [super initWithFrame:CGRectMake(0, 0, diameter, diameter)];
    
    if (self)
    {
        self.backgroundColor = [UIColor clearColor];
        self.diameter = diameter;
        self.state = JinnLockCircleStateNormal;
    }
    
    return self;
}

- (void)updateCircleState:(JinnLockCircleState)state
{
    [self setState:state];
    [self setNeedsDisplay];
}

#pragma mark - Draw

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, JINN_LOCK_CIRCLE_WIDTH);
    
    switch (self.state)
    {
        case JinnLockCircleStateNormal:
        {
            [self drawEmptyCircleWithContext:context
                                        rect:CGRectMake(JINN_LOCK_CIRCLE_WIDTH / 2,
                                                        JINN_LOCK_CIRCLE_WIDTH / 2,
                                                        self.diameter - JINN_LOCK_CIRCLE_WIDTH,
                                                        self.diameter - JINN_LOCK_CIRCLE_WIDTH)
                                 strokeColor:JINN_LOCK_COLOR_NORMAL
                                   fillColor:JINN_LOCK_COLOR_BACKGROUND];
        }
            break;
        case JinnLockCircleStateSelected:
        {
            [self drawCenterCircleWithContext:context
                                         rect:CGRectMake(JINN_LOCK_CIRCLE_WIDTH / 2,
                                                         JINN_LOCK_CIRCLE_WIDTH / 2,
                                                         self.diameter - JINN_LOCK_CIRCLE_WIDTH,
                                                         self.diameter - JINN_LOCK_CIRCLE_WIDTH)
                                   centerRect:CGRectMake(self.diameter * (0.5 - JINN_LOCK_CIRCLE_CENTER_RATIO / 2),
                                                         self.diameter * (0.5 - JINN_LOCK_CIRCLE_CENTER_RATIO / 2),
                                                         self.diameter * JINN_LOCK_CIRCLE_CENTER_RATIO,
                                                         self.diameter * JINN_LOCK_CIRCLE_CENTER_RATIO)
                                  strokeColor:JINN_LOCK_COLOR_NORMAL
                                    fillColor:JINN_LOCK_COLOR_BACKGROUND];
        }
            break;
        case JinnLockCircleStateFill:
        {
            [self drawSolidCircleWithContext:context
                                        rect:CGRectMake(JINN_LOCK_CIRCLE_WIDTH / 2,
                                                        JINN_LOCK_CIRCLE_WIDTH / 2,
                                                        self.diameter - JINN_LOCK_CIRCLE_WIDTH,
                                                        self.diameter - JINN_LOCK_CIRCLE_WIDTH)
                                 strokeColor:JINN_LOCK_COLOR_NORMAL];
        }
            break;
        case JinnLockCircleStateError:
        {
            [self drawCenterCircleWithContext:context
                                         rect:CGRectMake(JINN_LOCK_CIRCLE_WIDTH / 2,
                                                         JINN_LOCK_CIRCLE_WIDTH / 2,
                                                         self.diameter - JINN_LOCK_CIRCLE_WIDTH,
                                                         self.diameter - JINN_LOCK_CIRCLE_WIDTH)
                                   centerRect:CGRectMake(self.diameter * (0.5 - JINN_LOCK_CIRCLE_CENTER_RATIO / 2),
                                                         self.diameter * (0.5 - JINN_LOCK_CIRCLE_CENTER_RATIO / 2),
                                                         self.diameter * JINN_LOCK_CIRCLE_CENTER_RATIO,
                                                         self.diameter * JINN_LOCK_CIRCLE_CENTER_RATIO)
                                  strokeColor:JINN_LOCK_COLOR_ERROR
                                    fillColor:JINN_LOCK_COLOR_BACKGROUND];
        }
            break;
        default:
            break;
    }
}

#pragma mark Private

/**
 *  空心圆环
 *
 *  @param context
 *  @param rect
 *  @param strokeColor
 *  @param fillColor
 */
- (void)drawEmptyCircleWithContext:(CGContextRef)context
                              rect:(CGRect)rect
                       strokeColor:(UIColor *)strokeColor
                         fillColor:(UIColor *)fillColor
{
    CGContextSetStrokeColorWithColor(context, strokeColor.CGColor);
    CGContextSetFillColorWithColor(context, fillColor.CGColor);
    CGContextAddEllipseInRect(context, rect);
    CGContextDrawPath(context, kCGPathFillStroke);
}

/**
 *  实心圆
 *
 *  @param context
 *  @param rect
 *  @param strokeColor
 */
- (void)drawSolidCircleWithContext:(CGContextRef)context
                              rect:(CGRect)rect
                       strokeColor:(UIColor *)strokeColor
{
    CGContextSetStrokeColorWithColor(context, strokeColor.CGColor);
    CGContextSetFillColorWithColor(context, strokeColor.CGColor);
    CGContextAddEllipseInRect(context, rect);
    CGContextDrawPath(context, kCGPathFillStroke);
}

/**
 *  圆环 + 中心小圆
 *
 *  @param context
 *  @param rect
 *  @param centerRect
 *  @param strokeColor
 *  @param fillColor
 */
- (void)drawCenterCircleWithContext:(CGContextRef)context
                               rect:(CGRect)rect
                         centerRect:(CGRect)centerRect
                        strokeColor:(UIColor *)strokeColor
                          fillColor:(UIColor *)fillColor
{
    CGContextSetStrokeColorWithColor(context, strokeColor.CGColor);
    CGContextSetFillColorWithColor(context, fillColor.CGColor);
    CGContextAddEllipseInRect(context, rect);
    CGContextDrawPath(context, kCGPathFillStroke);
    
    CGContextSetFillColorWithColor(context, strokeColor.CGColor);
    CGContextAddEllipseInRect(context, centerRect);
    CGContextDrawPath(context, kCGPathFillStroke);
}

@end
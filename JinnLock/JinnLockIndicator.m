/***************************************************************************************************
 **  Copyright © 2016年 Jinn Chang. All rights reserved.
 **  Giuhub: https://github.com/jinnchang
 **
 **  FileName: JinnLockIndicator.m
 **  Description: 解锁密码指示器
 **
 **  History
 **  -----------------------------------------------------------------------------------------------
 **  Author: jinnchang
 **  Date: 16/4/28
 **  Version: 1.0.0
 **  Remark: Create
 **************************************************************************************************/

#import "JinnLockIndicator.h"
#import "JinnLockConfig.h"
#import "JinnLockCircle.h"

@interface JinnLockIndicator ()

@property (nonatomic, strong) NSMutableArray *circleArray;
@property (nonatomic, strong) NSMutableArray *selectedCircleArray;
@property (nonatomic, assign) CGFloat circleMargin;

@end

@implementation JinnLockIndicator

#pragma mark - Init

- (instancetype)init
{
    self = [super init];
    
    if (self)
    {
        [self setup];
        [self createCircles];
    }
    
    return self;
}

- (void)setup
{
    self.backgroundColor = [UIColor clearColor];
    self.clipsToBounds = YES;
    
    self.circleArray = [NSMutableArray array];
    self.selectedCircleArray = [NSMutableArray array];
    self.circleMargin = JINN_LOCK_INDICATOR_SIDE_LENGTH / 15;
}

- (void)createCircles
{
    for (int i = 0; i < 9; i++)
    {
        float x = self.circleMargin * (4.5 * (i % 3) + 1.5);
        float y = self.circleMargin * (4.5 * (i / 3) + 1.5);
        
        JinnLockCircle *circle = [[JinnLockCircle alloc] initWithDiameter:self.circleMargin * 3];
        [circle setTag:JINN_LOCK_INDICATOR_LEVEL_BASE + i];
        [circle setFrame:CGRectMake(x, y, self.circleMargin * 3, self.circleMargin * 3)];
        [self.circleArray addObject:circle];
        [self addSubview:circle];
    }
}

#pragma mark - Public

- (void)showPassword:(NSString *)password
{
    [self reset];
    
    NSMutableArray *numbers = [[NSMutableArray alloc] initWithCapacity:password.length];
    for (int i = 0; i < password.length; i++)
    {
        NSRange range = NSMakeRange(i, 1);
        NSString *numberStr = [password substringWithRange:range];
        NSNumber *number = [NSNumber numberWithInt:numberStr.intValue];
        [numbers addObject:number];
        [self.circleArray[number.intValue] updateCircleState:JinnLockCircleStateFill];
        [self.selectedCircleArray addObject:self.circleArray[number.intValue]];
    }
    
    [self setNeedsDisplay];
}

- (void)reset
{
    for (JinnLockCircle *circle in self.circleArray)
    {
        [circle updateCircleState:JinnLockCircleStateNormal];
    }
    
    [self.selectedCircleArray removeAllObjects];
}

#pragma mark - Draw

- (void)drawRect:(CGRect)rect
{
    if (self.selectedCircleArray.count == 0)
    {
        return;
    }
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, JINN_LOCK_INDICATOR_TRACK_WIDTH);
    [JINN_LOCK_COLOR_NORMAL set];
    
    CGPoint addLines[9];
    int count = 0;
    for (JinnLockCircle *circle in self.selectedCircleArray)
    {
        CGPoint point = CGPointMake(circle.center.x, circle.center.y);
        addLines[count++] = point;
    }
    
    CGContextAddLines(context, addLines, count);
    CGContextStrokePath(context);
}

@end
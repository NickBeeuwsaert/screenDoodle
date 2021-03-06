//
//  DoodleView.m
//  screenDoodle
//
//  Created by Nicholas Beeuwsaert on 4/6/12.
//  Copyright (c) 2012 Nicholas Beeuwsaert. All rights reserved.
//

#import "DoodleView.h"
#import <math.h>
@implementation DoodleView
@synthesize currentDoodle;
@synthesize bezierDoodles;
@synthesize doodles;
@synthesize currentColor;


- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}
- (void) mouseDown:(NSEvent *)theEvent {
    //currentDoodle = [NSMutableArray array];
}
- (void) mouseUp:(NSEvent *)theEvent {
    NSArray *copiedArray =[[NSArray alloc] initWithArray:currentDoodle copyItems: YES]; 
    //[doodles addObject:];
    if([currentDoodle count] > 2)
        [bezierDoodles addObject:[NSArray arrayWithObjects:currentColor, [DoodleView interpolateSplines:copiedArray], nil]];
    [currentDoodle  removeAllObjects];
    [self setNeedsDisplay:YES];
}
+ (NSArray*) getControlPoints:(NSPoint)p0 p1:(NSPoint)p1 p2: (NSPoint)p2 t:(float)t {
    //distances...
    float d01 = sqrtf(pow(p1.x - p0.x,2) + pow(p1.y - p0.y,2));
    float d12 = sqrtf(pow(p1.x - p2.x,2) + pow(p1.y - p2.y,2));
    if(d01 == 0){
        //NSLog(@"D01 is ZERO!");
        d01+=0.5;
    }
    if(d12 == 0){
        //NSLog(@"D12 is ZERO!");
        d12+=0.5;
    }
    //width, height
    float w = p2.x - p0.x;
    float h = p2.y - p0.y;
    
    float fa = t * d01/ (d01+d12);
    float fb = t * d12/ (d01+d12);
    NSValue *P1 = [NSValue valueWithPoint:NSMakePoint(p1.x - fa * w, p1.y - fa * h)];
    NSValue *P2 = [NSValue valueWithPoint:NSMakePoint(p1.x + fb * w, p1.y + fb * h)];
    NSValue *P3 = [NSValue valueWithPoint:p1];
    return [[NSArray arrayWithObjects:P1, P2, P3, nil] retain];
    
}
+ (NSArray*) interpolateSplines:(NSArray*)arr {
    NSMutableArray *ret = [[[NSMutableArray alloc] init] retain];
    [ret addObject:[arr objectAtIndex:0]];
    NSInteger i;
    for(i = 1; i < [arr count]-1; i++){
        NSPoint p0 = [[arr objectAtIndex:i-1] pointValue];
        NSPoint p1 = [[arr objectAtIndex:i] pointValue];
        NSPoint p2 = [[arr objectAtIndex:i+1] pointValue];
        
        [ret addObject:[DoodleView getControlPoints:p0 p1:p1 p2:p2 t:0.5f]];
    }
    NSPoint p0 = [[arr objectAtIndex:i-1] pointValue];
    NSPoint p1 = [[arr objectAtIndex:i] pointValue];
    
    [ret addObject:[DoodleView getControlPoints:p0 p1:p1 p2:p1 t:0.5f]];
    return ret;
}
- (void) mouseDragged:(NSEvent *)theEvent {
    if([NSEvent pressedMouseButtons] == 1<<0){
        [currentDoodle addObject: [NSValue valueWithPoint:[NSEvent mouseLocation]]];
        [self setNeedsDisplay:YES];
    }
}

- (void) awakeFromNib {
    doodles = [[[NSMutableArray alloc] init] retain];
    bezierDoodles = [[[NSMutableArray alloc] init]  retain];
    currentDoodle = [[[NSMutableArray alloc] init] retain];
    //currentColor = [[NSColor redColor] retain];
    currentColor = [[NSUnarchiver unarchiveObjectWithData:[[NSUserDefaults standardUserDefaults] dataForKey:@"CustomColor00"] ]retain];
    [[self window] setAcceptsMouseMovedEvents:YES];
}
- (void)drawRect:(NSRect)dirtyRect
{
    /*for(NSArray *d in doodles){
        NSBezierPath * p = [[NSBezierPath bezierPath] retain];
        [p setLineCapStyle:NSRoundLineCapStyle];
        
        for(NSValue *point in d){
            if([p isEmpty]){
                [p moveToPoint:[point pointValue]];
            }else{
                [p lineToPoint:[point pointValue]];
            }
        }
        [[NSColor whiteColor]set];
        [p setLineWidth:7];
        [p stroke];
        [[NSColor blueColor]set];
        [p setLineWidth:5];
        [p stroke];
        [p release];
    }*/
    // If there are no doodles tell the user how to exit, or something
    if([bezierDoodles count] == 0){
        NSBezierPath *exitNotification;
        NSMutableDictionary *attributes = [[NSMutableDictionary alloc] init];
        NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
        [style setAlignment:NSCenterTextAlignment];
        [attributes setObject:style forKey:NSParagraphStyleAttributeName];
        [attributes setObject:[NSColor whiteColor] forKey:NSForegroundColorAttributeName];
        [attributes setObject:[NSFont fontWithName:@"Helvetica Neue" size:12] forKey:NSFontAttributeName];
        NSString *exitMessage = @"Press\n\u2303 `\nto exit!";
        NSSize size = [exitMessage sizeWithAttributes:attributes];
        
        NSRect rect = NSMakeRect(dirtyRect.size.width-160, (dirtyRect.size.height-(size.height+20 + [[NSApp mainMenu] menuBarHeight])), 150, size.height+10);
        exitNotification = [[NSBezierPath alloc] init];
        [exitNotification appendBezierPathWithRoundedRect:rect xRadius:10 yRadius:10];
        NSColor *HUDColor = [NSColor colorWithSRGBRed:0.3 green:0.3 blue:0.3 alpha:0.8];
        [HUDColor setFill];
        
        [exitNotification fill];
        [exitMessage drawInRect:NSInsetRect(rect, 1.0, 1.0) withAttributes:attributes];
        [style release];
        [attributes release];
        //[asdf release];
        [exitNotification release];
    }
    //[p setLineCapStyle:NSRoundLineCapStyle];
    [NSBezierPath setDefaultLineCapStyle:NSRoundLineCapStyle];
    [NSBezierPath setDefaultLineJoinStyle:NSRoundLineJoinStyle];
    //begin drawing bezier doodles
    for(NSArray* D in bezierDoodles){
        NSBezierPath * p = [[NSBezierPath bezierPath] retain];
        //[p setLineCapStyle:NSRoundLineCapStyle];
        NSArray *d = [D objectAtIndex:1];
        for(NSInteger i = 0; i < [d count]-1; i++){
            if(/*[p isEmpty]*/ i==0){
                NSPoint p3 = [[d objectAtIndex:i]pointValue];
                [p moveToPoint:p3];
            }else{
             NSPoint p1 = [[[d objectAtIndex:i] objectAtIndex:1] pointValue];
                NSPoint p2 = [[[d objectAtIndex:i+1] objectAtIndex:0] pointValue];
                NSPoint p3 = [[[d objectAtIndex:i+1] objectAtIndex:2] pointValue];

                //NSLog(@"Oh! No! p1: %@ p2: %@ p3: %@", NSStringFromPoint(p1), 
                //      NSStringFromPoint(p2), 
                //      NSStringFromPoint(p3));
             [p curveToPoint:p3 controlPoint1:p1 controlPoint2:p2];
            }
        }
        
        [[NSColor whiteColor]set];
        [p setLineWidth:7];
        [p stroke];
        [(NSColor*)[D objectAtIndex:0] set];
        [p setLineWidth:5];
        [p stroke];
        [p release];
    }
    // Stop drawing bezier doodles
    NSBezierPath * p = [[NSBezierPath bezierPath] retain];
    for(NSValue *point in currentDoodle){
        if([p isEmpty]){
            [p moveToPoint:[point pointValue]];
        }else{
            [p lineToPoint:[point pointValue]];
        }
    }
    [[NSColor blackColor]set];
    [p setLineWidth:7];
    [p stroke];
    [(NSColor*)currentColor set];
    [p setLineWidth:5];
    [p stroke];
    [p release];
    
    [[self window] invalidateShadow];
}
@end

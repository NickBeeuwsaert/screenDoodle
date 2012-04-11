//
//  fullScreenWindow.m
//  screenDoodle
//
//  Created by Nicholas Beeuwsaert on 4/6/12.
//  Copyright (c) 2012 Nicholas Beeuwsaert. All rights reserved.
//

#import "fullScreenWindow.h"

@implementation fullScreenWindow
- (id)initWithContentRect:(NSRect)contentRect styleMask:(NSUInteger)aStyle backing:(NSBackingStoreType)bufferingType defer:(BOOL)flag {
        NSRect mainDisplayRect = [[NSScreen mainScreen] frame];
        self = [super initWithContentRect: mainDisplayRect styleMask:NSBorderlessWindowMask|NSNonactivatingPanelMask backing:NSBackingStoreBuffered defer:YES];
        if(self){
            //[self setLevel:NSMainMenuWindowLevel+1];
            [self setBackgroundColor:[NSColor clearColor]];
            //[self setAlphaValue:0.5];
            [self setOpaque:NO];
            [self setIgnoresMouseEvents:NO];
            //[self setFloatingPanel:YES];
            //[self setLevel:NSFloatingWindowLevel];
        }
        return self;
}
/* - (BOOL) isKeyWindow {
    return YES;
}*/
/* - (BOOL) isMainWindow {
    return NO;
}*/

@end

//
//  AppDelegate.m
//  screenDoodle
//
//  Created by Nicholas Beeuwsaert on 4/6/12.
//  Copyright (c) 2012 Nicholas Beeuwsaert. All rights reserved.
//

#import "AppDelegate.h"
#import "DDHotKeyCenter.h"
#import "DoodleView.h"

@implementation AppDelegate

@synthesize window = _window;
@synthesize statusItem;
@synthesize statusMenu;
@synthesize active;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"ApplePersistenceIgnoreState"];
    
    DDHotKeyCenter *hotkeyCenter = [[DDHotKeyCenter alloc]init];
    
    DDHotKeyTask activateColor0 = ^(NSEvent* event){
        [self setColorRed:nil];
    };
    DDHotKeyTask activateColor1 = ^(NSEvent* event){
        [self setColorGreen:nil];

    };
    DDHotKeyTask activateColor2 = ^(NSEvent* event){
        [self setColorBlue:nil];

    };
    DDHotKeyTask toggle = ^(NSEvent* event){
        [self toggleVisibility:nil];
    };
    DDHotKeyTask clear = ^(NSEvent* event){
        [self clearDoodles:nil];
    };
    [hotkeyCenter registerHotKeyWithKeyCode:18 modifierFlags:NSControlKeyMask task:activateColor0];
    [hotkeyCenter registerHotKeyWithKeyCode:19 modifierFlags:NSControlKeyMask task:activateColor1];
    [hotkeyCenter registerHotKeyWithKeyCode:20 modifierFlags:NSControlKeyMask task:activateColor2];
    [hotkeyCenter registerHotKeyWithKeyCode:50 modifierFlags:NSControlKeyMask task:toggle];
    [hotkeyCenter registerHotKeyWithKeyCode:0x1D modifierFlags:NSControlKeyMask task:clear];
    [hotkeyCenter release];
    [_window orderOut:nil];
}
- (void)bringToFront {
    [_window makeKeyAndOrderFront:nil];
    [_window setLevel:NSMainMenuWindowLevel+1];
    [self setActive:YES];
    
}
- (IBAction) toggleVisibility:(id)sender {
    if([self active]){
        [self sendToBack];
    }else{
        [self bringToFront];
        //[self bringToFront];
    }
}
- (void) sendToBack {
    [_window orderOut:nil];
    [self setActive:NO];
}
- (IBAction)clearDoodles:(id)sender {
    [[(DoodleView*)[_window contentView] doodles] removeAllObjects];
    [[(DoodleView*)[_window contentView] bezierDoodles] removeAllObjects];
    [[_window contentView] setNeedsDisplay:YES];
}
- (void) awakeFromNib {
    statusItem = [[[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength] retain];
    [statusItem setMenu:statusMenu];
    [statusItem setImage:
     [[NSImage alloc ]initByReferencingFile:[[NSBundle mainBundle] pathForResource:@"MenuExtra" ofType:@"png"]]];
    [statusItem setAlternateImage:
     [[NSImage alloc ]initByReferencingFile:[[NSBundle mainBundle] pathForResource:@"MenuExtra-alt" ofType:@"png"]]];
    [statusItem setHighlightMode:YES];
}
- (void)applicationWillTerminate:(NSNotification *)aNotification {
    [statusItem release];
}
- (IBAction) setColorRed:(id)sender {
    [[(DoodleView*)[_window contentView] currentColor] release];
    [(DoodleView*)[_window contentView] setCurrentColor:[NSColor redColor]];
}
- (IBAction) setColorBlue:(id)sender {
    [[(DoodleView*)[_window contentView] currentColor] release];
    [(DoodleView*)[_window contentView] setCurrentColor:[NSColor blueColor]];
}
- (IBAction) setColorGreen:(id)sender {
    [[(DoodleView*)[_window contentView] currentColor] release];
    [(DoodleView*)[_window contentView] setCurrentColor:[NSColor greenColor]];
}
@end
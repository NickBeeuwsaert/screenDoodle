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
- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"ApplePersistenceIgnoreState"];
    
    DDHotKeyCenter *hotkeyCenter = [[DDHotKeyCenter alloc]init];
    
    DDHotKeyTask activate = ^(NSEvent* event){
        [self bringToFront];
    };
    DDHotKeyTask hide = ^(NSEvent* event){
        [self sendToBack];
    };
    DDHotKeyTask clear = ^(NSEvent* event){
        [self clearDoodles];
    };
    [hotkeyCenter registerHotKeyWithKeyCode:18 modifierFlags:NSControlKeyMask task:activate];
    [hotkeyCenter registerHotKeyWithKeyCode:50 modifierFlags:NSControlKeyMask task:hide];
    [hotkeyCenter registerHotKeyWithKeyCode:0x1D modifierFlags:NSControlKeyMask task:clear];
    [hotkeyCenter release];
    [_window orderOut:nil];
}
- (void)bringToFront {
    [_window makeKeyAndOrderFront:nil];
    [_window setLevel:NSMainMenuWindowLevel+1];
    NSLog(@"asf");
    
}
- (void) sendToBack {
    [_window orderOut:nil];
}
- (void) clearDoodles {
    [[(DoodleView*)[_window contentView] doodles] removeAllObjects];
    [[(DoodleView*)[_window contentView] bezierDoodles] removeAllObjects];
    [[_window contentView] setNeedsDisplay:YES];
}
- (void) awakeFromNib {
    statusItem = [[[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength] retain];
    [statusItem setMenu:statusMenu];
    [statusItem setImage:
     [[NSImage alloc ]initByReferencingFile:[[NSBundle mainBundle] pathForResource:@"Untitled-1" ofType:@"png"]]];
    [statusItem setHighlightMode:YES];
}
- (void)applicationWillTerminate:(NSNotification *)aNotification {
    NSLog(@"Terminating!");
    [statusItem release];
}
- (IBAction)poo:(id)sender {
    NSLog(@"sadfASDFasdf");
}
@end
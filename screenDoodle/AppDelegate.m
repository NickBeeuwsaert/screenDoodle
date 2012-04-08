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

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"ApplePersistenceIgnoreState"];
    
    DDHotKeyCenter *hotkeyCenter = [[DDHotKeyCenter alloc]init];
    
    DDHotKeyTask activate = ^(NSEvent* event){
        [_window makeKeyAndOrderFront:nil];
        [_window setLevel:NSMainMenuWindowLevel+1];
    };
    DDHotKeyTask hide = ^(NSEvent* event){
        [_window orderOut:nil];
    };
    DDHotKeyTask clear = ^(NSEvent* event){
        [[(DoodleView*)[_window contentView] doodles] removeAllObjects];
        [[(DoodleView*)[_window contentView] bezierDoodles] removeAllObjects];
        [[_window contentView] setNeedsDisplay:YES];
    };
    [hotkeyCenter registerHotKeyWithKeyCode:18 modifierFlags:NSControlKeyMask task:activate];
    [hotkeyCenter registerHotKeyWithKeyCode:50 modifierFlags:NSControlKeyMask task:hide];
    [hotkeyCenter registerHotKeyWithKeyCode:0x1D modifierFlags:NSControlKeyMask task:clear];
    [hotkeyCenter release];
    [_window orderOut:nil];
} 
@end
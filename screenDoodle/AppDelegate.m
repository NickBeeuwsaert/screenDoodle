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
/*@synthesize statusItem;
@synthesize statusMenu;
@synthesize active;
@synthesize redMenu;
@synthesize blueMenu;
@synthesize greenMenu; */

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
 [[NSUserDefaults standardUserDefaults] registerDefaults:[NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Defaults" ofType:@"plist"]]];
    
}
- (id) init {
    self = [super init];
    
    if (self) {

    }
    return self;
}

@end
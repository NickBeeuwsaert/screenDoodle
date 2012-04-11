//
//  AppController.h
//  screenDoodle
//
//  Created by Nicholas Beeuwsaert on 4/8/12.
//  Copyright (c) 2012 Princeton High School. All rights reserved.
//

#import <Foundation/Foundation.h>
@class PrefController;
@interface AppController : NSObject
//Quite a lot :(

@property (assign) IBOutlet NSWindow * window;
@property (assign) IBOutlet NSMenu *statusMenu;
@property (assign) NSStatusItem *statusItem;
@property (assign) IBOutlet NSMenuItem *redMenu;
@property (assign) IBOutlet NSMenuItem *greenMenu;
@property (assign) IBOutlet NSMenuItem *blueMenu;
@property (assign) PrefController *prefController;
@property (strong) NSImage *extraImage;
@property (strong) NSImage *extraImageAlt;
@property (strong) NSImage *extraImageOn;

@property BOOL active;

@end

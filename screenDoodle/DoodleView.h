//
//  DoodleView.h
//  screenDoodle
//
//  Created by Nicholas Beeuwsaert on 4/6/12.
//  Copyright (c) 2012 Princeton High School. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface DoodleView : NSView
@property (assign) NSMutableArray* doodles;
@property (assign) NSMutableArray* bezierDoodles;
@property (assign) NSMutableArray* currentDoodle;
@end

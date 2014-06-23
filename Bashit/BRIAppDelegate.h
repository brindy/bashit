//
//  BRIAppDelegate.h
//  Bashit
//
//  Created by Christopher Brind on 23/06/2014.
//  Copyright (c) 2014 BrindySoft.com Ltd. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface BRIAppDelegate : NSObject <NSApplicationDelegate>

@property (assign) IBOutlet NSWindow *window;
@property (assign) IBOutlet NSTextView *logs;

-(IBAction)executeIt:(id)sender;


@end

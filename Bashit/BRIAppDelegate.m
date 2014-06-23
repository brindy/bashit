//
//  BRIAppDelegate.m
//  Bashit
//
//  Created by Christopher Brind on 23/06/2014.
//  Copyright (c) 2014 BrindySoft.com Ltd. All rights reserved.
//

#import "BRIAppDelegate.h"

@implementation BRIAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
}

-(void)executeIt:(id)sender
{
    
    NSString *script = [[NSBundle mainBundle] pathForResource:@"script" ofType:@"sh"];
    NSLog(@"%@", script);
    
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        [self reallyExecuteIt:script];
    });
    
}

// http://www.linuxquestions.org/questions/programming-9/how-to-execute-bash-script-in-c-701229/

#define LINE_BUFSIZE 128
-(void)reallyExecuteIt:(NSString *)script {
    const char *c = [script UTF8String];
    
    char line[LINE_BUFSIZE];
    int linenr;
    FILE *pipe;
    
    /* Get a pipe where the output from the scripts comes in */
    pipe = popen(c, "r");
    if (pipe == NULL) {  /* check for errors */
        NSLog(@"popen(%@)", script);
        return;        /* return with exit code indicating error */
    }
    [self appendToMyTextView:[NSString stringWithFormat:@"Executing %@\n\n", script]];
    
    /* Read script output from the pipe line by line */
    linenr = 1;
    while (fgets(line, LINE_BUFSIZE, pipe) != NULL) {
        // NSLog();
        [self appendToMyTextView:[NSString stringWithFormat:@"Script output line %d: %s\n", linenr, line]];
        ++linenr;
    }
    
    /* Once here, out of the loop, the script has ended. */
    int result = pclose(pipe); /* Close the pipe */
    [self appendToMyTextView:[NSString stringWithFormat:@"script result: %d\n\n", result]];
}

// http://stackoverflow.com/questions/15172971/append-to-nstextview-and-scroll
- (void)appendToMyTextView:(NSString*)text
{
    dispatch_async(dispatch_get_main_queue(), ^{
        NSAttributedString* attr = [[NSAttributedString alloc] initWithString:text];
        
        [[_logs textStorage] appendAttributedString:attr];
        [_logs scrollRangeToVisible:NSMakeRange([[_logs string] length], 0)];
    });
}


@end

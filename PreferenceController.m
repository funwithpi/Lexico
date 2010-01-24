//
//  PreferenceController.m
//  Lexico
//
//  Created by David Benjamin Jones on 1/24/10.
//  Copyright 2010 David Benjamin Jones. All rights reserved.
//

#import "PreferenceController.h"
NSString * const FWPEmptyDocKey = @"EmptyDocumentFlag";

@implementation PreferenceController

- (id)init
{
	NSLog(@"Initializing");
	if (![super initWithWindowNibName:@"Preferences"])
		return nil;
	return self;
}

- (BOOL)emptyDoc
{
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	return [defaults boolForKey:FWPEmptyDocKey];
}

- (void)windowDidLoad
{
	[newEmptyDoc setState:[self emptyDoc]];
}

- (IBAction)changeNewEmptyDoc:(id)sender
{
	int state = [newEmptyDoc state];
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	[defaults setBool:state
			   forKey:FWPEmptyDocKey];
}

@end

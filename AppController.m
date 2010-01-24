//
//  AppController.m
//  Lexico
//
//  Created by David Benjamin Jones on 1/24/10.
//  Copyright 2010 David Benjamin Jones. All rights reserved.
//

#import "AppController.h"
#import "PreferenceController.h"

@implementation AppController

+ (void)initialize
{
	NSMutableDictionary *defaultValues = [NSMutableDictionary dictionary];
	
	//Set default values
	[defaultValues setObject:[NSNumber numberWithBool:YES]
					  forKey:FWPEmptyDocKey];
	
	[[NSUserDefaults standardUserDefaults] registerDefaults:defaultValues];
	
	NSLog(@"The default values have been registered. These are thsoe which have been: %@", defaultValues);
}

- (BOOL)applicationShouldOpenUntitledFile:(NSApplication *)sender
{
	NSLog(@"Application should open untitled file");
	return [[NSUserDefaults standardUserDefaults]
			boolForKey:FWPEmptyDocKey];
}

-(IBAction)showPreferencePanel:(id)sender
{
	if (!preferenceController) {
		preferenceController = [[PreferenceController alloc] init];
	}
	NSLog(@"Showing %@", preferenceController);
	[preferenceController showWindow:self];
}

@end

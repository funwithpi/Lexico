//
//  AppController.m
//  Lexico
//
//  Created by David Benjamin Jones on 1/24/10.
//  Copyright 2010 David Benjamin Jones. All rights reserved.
//

#import "AppController.h"
#import "Constants.h"
#import "GeneralPreferenceViewController.h"
#import "AdvancedPreferenceViewController.h"
#import "UpdatePreferenceViewController.h"

#import "MBPreferencesController.h"

@implementation AppController

+ (void)initialize
{
	NSMutableDictionary *defaultValues = [NSMutableDictionary dictionary];
	
	//Set default values
	[defaultValues setObject:[NSNumber numberWithBool:YES]
					  forKey:FWPEmptyDocKey];
	[defaultValues setObject:[NSNumber numberWithBool:YES]
					  forKey:FWPBeginEditingOnEntryAddition];
	
	
	[[NSUserDefaults standardUserDefaults] registerDefaults:defaultValues];
	
	NSLog(@"The default values have been registered. These are thsoe which have been: %@", defaultValues);
}

- (void)awakeFromNib
{
	GeneralPreferenceViewController *general = [[GeneralPreferenceViewController alloc] initWithNibName:@"GeneralView" bundle:nil];
	UpdatePreferenceViewController *update = [[UpdatePreferenceViewController alloc] initWithNibName:@"UpdateView" bundle:nil];
	AdvancedPreferenceViewController *advanced = [[AdvancedPreferenceViewController alloc] initWithNibName:@"AdvancedView" bundle:nil];
	[[MBPreferencesController sharedController] setModules:[NSArray arrayWithObjects:general, update, advanced, nil]];
	[general release];
	[advanced release];
}


- (BOOL)applicationShouldOpenUntitledFile:(NSApplication *)sender
{
	NSLog(@"Application should open untitled file");
	return [[NSUserDefaults standardUserDefaults]
			boolForKey:FWPEmptyDocKey];
}

- (IBAction)showPreferencePanel:(id)sender
{
	[[MBPreferencesController sharedController] showWindow:sender];
}

- (void)dealloc
{
	[super dealloc];
}

@end

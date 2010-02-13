//
//  PreferencesViewController.m
//  Lexico
//
//  Created by David Benjamin Jones on 2/11/10.
//  Copyright 2010 David Benjamin Jones. All rights reserved.
//

#import "PreferenceViewController.h"


@implementation PreferenceViewController
@synthesize managedObjectContext;

- (void)dealloc
{
	[managedObjectContext release];
	[super dealloc];
}
@end

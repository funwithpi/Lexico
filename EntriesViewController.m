//
//  EntriesViewController.m
//  Lexico
//
//  Created by David Benjamin Jones on 1/17/10.
//  Copyright 2010 David Benjamin Jones. All rights reserved.
//

#import "EntriesViewController.h"


@implementation EntriesViewController

- (id)init
{
	if (![super initWithNibName:@"EntriesView"
						 bundle:nil]) {
		return nil;
	}
	[self setTitle:@"Entries"];
	return self;
	
}

- (IBAction)addEntry:(id)sender
{
	NSWindow *w = [entriesTable window];
	
	BOOL editingEnded = [w makeFirstResponder:w];
	if (!editingEnded) {
		NSLog(@"Unable to end editing");
		return;
	}
	
	NSManagedObject *e = [entriesController newObject];
	[entriesController addObject:e];
	[e release];
	
	[entriesController rearrangeObjects];
	
	NSArray *a = [entriesController arrangedObjects];
	
	int row = [a indexOfObjectIdenticalTo:e];
	
	[entriesTable editColumn:0
						 row:row
				   withEvent:nil
					  select:YES];
}

@end

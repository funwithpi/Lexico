//
//  MyDocument.m
//  Lexico
//
//  Created by David Benjamin Jones on 1/11/10.
//  Copyright David Benjamin Jones 2010 . All rights reserved.
//

#import "MyDocument.h"
#import "CSSViewController.h"
#import "EntriesViewController.h"
#import "FBMatterViewController.h"
#import "InfoViewController.h"

@implementation MyDocument

- (id)init 
{
    self = [super init];
    if (self != nil) {
		
		viewControllers = [[NSMutableArray alloc] init];
		
		ManagingViewController *vc;
		vc = [[CSSViewController alloc] init];
		[vc setManagedObjectContext:[self managedObjectContext]];
		[viewControllers addObject:vc];
		[vc release];
		
		vc = [[EntriesViewController alloc] init];
		[vc setManagedObjectContext:[self managedObjectContext]];
		[viewControllers addObject:vc];
		[vc release];
		
		vc = [[FBMatterViewController alloc] init];
		[vc setManagedObjectContext:[self managedObjectContext]];
		[viewControllers addObject:vc];
		[vc release];
		
		vc = [[InfoViewController alloc] init];
		[vc setManagedObjectContext:[self managedObjectContext]];
		[viewControllers addObject:vc];
		[vc release];
    }
    return self;
}

- (NSString *)windowNibName 
{
    return @"MyDocument";
}

- (void)windowControllerDidLoadNib:(NSWindowController *)windowController 
{
    [super windowControllerDidLoadNib:windowController];
	
	//Remove border used to see box in development
	[mainView setBorderType:NSNoBorder];
	
	NSManagedObjectContext *context = [self managedObjectContext];
	
	[self addEntityIfNotPresent:@"CSS" inManagedObjectContext:context];
	[self addEntityIfNotPresent:@"Info" inManagedObjectContext:context];
	
	//Set mainView to Entries tab
	[self displayViewController:[viewControllers objectAtIndex:1]];
	[viewControl setSelectedSegment:1];
}

- (void)displayViewController:(ManagingViewController *)vc
{
	NSWindow *w = [mainView window];
	BOOL ended  = [w makeFirstResponder:w];
	if (!ended) {
		NSBeep();
		return;
	}
	NSView *v = [vc view];
	
	NSSize currentSize		= [[mainView contentView] frame].size;
	NSSize newSize			= [v frame].size;
	float deltaWidth		= newSize.width - currentSize.width;
	float deltaHeight		= newSize.height - currentSize.height;
	NSRect windowFrame		= [w frame];
	windowFrame.size.height += deltaHeight;
	windowFrame.origin.y	-= deltaHeight;
	windowFrame.size.width	+= deltaWidth;
	
	[mainView setContentView:nil];
	
	[w setFrame:windowFrame
		display:YES
		animate:YES];
	
	[mainView setContentView:v];
	
	
}

- (IBAction)changeViewController:(id)sender
{
	int i = [viewControl selectedSegment];
	ManagingViewController *vc = [viewControllers objectAtIndex:i];
	[self displayViewController:vc];
}

- (NSUInteger)entitiesWithName:(NSString *)name
		inManagedObjectContext:(NSManagedObjectContext *)context
{
	NSFetchRequest *req = [[[NSFetchRequest alloc] init] autorelease];
	NSEntityDescription *entityDescription = [NSEntityDescription entityForName:name
											  inManagedObjectContext:context];
	[req setEntity:entityDescription];
		
	NSError *error;
	NSArray *results = [context executeFetchRequest:req
											  error:&error];
	
	return [results count];
}

- (BOOL)addEntityIfNotPresent:(NSString *)name
   inManagedObjectContext:(NSManagedObjectContext *)context
{
	[[context undoManager] disableUndoRegistration];
	int entity  = [self entitiesWithName:name
				  inManagedObjectContext:context];
	
	if (entity < 1) {
		[NSEntityDescription 
		 insertNewObjectForEntityForName:name 
		 inManagedObjectContext:context];
		NSLog(@"%@ created",name);
	}
	
	
	[context processPendingChanges];
	[[context undoManager] enableUndoRegistration];
	return YES;
}

- (IBAction)test:(id)sender
{
	NSLog(@"BEGIN TEST");

	NSLog(@"END TEST");
}


- (void)dealloc
{
	[viewControllers release];
	[super dealloc];
}

@end

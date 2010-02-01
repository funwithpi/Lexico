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
		
		NSManagedObjectContext *context = [self managedObjectContext];
		NSUndoManager *undoManager = [context undoManager];
		int i = 0;
		[undoManager disableUndoRegistration];
			if (i < 1) {
				NSEntityDescription *css = [NSEntityDescription 
									insertNewObjectForEntityForName:@"CSS" 
									inManagedObjectContext:context];
				NSLog(@"CSS created");
			}
		[context processPendingChanges];
		[undoManager enableUndoRegistration];
		
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
	
	//Compute new window size
	NSSize currentSize		= [[mainView contentView] frame].size;
	NSSize newSize			= [v frame].size;
	float deltaWidth		= newSize.width - currentSize.width;
	float deltaHeight		= newSize.height - currentSize.height;
	NSRect windowFrame		= [w frame];
	windowFrame.size.height += deltaHeight;
	windowFrame.origin.y	-= deltaHeight;
	windowFrame.size.width	+= deltaWidth;
	
	//Clear mainView, animate size change, set content of mainView
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

- (IBAction)test:(id)sender
{
	NSLog(@"BEGIN TEST");
	NSManagedObject *newEntry = [NSEntityDescription
									insertNewObjectForEntityForName:@"Entry"
									inManagedObjectContext:[self managedObjectContext]];
	NSLog(@"%@", newEntry);
	NSLog(@"END TEST");
}


- (void)dealloc
{
	[viewControllers release];
	[super dealloc];
}

@end

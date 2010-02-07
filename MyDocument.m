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

#pragma mark EntityMethods

- (int)countEntitiesWithName:(NSString *)name
		inManagedObjectContext:(NSManagedObjectContext *)context
{
	NSFetchRequest *req = [[NSFetchRequest alloc] init];
	NSEntityDescription *entityDescription = [NSEntityDescription entityForName:name
											  inManagedObjectContext:context];
	[req setEntity:entityDescription];
		
	NSError *error;
	NSArray *results = [context executeFetchRequest:req
											  error:&error];
	[req release];
	
	return [results count];
}

- (NSArray *)entitiesWithName:(NSString *)name
		inManagedObjectContext:(NSManagedObjectContext *)context
{
	NSFetchRequest *req = [[NSFetchRequest alloc] init];
	NSEntityDescription *entityDescription = [NSEntityDescription entityForName:name
														 inManagedObjectContext:context];
	[req setEntity:entityDescription];
	
	NSError *error;
	NSArray *results = [context executeFetchRequest:req
											  error:&error];
	[req release];
	
	return results;
}

- (BOOL)addEntityIfNotPresent:(NSString *)name
   inManagedObjectContext:(NSManagedObjectContext *)context
{
	[[context undoManager] disableUndoRegistration];
	int entity  = [self countEntitiesWithName:name
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

#pragma mark Exporting

- (IBAction)export:(id)sender
{
	NSOpenPanel *openPanel = [NSOpenPanel openPanel];
	[openPanel setPrompt:@"Export to Folder"];
	[openPanel setCanChooseFiles:NO];
	[openPanel setCanChooseDirectories:YES];
	[openPanel setAllowsMultipleSelection:NO];
	
	int i = [openPanel runModal];
	if (i == NSOKButton) {
		NSString *selectedDirectory = [[openPanel URLs] objectAtIndex:0];
		NSString *URLDestination = [NSString stringWithFormat:@"%@My Dictionary/",selectedDirectory];
		NSString *destination = [URLDestination stringByReplacingOccurrencesOfString:@"file://localhost"
																		  withString:@""];
		NSError *error;
		int i = [[NSFileManager defaultManager] createDirectoryAtPath:destination
										  withIntermediateDirectories:YES
														   attributes:nil
																error:&error];
		if (i == 0) {
			NSLog(@"Alert 1");
			[[NSAlert alertWithError:error] runModal];
		}
		else {
			[self writeCSSToPath:destination];
			[self writeEntriesToPath:destination];
		}

	}

}

- (BOOL)writeCSSToPath:(NSString *)path
{
	NSArray *entities = [self entitiesWithName:@"CSS"
						inManagedObjectContext:[self managedObjectContext]];
	NSManagedObject *css = [entities objectAtIndex:0];
	NSString *code = [css valueForKey:@"code"];
	NSError *error;
	int i = [code writeToFile:[NSString stringWithFormat:@"%@css.css",path]
		   atomically:YES
			 encoding:NSUTF8StringEncoding
				error:&error];
	if (i == 0) {
		[[NSAlert alertWithError:error] runModal];
	}
	return YES;
}

- (BOOL)writeEntriesToPath:(NSString *)path
{
	NSXMLElement *root = [[NSXMLElement alloc] initWithName:@"d:dictionary"];
	NSXMLNode *xmlns = [NSXMLNode attributeWithName:@"xmlns"
										stringValue:@"http://www.w3.org/1999/xhtml"];
	NSXMLNode *xmlnsd = [NSXMLNode attributeWithName:@"xmlns:d"
										 stringValue:@"http://www.apple.com/DTDs/DictionaryService-1.0.rng"];
	[root addAttribute:xmlns];
	[root addAttribute:xmlnsd];
	NSXMLDocument *doc = [[NSXMLDocument alloc] initWithRootElement:root];
	[root release];
	
	NSArray *entriesArray = [self entitiesWithName:@"Entry"
							inManagedObjectContext:[self managedObjectContext]];
	NSEnumerator *e = [entriesArray objectEnumerator];
	NSManagedObject *entry;
	int i = 0;
	
	while (entry = [e nextObject]){
		NSXMLElement *xmlEntry = [NSXMLElement elementWithName:@"d:entry"];
		NSXMLNode *title = [NSXMLNode attributeWithName:@"d:title"
											stringValue:[entry valueForKey:@"title"]];
		NSXMLNode *identification = [NSXMLNode attributeWithName:@"id"
													 stringValue:[NSString stringWithFormat:@"%i",i]];
		NSXMLNode *content = [NSXMLNode textWithStringValue:[entry valueForKey:@"content"]];
		i = i+1;
		[xmlEntry addAttribute:identification];
		[xmlEntry addAttribute:title];
		[xmlEntry addChild:content];
		[root addChild:xmlEntry];
	}
	
	NSString *xmlString = [[NSString alloc] initWithData:[doc XMLDataWithOptions:NSXMLNodePrettyPrint]
												encoding:NSUTF8StringEncoding];
	NSString *newFile = [self stringByReplacingXMLEscapedCharactersInString:xmlString];
	[newFile writeToFile:[NSString stringWithFormat:@"%@xml.xml",path]
			  atomically:YES
				encoding:NSUTF8StringEncoding
				   error:NULL];
	[xmlString release];
	[doc release];
	return YES;
}

- (NSString *)stringByReplacingXMLEscapedCharactersInString:(NSString *)string
{
	NSString *unescapedString = string;
	NSDictionary *dict;
	NSEnumerator *e = [[self escapedCharactersList] objectEnumerator];
	
	while (dict = [e nextObject]) {
		unescapedString = [unescapedString stringByReplacingOccurrencesOfString:[dict valueForKey:@"escapeSequence"]
																	 withString:[dict valueForKey:@"escapedCharacter"]];
	}
	
	return unescapedString;
}

- (NSArray *)escapedCharactersList
{
	NSString *XMLPath = [[NSBundle mainBundle] pathForResource:@"XMLEscapes"
														ofType:@"plist"];
	NSArray *escapedCharactersList = [NSArray arrayWithContentsOfFile:XMLPath];
	return escapedCharactersList;
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

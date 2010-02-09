//
//  MyDocument.h
//  Lexico
//
//  Created by David Benjamin Jones on 1/11/10.
//  Copyright David Benjamin Jones 2010 . All rights reserved.
//

#import <Cocoa/Cocoa.h>
@class ManagingViewController;

@interface MyDocument : NSPersistentDocument {
	IBOutlet NSBox *mainView;
	IBOutlet NSSegmentedControl *viewControl;
	NSMutableArray *viewControllers;
}

- (IBAction)changeViewController:(id)sender;
- (void)displayViewController:(ManagingViewController *)vc;

- (int)countEntitiesWithName:(NSString *)name
		inManagedObjectContext:(NSManagedObjectContext *)context;
- (NSArray *)entitiesWithName:(NSString *)name
			 inManagedObjectContext:(NSManagedObjectContext *)context;
- (BOOL)addEntityIfNotPresent:(NSString *)name
	   inManagedObjectContext:(NSManagedObjectContext *)context;

- (IBAction)export:(id)sender;
- (BOOL)writeCSSToPath:(NSURL *)path;
- (BOOL)writeEntriesToPath:(NSURL *)path;
- (NSXMLElement *)frontAndBackMatterAsXML;
- (NSString *)stringByReplacingXMLEscapedCharactersInString:(NSString *)string;
- (NSArray *)escapedCharactersList;

- (IBAction)test:(id)sender;

@end

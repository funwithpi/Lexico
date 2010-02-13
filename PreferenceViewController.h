//
//  PreferencesViewController.h
//  Lexico
//
//  Created by David Benjamin Jones on 2/11/10.
//  Copyright 2010 David Benjamin Jones. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface PreferenceViewController : NSViewController {
	NSManagedObjectContext *managedObjectContext;
}

@property (retain) NSManagedObjectContext *managedObjectContext;
@end

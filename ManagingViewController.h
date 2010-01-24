//
//  ManagingViewController.h
//  Lexico
//
//  Created by David Benjamin Jones on 1/17/10.
//  Copyright 2010 David Benjamin Jones. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface ManagingViewController : NSViewController {
	NSManagedObjectContext *managedObjectContext;
}
@property (retain) NSManagedObjectContext *managedObjectContext;
@end

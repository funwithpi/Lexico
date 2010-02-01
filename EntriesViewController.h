//
//  EntriesViewController.h
//  Lexico
//
//  Created by David Benjamin Jones on 1/17/10.
//  Copyright 2010 David Benjamin Jones. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "ManagingViewController.h"

@interface EntriesViewController : ManagingViewController {
	IBOutlet NSTableView *entriesTable;
	IBOutlet NSArrayController *entriesController;
}
- (IBAction)addEntry:(id)sender;

@end

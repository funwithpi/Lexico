//
//  PreferenceController.h
//  Lexico
//
//  Created by David Benjamin Jones on 1/24/10.
//  Copyright 2010 David Benjamin Jones. All rights reserved.
//

#import <Cocoa/Cocoa.h>
extern NSString * const FWPEmptyDocKey;

@interface PreferenceController : NSWindowController {
	IBOutlet NSButton *newEmptyDoc;
	
}
- (IBAction)changeNewEmptyDoc:(id)sender;
- (BOOL)emptyDoc;

@end

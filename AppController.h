//
//  AppController.h
//  Lexico
//
//  Created by David Benjamin Jones on 1/24/10.
//  Copyright 2010 David Benjamin Jones. All rights reserved.
//

#import <Cocoa/Cocoa.h>
@class PreferenceController;

@interface AppController : NSObject {
	PreferenceController *preferenceController;
}
- (IBAction)showPreferencePanel:(id)sender;

@end

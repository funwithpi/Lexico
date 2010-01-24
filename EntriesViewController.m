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

@end

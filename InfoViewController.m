//
//  InfoViewController.m
//  Lexico
//
//  Created by David Benjamin Jones on 1/18/10.
//  Copyright 2010 David Benjamin Jones. All rights reserved.
//

#import "InfoViewController.h"


@implementation InfoViewController

- (id)init
{
	if (![super initWithNibName:@"InfoView"
						 bundle:nil]) {
		return nil;
	}
	[self setTitle:@"Info"];
	return self;
}

@end

//
//  FBMatterViewController.m
//  Lexico
//
//  Created by David Benjamin Jones on 1/18/10.
//  Copyright 2010 David Benjamin Jones. All rights reserved.
//

#import "FBMatterViewController.h"


@implementation FBMatterViewController

- (id)init
{
	if (![super initWithNibName:@"FBMatterView"
						 bundle:nil]) {
		return nil;
	}
	[self setTitle:@"Front and Back Matter"];
	return self;
}

@end

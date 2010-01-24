//
//  CSSViewController.m
//  Lexico
//
//  Created by David Benjamin Jones on 1/17/10.
//  Copyright 2010 David Benjamin Jones. All rights reserved.
//

#import "CSSViewController.h"


@implementation CSSViewController

- (id)init
{
	if (![super initWithNibName:@"CSSView"
						 bundle:nil]) {
		return nil;
	}
	[self setTitle:@"CSS"];
	return self;
}

@end

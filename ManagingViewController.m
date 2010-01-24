//
//  ManagingViewController.m
//  Lexico
//
//  Created by David Benjamin Jones on 1/17/10.
//  Copyright 2010 David Benjamin Jones. All rights reserved.
//

#import "ManagingViewController.h"


@implementation ManagingViewController
@synthesize managedObjectContext;

- (void)dealloc
{
	[managedObjectContext release];
	[super dealloc];
}
@end

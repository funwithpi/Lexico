//
//  GeneralPreferenceViewController.m
//  Lexico
//
//  Created by David Benjamin Jones on 2/11/10.
//  Copyright 2010 David Benjamin Jones. All rights reserved.
//

#import "GeneralPreferenceViewController.h"


@implementation GeneralPreferenceViewController

- (NSString *)title
{
	return @"General";
}

- (NSString *)identifier
{
	return @"general";
}

- (NSImage *)image
{
	return [NSImage imageNamed:@"NSPreferencesGeneral"];
}


@end

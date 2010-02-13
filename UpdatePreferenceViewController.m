//
//  GeneralPreferenceViewController.m
//  Lexico
//
//  Created by David Benjamin Jones on 2/11/10.
//  Copyright 2010 David Benjamin Jones. All rights reserved.
//

#import "UpdatePreferenceViewController.h"


@implementation UpdatePreferenceViewController

- (NSString *)title
{
	return @"Updates";
}

- (NSString *)identifier
{
	return @"update";
}

- (NSImage *)image
{
	return [NSImage imageNamed:@"Sparkle.icns"];
}


@end

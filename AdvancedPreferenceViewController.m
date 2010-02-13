//
//  AdvancedPreferenceViewController.m
//  Lexico
//
//  Created by David Benjamin Jones on 2/11/10.
//  Copyright 2010 David Benjamin Jones. All rights reserved.
//

#import "AdvancedPreferenceViewController.h"


@implementation AdvancedPreferenceViewController

- (NSString *)title
{
	return @"Advanced";
}

- (NSString *)identifier
{
	return @"advanced";
}

- (NSImage *)image
{
	return [NSImage imageNamed:@"NSAdvanced"];
}

@end

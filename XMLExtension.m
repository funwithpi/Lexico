//
//  XMLExtension.m
//  Lexico
//
//  Created by David Benjamin Jones on 1/21/10.
//  Copyright 2010 David Benjamin Jones. All rights reserved.
//

#import "XMLExtension.h"


@implementation NSXMLNode (XMLExtension)

- (NSXMLNode *)childNamed:(NSString *)name
{
	NSEnumerator *e = [[self children] objectEnumerator];
	
	NSXMLNode *node;
	while (node = [e nextObject]) {
		if ([[node name] isEqualToString:name]) {
			return node;
		}
    }
	return nil;
}

- (NSArray *)childrenAsStrings
{
	NSMutableArray *ret = [[NSMutableArray arrayWithCapacity:[[self children] count]] retain];
	
	NSEnumerator *e = [[self children] objectEnumerator];
	NSXMLNode *node;
	while (node = [e nextObject]){
		[ret addObject:[node stringValue]];
	}
	return [ret autorelease];
}

@end

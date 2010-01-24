//
//  XMLExtension.h
//  Lexico
//
//  Created by David Benjamin Jones on 1/21/10.
//  Copyright 2010 David Benjamin Jones. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSXMLNode (XMLExtension) 

- (NSXMLNode *)childNamed:(NSString *)name;
- (NSArray *)childrenAsStrings;

@end

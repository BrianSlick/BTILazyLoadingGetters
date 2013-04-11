//
//  NSArray+BTIAdditions.m
//
//  Created by Brian Slick in Feb 2013.
//  Copyright (c) 2013 BriTer Ideas LLC. All rights reserved.
//

#import "NSArray+BTIAdditions.h"

@implementation NSArray (BTIAdditions)

- (id)firstObjectBTI
{
	//BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
	
	id objectToReturn = nil;
	
	if ([self count] > 0)
	{
		objectToReturn = [self objectAtIndex:0];
	}
	
	//BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
	return objectToReturn;
}

@end

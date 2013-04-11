//
//  BTILazyLoadingGetters.m
//  BTILazyLoadingGetters
//
//  Created by Brian Slick on 4/10/13.
//  Copyright (c) 2013 BriTer Ideas LLC. All rights reserved.
//

#import "BTILazyLoadingGetters.h"

#import "BTIStringProcessor.h"

@implementation BTILazyLoadingGetters

- (id)runWithInput:(id)input
		fromAction:(AMAction *)anAction
			 error:(NSDictionary **)errorInfo
{
	NSString *inputString = (NSString *)[input objectAtIndex:0];
	
	if (![inputString isKindOfClass:[NSString class]])
	{
		return input;
	}
	
	BTIStringProcessor *processor = [[BTIStringProcessor alloc] initWithInputString:inputString];
	
	return [processor outputString];
}

@end

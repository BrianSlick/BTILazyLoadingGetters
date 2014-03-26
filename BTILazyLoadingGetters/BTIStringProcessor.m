//
//  BTIStringProcessor.m
//  BTILazyLoadingGetters
//
//  Created by Brian Slick on 4/10/13.
//  Copyright (c) 2013 BriTer Ideas LLC. All rights reserved.
//

#import "BTIStringProcessor.h"

#import "NSString+BTIAdditions.h"
#import "NSArray+BTIAdditions.h"

@interface BTIStringProcessor ()

// Private Properties
@property (nonatomic, copy) NSString *originalString;
@property (nonatomic, strong) NSSet *classesToIgnore;

// Private Methods

@end

@implementation BTIStringProcessor

#pragma mark - Synthesized Properties


#pragma mark - Dealloc and Memory Management


#pragma mark - Custom Getters and Setters

- (NSSet *)classesToIgnore
{
	if (_classesToIgnore == nil)
	{
		// Use all caps, even though that's not technically accurate in each case.
		_classesToIgnore = [NSSet setWithObjects:@"ID", @"BOOL", @"INT", @"NSINTEGER", @"NSUINTEGER", @"FLOAT", @"CGFLOAT", @"CHAR", @"SHORT", @"LONG", @"DOUBLE", nil];
	}
	return _classesToIgnore;
}

#pragma mark - Initialization

- (instancetype)initWithInputString:(NSString *)input
{
	self = [super init];
	if (self)
	{
		[self setOriginalString:input];
	}
	return self;
}

#pragma mark - Misc Methods

- (NSString *)outputString
{
	NSString *string = [self originalString];
	
	NSArray *originalLines = [string componentsSeparatedByString:@"\n"];
	__block NSMutableArray *newLines = [NSMutableArray array];
	
	[originalLines enumerateObjectsUsingBlock:^(NSString *line, NSUInteger index, BOOL *stop) {
		
		NSString *lineWithoutWhitespace = [line stringByRemovingLeadingWhitespaceBTI];
		
		// Make sure this is a property declaration
		
		if (![lineWithoutWhitespace hasPrefix:@"@property"])
		{
			return;
		}
		
		// Determine if property is readonly for warning message later
		
		BOOL isReadonly = ([lineWithoutWhitespace rangeOfString:@"readonly"].location != NSNotFound);
		
		// Split the line against a semicolon, to remove anything after one
		
		NSArray *commentComponents = [lineWithoutWhitespace componentsSeparatedByString:@";"];
		
		NSMutableString *propertyLine = [NSMutableString stringWithString:[commentComponents firstObjectBTI]];
		
		// Remove any protocol declarations
		
		[propertyLine replaceOccurrencesOfString:@"<[^>]*>" withString:@"" options:NSRegularExpressionSearch range:NSMakeRange(0, [propertyLine length])];
		
		// Remove the *
		
		[propertyLine replaceOccurrencesOfString:@"*" withString:@"" options:NSLiteralSearch range:NSMakeRange(0, [propertyLine length])];
		
		// Replace multiple spaces with single spaces
		
		[propertyLine replaceOccurrencesOfString:@"\\s+" withString:@" " options:NSRegularExpressionSearch range:NSMakeRange(0, [propertyLine length])];
				
		// Split the line against whitespace to access property components
		
		NSArray *propertyComponents = [propertyLine componentsSeparatedByString:@" "];
		
		NSInteger numberOfComponents = [propertyComponents count];
		
		// Variable name is last, class name is next to last.
		
		NSString *nameOfClass = [propertyComponents objectAtIndex:numberOfComponents - 2];
		NSString *variableName = [propertyComponents objectAtIndex:numberOfComponents - 1];
		
		if ([[self classesToIgnore] containsObject:[nameOfClass uppercaseString]])
		{
			return;
		}
		
		// Make the getter
		
		// Sample of desired output:
//		- (NSMutableArray *)mainContents
//		{
//			if (_mainContents == nil)
//			{
//				_mainContents = [[NSMutableArray alloc] init];
//			}
//			return _mainContents;
//		}
		
		[newLines addObject:[NSString stringWithFormat:@"- (%@ *)%@", nameOfClass, variableName]];
		[newLines addObject:@"{"];
		[newLines addObject:[NSString stringWithFormat:@"    if (_%@ == nil)", variableName]];
		[newLines addObject:@"    {"];
		if (isReadonly)
		{
			[newLines addObject:@"#warning Instance variables for readonly properties must be explicitly defined"];
		}
		[newLines addObject:[NSString stringWithFormat:@"        _%@ = [[%@ alloc] init];", variableName, nameOfClass]];
		[newLines addObject:@"    }"];
		[newLines addObject:[NSString stringWithFormat:@"    return _%@;", variableName]];
		[newLines addObject:@"}"];
		[newLines addObject:@""];
		
	}];
	
	// Remove final blank line
	
	NSString *lastEntry = [newLines lastObject];
	if ([lastEntry length] == 0)
	{
		[newLines removeLastObject];
	}
	
	NSString *returnString = [newLines componentsJoinedByString:@"\n"];
	
	return returnString;
}

@end

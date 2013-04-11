//
//  BTITestLazyLoadingGettersTests.m
//  BTITestLazyLoadingGettersTests
//
//  Created by Brian Slick on 4/10/13.
//  Copyright (c) 2013 BriTer Ideas LLC. All rights reserved.
//

#import "BTITestLazyLoadingGettersTests.h"

#import "BTIStringProcessor.h"

@implementation BTITestLazyLoadingGettersTests

- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

- (void)testSingleProperty
{
	NSURL *inputURL = [[NSBundle mainBundle] URLForResource:@"test1input-SingleProperty" withExtension:@"txt"];
	NSURL *outputURL = [[NSBundle mainBundle] URLForResource:@"test1output" withExtension:@"txt"];
	
	NSString *inputString = [[NSString alloc] initWithContentsOfURL:inputURL encoding:NSUTF8StringEncoding error:nil];
	NSString *outputStringReference = [[NSString alloc] initWithContentsOfURL:outputURL encoding:NSUTF8StringEncoding error:nil];
	
	BTIStringProcessor *processor = [[BTIStringProcessor alloc] initWithInputString:inputString];
	NSString *outputString = [processor outputString];

	STAssertEqualObjects(outputString, outputStringReference, @"A lazy-loading getter should have been generated");
}

- (void)testSingleReadonlyProperty
{
	NSURL *inputURL = [[NSBundle mainBundle] URLForResource:@"test2input-SingleReadonlyProperty" withExtension:@"txt"];
	NSURL *outputURL = [[NSBundle mainBundle] URLForResource:@"test2output" withExtension:@"txt"];
	
	NSString *inputString = [[NSString alloc] initWithContentsOfURL:inputURL encoding:NSUTF8StringEncoding error:nil];
	NSString *outputStringReference = [[NSString alloc] initWithContentsOfURL:outputURL encoding:NSUTF8StringEncoding error:nil];
	
	BTIStringProcessor *processor = [[BTIStringProcessor alloc] initWithInputString:inputString];
	NSString *outputString = [processor outputString];
	
	STAssertEqualObjects(outputString, outputStringReference, @"A lazy-loading getter should have been generated, along with a compiler warning statement");
}

- (void)testSinglePrimitiveProperty
{
	NSURL *inputURL = [[NSBundle mainBundle] URLForResource:@"test3input-SinglePrimitiveProperty" withExtension:@"txt"];
	NSURL *outputURL = [[NSBundle mainBundle] URLForResource:@"test3output" withExtension:@"txt"];
	
	NSString *inputString = [[NSString alloc] initWithContentsOfURL:inputURL encoding:NSUTF8StringEncoding error:nil];
	NSString *outputStringReference = [[NSString alloc] initWithContentsOfURL:outputURL encoding:NSUTF8StringEncoding error:nil];
	
	BTIStringProcessor *processor = [[BTIStringProcessor alloc] initWithInputString:inputString];
	NSString *outputString = [processor outputString];
	
	STAssertEqualObjects(outputString, outputStringReference, @"A single primitive property should be ignored, so there should be an empty string output");
}

- (void)testSinglePropertyWhileIgnoringComments
{
	NSURL *inputURL = [[NSBundle mainBundle] URLForResource:@"test4input-SinglePropertyWithComments" withExtension:@"txt"];
	NSURL *outputURL = [[NSBundle mainBundle] URLForResource:@"test4output" withExtension:@"txt"];
	
	NSString *inputString = [[NSString alloc] initWithContentsOfURL:inputURL encoding:NSUTF8StringEncoding error:nil];
	NSString *outputStringReference = [[NSString alloc] initWithContentsOfURL:outputURL encoding:NSUTF8StringEncoding error:nil];
	
	BTIStringProcessor *processor = [[BTIStringProcessor alloc] initWithInputString:inputString];
	NSString *outputString = [processor outputString];
	
	STAssertEqualObjects(outputString, outputStringReference, @"Comments should be ignored when creating setters");
}

- (void)testPropertiesWithAlternatePointerStyles
{
	NSURL *inputURL = [[NSBundle mainBundle] URLForResource:@"test5input-PropertiesWithAlternatePointerStyles" withExtension:@"txt"];
	NSURL *outputURL = [[NSBundle mainBundle] URLForResource:@"test5output" withExtension:@"txt"];
	
	NSString *inputString = [[NSString alloc] initWithContentsOfURL:inputURL encoding:NSUTF8StringEncoding error:nil];
	NSString *outputStringReference = [[NSString alloc] initWithContentsOfURL:outputURL encoding:NSUTF8StringEncoding error:nil];
	
	BTIStringProcessor *processor = [[BTIStringProcessor alloc] initWithInputString:inputString];
	NSString *outputString = [processor outputString];
	
	STAssertEqualObjects(outputString, outputStringReference, @"Getters should be created regardless of * location");
}

- (void)testMixedMultipleProperties
{
	NSURL *inputURL = [[NSBundle mainBundle] URLForResource:@"test6input-MixedMultipleProperties" withExtension:@"txt"];
	NSURL *outputURL = [[NSBundle mainBundle] URLForResource:@"test6output" withExtension:@"txt"];
	
	NSString *inputString = [[NSString alloc] initWithContentsOfURL:inputURL encoding:NSUTF8StringEncoding error:nil];
	NSString *outputStringReference = [[NSString alloc] initWithContentsOfURL:outputURL encoding:NSUTF8StringEncoding error:nil];
	
	BTIStringProcessor *processor = [[BTIStringProcessor alloc] initWithInputString:inputString];
	NSString *outputString = [processor outputString];
	
	STAssertEqualObjects(outputString, outputStringReference, @"Getters should be created for each property, warning for readonly, ignoring primitives");
}

- (void)testPropertiesWithProtocols
{
	NSURL *inputURL = [[NSBundle mainBundle] URLForResource:@"test7input-PropertiesWithProtocols" withExtension:@"txt"];
	NSURL *outputURL = [[NSBundle mainBundle] URLForResource:@"test7output" withExtension:@"txt"];
	
	NSString *inputString = [[NSString alloc] initWithContentsOfURL:inputURL encoding:NSUTF8StringEncoding error:nil];
	NSString *outputStringReference = [[NSString alloc] initWithContentsOfURL:outputURL encoding:NSUTF8StringEncoding error:nil];
	
	BTIStringProcessor *processor = [[BTIStringProcessor alloc] initWithInputString:inputString];
	NSString *outputString = [processor outputString];
	
	STAssertEqualObjects(outputString, outputStringReference, @"Protocols should be ignored when creating setters");
}

@end

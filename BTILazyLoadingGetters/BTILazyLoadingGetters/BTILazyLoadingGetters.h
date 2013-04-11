//
//  BTILazyLoadingGetters.h
//  BTILazyLoadingGetters
//
//  Created by Brian Slick on 4/10/13.
//  Copyright (c) 2013 BriTer Ideas LLC. All rights reserved.
//

#import <Automator/AMBundleAction.h>

@interface BTILazyLoadingGetters : AMBundleAction

- (id)runWithInput:(id)input fromAction:(AMAction *)anAction error:(NSDictionary **)errorInfo;

@end

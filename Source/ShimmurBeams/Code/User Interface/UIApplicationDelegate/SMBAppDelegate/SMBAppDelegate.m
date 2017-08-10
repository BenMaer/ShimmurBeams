//
//  SMBAppDelegate.m
//  ShimmurBeams
//
//  Created by Benjamin Maer on 8/3/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#import "SMBAppDelegate.h"
#import "SMBGameLevelGeneratorSetsNavigationController.h"

#import <ResplendentUtilities/RUConditionalReturn.h>





@interface SMBAppDelegate ()

@end





@implementation SMBAppDelegate

#pragma mark - UIApplicationDelegate
-(BOOL)application:(nonnull UIApplication*)application didFinishLaunchingWithOptions:(nullable NSDictionary*)launchOptions
{
	UIWindow* const window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
	[window setBackgroundColor:[UIColor redColor]];
	[window setRootViewController:[SMBGameLevelGeneratorSetsNavigationController new]];

	[self setWindow:window];

	return YES;
}

#pragma mark - window
-(void)setWindow:(nullable UIWindow*)window
{
	kRUConditionalReturn(self.window == window, NO);

	_window = window;

	if (self.window)
	{
		[self.window makeKeyAndVisible];
	}
}

@end

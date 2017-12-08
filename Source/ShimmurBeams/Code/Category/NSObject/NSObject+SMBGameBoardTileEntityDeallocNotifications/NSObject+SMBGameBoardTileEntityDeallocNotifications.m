//
//  NSObject+SMBGameBoardTileEntityDeallocNotifications.m
//  ShimmurBeams
//
//  Created by Benjamin Maer on 11/7/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#import "NSObject+SMBGameBoardTileEntityDeallocNotifications.h"

#import <ResplendentUtilities/NSString+RUMacros.h>
#import <ResplendentUtilities/RUConditionalReturn.h>





#warning Should be done with a macro after doing https://app.asana.com/0/37488452886436/473587103173549
NSString* const NSObject_SMBGameBoardTileEntityDeallocNotification__NotificationName__didCallDealloc = @"NSObject_SMBGameBoardTileEntityDeallocNotification__NotificationName__didCallDealloc";





@implementation NSObject (SMBGameBoardTileEntityDeallocNotifications)

#pragma mark - register
-(void)setRegisteredFor_SMBGameBoardTileEntityDeallocNotification_didCallDeallocOnWithNotificationSelector:(nonnull SEL)notificationSelector notificationObject:(nullable id)notificationObject
{
	kRUConditionalReturn(notificationSelector == nil, YES);

	[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:notificationSelector
												 name:NSObject_SMBGameBoardTileEntityDeallocNotification__NotificationName__didCallDealloc
											   object:notificationObject];
}

#pragma mark - clear
-(void)clearRegisteredFor_SMBGameBoardTileEntityDeallocNotification_didCallDealloc_with_notificationObject:(nullable id)notificationObject
{
	[[NSNotificationCenter defaultCenter] removeObserver:self
													name:NSObject_SMBGameBoardTileEntityDeallocNotification__NotificationName__didCallDealloc
												  object:notificationObject];
}

@end

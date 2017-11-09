//
//  NSObject+SMBGameBoardTileEntityDeallocNotifications.h
//  ShimmurBeams
//
//  Created by Benjamin Maer on 11/7/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#import "SMBNotificationCenterSynthesizations.h"

#import <Foundation/Foundation.h>





extern NSString* _Nonnull const NSObject_SMBGameBoardTileEntityDeallocNotification__NotificationName__didCallDealloc;





@interface NSObject (SMBGameBoardTileEntityDeallocNotifications)

#pragma mark - register
-(void)setRegisteredFor_SMBGameBoardTileEntityDeallocNotification_didCallDeallocOnWithNotificationSelector:(nonnull SEL)notificationSelector notificationObject:(nullable id)notificationObject;

#pragma mark - clear
-(void)clearRegisteredFor_SMBGameBoardTileEntityDeallocNotification_didCallDealloc_with_notificationObject:(nullable id)notificationObject;

@end

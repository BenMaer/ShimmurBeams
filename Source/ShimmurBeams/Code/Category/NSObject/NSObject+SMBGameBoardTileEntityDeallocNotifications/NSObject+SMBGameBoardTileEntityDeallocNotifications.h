//
//  NSObject+SMBGameBoardTileEntityDeallocNotifications.h
//  ShimmurBeams
//
//  Created by Benjamin Maer on 11/7/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#import "SMBNotificationCenterSynthesizations.h"

#import <Foundation/Foundation.h>

//#import <ResplendentUtilities/RUNotifications.h>





extern NSString* _Nonnull const NSObject_SMBGameBoardTileEntityDeallocNotification__NotificationName__didCallDealloc;





@interface NSObject (SMBGameBoardTileEntityDeallocNotifications)

#warning Let's use `RUNotifications.h` again once it's been updated with this asana todo: https://app.asana.com/0/37488452886436/473593202309309
kSMBNotificationCenterSynthesizations_Synthesize_NotificationReadonlySetWithSelectorClearProperty(r,R,egisteredFor_SMBGameBoardTileEntityDeallocNotification_didCallDealloc);
//kRUNotifications_Synthesize_NotificationReadonlySetWithSelectorClearProperty(r,R,egisteredFor_SMBGameBoardTileEntityDeallocNotification_didCallDealloc)

@end

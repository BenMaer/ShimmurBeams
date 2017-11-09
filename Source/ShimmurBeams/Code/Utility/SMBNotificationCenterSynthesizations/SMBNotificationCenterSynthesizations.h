//
//  SMBNotificationCenterSynthesizations.h
//  ShimmurBeams
//
//  Created by Benjamin Maer on 11/7/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#ifndef SMBNotificationCenterSynthesizations_h
#define SMBNotificationCenterSynthesizations_h

#import <Foundation/Foundation.h>

#import <ResplendentUtilities/RUSynthesizeAssociatedObjects.h>
#import <ResplendentUtilities/NSString+RUMacros.h>





#warning Made this updated version of this code, but no longer using it. We can delete this file once we move the new code to the library via asana todo: https://app.asana.com/0/37488452886436/473593202309309





#define kSMBNotificationCenterSynthesizations_synthesize_setterMethod_declaration(V,arName) \
-(void)set##V##arName##OnWithNotificationSelector:(nonnull SEL)notificationSelector notificationObject:(nullable id)notificationObject

#define kSMBNotificationCenterSynthesizations_synthesize_clearMethod_declaration(V,arName) \
-(void)clear##V##arName##_with_notificationObject:(nullable id)notificationObject

#define kSMBNotificationCenterSynthesizations_Synthesize_NotificationReadonlySetWithSelectorClearProperty(v,V,arName) \
@property (nonatomic, readonly) BOOL v##arName; \
kSMBNotificationCenterSynthesizations_synthesize_setterMethod_declaration(V,arName); \
kSMBNotificationCenterSynthesizations_synthesize_clearMethod_declaration(V,arName);

#define kSMBNotificationCenterSynthesizations_Synthesize_NotificationGetterSetterNumberFromPrimative_Implementation(v,V,arName,constVoidKey,notificationName) \
kSMBNotificationCenterSynthesizations_synthesize_setterMethod_declaration(V,arName); \
{ \
if ([self v##arName] == YES) \
return; \
[self set##V##arName:YES]; \
[[NSNotificationCenter defaultCenter]addObserver:self selector:notificationSelector name:notificationName object:notificationObject]; \
} \
kSMBNotificationCenterSynthesizations_synthesize_clearMethod_declaration(V,arName); \
{ \
if ([self v##arName] == NO) \
return;\
[self set##V##arName:NO]; \
[[NSNotificationCenter defaultCenter]removeObserver:self name:notificationName object:notificationObject]; \
\
} \
RU_Synthesize_AssociatedObject_GetterSetterNumberFromPrimative_Implementation(v, V, arName, BOOL, boolValue, constVoidKey, OBJC_ASSOCIATION_RETAIN_NONATOMIC);

#define kSMBNotificationCenterSynthesizations_Synthesize_AssociatedKey(notificationName) kRU__NotificationAssociatedKey##notificationName

/**
 @description
 Synthesizes the setter and getter method implementations, and synthesizes an associated key to be used.
 
 Unfortunately, I can't figure out how to make the associated keys unique to the file name, so all synthesizations for any given name v/Varname should be done only once, for example a category on NSObject (e.g. `NSObject+RUKeyboardNotifications`).
 */
#define kSMBNotificationCenterSynthesizations_Synthesize_NotificationGetterSetterNumberFromPrimative_Implementation_AssociatedKey(v,V,arName,notificationName) \
kRUDefineNSStringConstant(kSMBNotificationCenterSynthesizations_Synthesize_AssociatedKey(notificationName)); \
kSMBNotificationCenterSynthesizations_Synthesize_NotificationGetterSetterNumberFromPrimative_Implementation(v,V,arName,&kSMBNotificationCenterSynthesizations_Synthesize_AssociatedKey(notificationName),notificationName)





#endif /* SMBNotificationCenterSynthesizations_h */

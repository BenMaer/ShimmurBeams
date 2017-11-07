//
//  SMBWeakPointerObject.h
//  ShimmurBeams
//
//  Created by Benjamin Maer on 11/7/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#import <Foundation/Foundation.h>

#warning !!Should only have to import blocks.
#import <ResplendentUtilities/RUDeallocHook.h>





@interface SMBWeakPointerObject
<ObjectType>
: NSObject

#pragma mark - object
@property (nonatomic, readonly, weak, nullable) ObjectType object;

#pragma mark - init
-(nullable instancetype)init_with_object:(nonnull ObjectType)object
							deallocBlock:(nullable RUDeallocHookBlock)deallocBlock NS_DESIGNATED_INITIALIZER;

@end

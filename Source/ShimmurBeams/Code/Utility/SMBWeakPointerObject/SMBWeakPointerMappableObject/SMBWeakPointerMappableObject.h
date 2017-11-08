//
//  SMBWeakPointerMappableObject.h
//  ShimmurBeams
//
//  Created by Benjamin Maer on 11/7/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#import "SMBMappedDataCollection_MappableObject.h"

#import "SMBWeakPointerObject.h"





@interface SMBWeakPointerMappableObject<ObjectType> : SMBWeakPointerObject <SMBMappedDataCollection_MappableObject>

#pragma mark - object
-(nonnull ObjectType /**<SMBMappedDataCollection_MappableObject> */)object;

#pragma mark - init
-(nullable instancetype)init_with_object:(nonnull ObjectType<SMBMappedDataCollection_MappableObject>)object
							deallocBlock:(nullable RUDeallocHookBlock)deallocBlock NS_DESIGNATED_INITIALIZER;

@end

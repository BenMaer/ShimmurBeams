//
//  SMBWeakPointerMappableObject.m
//  ShimmurBeams
//
//  Created by Benjamin Maer on 11/7/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#import "SMBWeakPointerMappableObject.h"

#import <ResplendentUtilities/RUConstants.h>
#import <ResplendentUtilities/RUProtocolOrNil.h>
#import <ResplendentUtilities/RUConditionalReturn.h>





@implementation SMBWeakPointerMappableObject

#pragma mark - init
-(nullable instancetype)init_with_object:(nonnull id<SMBMappedDataCollection_MappableObject>)object
							deallocBlock:(nullable RUDeallocHookBlock)deallocBlock
{
	kRUConditionalReturn_ReturnValueNil(object == nil, YES);
	kRUConditionalReturn_ReturnValueNil(kRUProtocolOrNil(object, SMBMappedDataCollection_MappableObject) == nil, YES);

	return [super init_with_object:object deallocBlock:deallocBlock];
}

#pragma mark - SMBMappedDataCollection_MappableObject
-(nonnull NSString*)smb_uniqueKey
{
	id<SMBMappedDataCollection_MappableObject> const object = self.object;
	if (object == nil)
	{
		@throw [NSException exceptionWithName:NSInternalInconsistencyException
									   reason:@"must have a non nil object."
									 userInfo:nil];
	}

	return [object smb_uniqueKey];
}

#pragma mark - object
-(nonnull id /**<SMBMappedDataCollection_MappableObject> */)object
{
	return [super object];
}

@end

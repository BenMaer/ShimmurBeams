//
//  SMBWeakPointerObject.m
//  ShimmurBeams
//
//  Created by Benjamin Maer on 11/7/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#import "SMBWeakPointerObject.h"

#import <ResplendentUtilities/RUConditionalReturn.h>
#import <ResplendentUtilities/RUSynthesizeAssociatedObjects.h>
#import <ResplendentUtilities/NSString+RUMacros.h>





@interface SMBWeakPointerObject ()

#pragma mark - object
@property (nonatomic, weak, nullable) id object;

@end





kRUDefineNSStringConstant(kSMBWeakPointerObject_SMBWeakPointerObject_DeallocHook__AssociatedObjectKey__deallocHook)





@interface NSObject (SMBWeakPointerObject_DeallocHook)

#pragma mark - deallocHook
@property (nonatomic, strong, nullable) RUDeallocHook* SMBGameBoardTileEntitySpawner_DeallocHook__deallocHook;

@end





@implementation SMBWeakPointerObject

#pragma mark - NSObject
-(instancetype)init
{
	kRUConditionalReturn_ReturnValueNil(YES, YES);
	
#if __has_feature(nullability)
#pragma clang diagnostic push
#pragma GCC diagnostic ignored "-Wnullability-completeness"
#endif
	return [self init_with_object:nil
					 deallocBlock:nil];
#if __has_feature(nullability)
#pragma clang diagnostic pop
#endif
}

#pragma mark - init
-(nullable instancetype)init_with_object:(nonnull id)object
							deallocBlock:(nullable RUDeallocHookBlock)deallocBlock
{
	kRUConditionalReturn_ReturnValueNil(object == nil, YES);

	if (self = [super init])
	{
		[self setObject:object];

		if (deallocBlock)
		{
			[self.object setSMBGameBoardTileEntitySpawner_DeallocHook__deallocHook:
			 [[RUDeallocHook alloc] initWithBlock:deallocBlock]];
		}
	}
	
	return self;
}

@end





@implementation NSObject (SMBWeakPointerObject_DeallocHook)

#pragma mark - deallocHook
RU_Synthesize_AssociatedObject_GetterSetter_Implementation(, , SMBGameBoardTileEntitySpawner_DeallocHook__deallocHook, RUDeallocHook*, &kSMBWeakPointerObject_SMBWeakPointerObject_DeallocHook__AssociatedObjectKey__deallocHook, OBJC_ASSOCIATION_RETAIN_NONATOMIC);

@end

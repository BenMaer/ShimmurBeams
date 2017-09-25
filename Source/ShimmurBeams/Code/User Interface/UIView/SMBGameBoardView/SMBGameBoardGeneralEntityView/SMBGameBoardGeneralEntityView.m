//
//  SMBGameBoardGeneralEntityView.m
//  ShimmurBeams
//
//  Created by Benjamin Maer on 8/11/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#import "SMBGameBoardGeneralEntityView.h"
#import "SMBGameBoardGeneralEntity.h"

#import <ResplendentUtilities/RUConditionalReturn.h>
#import <ResplendentUtilities/RUClassOrNilUtil.h>





@implementation SMBGameBoardGeneralEntityView

#pragma mark - SMBDrawableObjectView: init
-(nullable instancetype)init_with_drawableObject:(nonnull SMBDrawableObject*)drawableObject
{
	kRUConditionalReturn_ReturnValueNil(YES, YES);

#if __has_feature(nullability)
#pragma clang diagnostic push
#pragma GCC diagnostic ignored "-Wnullability-completeness"
#endif
	return [self init_with_gameBoardGeneralEntity:nil];
#if __has_feature(nullability)
#pragma clang diagnostic pop
#endif
}

#pragma mark - init
-(nullable instancetype)init_with_gameBoardGeneralEntity:(nonnull SMBGameBoardGeneralEntity*)gameBoardGeneralEntity
{
	kRUConditionalReturn_ReturnValueNil(gameBoardGeneralEntity == nil, YES);

	if (self = [super init_with_drawableObject:gameBoardGeneralEntity])
	{
		kRUConditionalReturn_ReturnValueNil([self gameBoardGeneralEntity] == nil, YES);
	}

	return self;
}

#pragma mark - SMBMappedDataCollection_MappableObject
-(nonnull NSString*)smb_uniqueKey
{
	return [self.gameBoardGeneralEntity smb_uniqueKey];
}

#pragma mark - gameBoardGeneralEntity
-(nullable SMBGameBoardGeneralEntity*)gameBoardGeneralEntity
{
	SMBDrawableObject* const drawableObject = self.drawableObject;
	kRUConditionalReturn_ReturnValueNil(drawableObject == nil, NO);

	return kRUClassOrNil(drawableObject, SMBGameBoardGeneralEntity);
}

@end

//
//  SMBGameBoardGeneralEntity.m
//  ShimmurBeams
//
//  Created by Benjamin Maer on 8/7/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#import "SMBGameBoardGeneralEntity.h"
#import "SMBUniqueStringGenerator.h"

#import <ResplendentUtilities/RUConditionalReturn.h>





@interface SMBGameBoardGeneralEntity_Attributes_For_NSCoding : NSObject
+(nonnull NSString*)uniqueId;
@end

@implementation SMBGameBoardGeneralEntity

#pragma mark - NSObject
-(nullable instancetype)init
{
	if (self = [super init])
	{
		kRUConditionalReturn_ReturnValueNil(self.uniqueId == nil, YES);
	}
	
	return self;
}

#pragma mark - NSObject
-(nullable instancetype)init_with_uniqueId:(nonnull NSString*)uniqueId
{
	
}

#pragma mark - uniqueId
@synthesize uniqueId = _uniqueId;
-(nonnull NSString*)uniqueId
{
	if (_uniqueId == nil)
	{
		static SMBUniqueStringGenerator* uniqueStringGenerator = nil;
		if (uniqueStringGenerator == nil)
		{
			uniqueStringGenerator = [SMBUniqueStringGenerator new];
		}

		_uniqueId = [uniqueStringGenerator uniqueId_next];
	}
	
	return _uniqueId;
}

#pragma mark - SMBMappedDataCollection_MappableObject
-(nonnull NSString*)smb_uniqueKey
{
	return self.uniqueId;
}

#pragma mark - NSCoding
-(nullable instancetype)initWithCoder:(nonnull NSCoder*)aDecoder
{
	if (self = [self init_with_gameBoardTilePosition:[aDecoder decodeObjectForKey:[SMBGameBoardTile_Attributes_For_NSCoding gameBoardTilePosition]]])
	{
	}
	
	return self;
}

-(void)encodeWithCoder:(nonnull NSCoder*)aCoder
{
	[aCoder encodeObject:self.gameBoardTilePosition forKey:[SMBGameBoardTile_Attributes_For_NSCoding gameBoardTilePosition]];
}

@end





@implementation SMBGameBoardGeneralEntity_Attributes_For_NSCoding
+(nonnull NSString*)uniqueId{return NSStringFromSelector(_cmd);}
@end

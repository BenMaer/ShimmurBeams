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





@implementation SMBGameBoardGeneralEntity

#pragma mark - NSObject
-(instancetype)init
{
	if (self = [super init])
	{
		kRUConditionalReturn_ReturnValueNil(self.uniqueId == nil, YES);
	}
	
	return self;
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

@end

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





@interface SMBGameBoardGeneralEntity ()

#pragma mark - uniqueId
@property (nonatomic, strong, nullable) NSString* uniqueId;
-(void)uniqueId_generate;

@end





@implementation SMBGameBoardGeneralEntity

#pragma mark - NSObject
-(instancetype)init
{
	if (self = [super init])
	{
		[self uniqueId_generate];
		kRUConditionalReturn_ReturnValueNil(self.uniqueId == nil, YES);
		kRUConditionalReturn_ReturnValueNil(self.uniqueId.length == 0, YES);
	}
	
	return self;
}

#pragma mark - uniqueId
-(void)uniqueId_generate
{
	static SMBUniqueStringGenerator* uniqueStringGenerator = nil;
	if (uniqueStringGenerator == nil)
	{
		uniqueStringGenerator = [SMBUniqueStringGenerator new];
	}
	
	[self setUniqueId:[uniqueStringGenerator uniqueId_next]];
}

#pragma mark - SMBMappedDataCollection_MappableObject
-(nonnull NSString*)smb_uniqueKey
{
	return self.uniqueId;
}

@end

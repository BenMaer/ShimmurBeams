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
		
		[self setNeedsRedraw:YES];
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

#pragma mark - draw
-(void)draw_in_rect:(CGRect)rect
{
	/* Since we can't prevent subclasses from getting this call using a boolean, we need to make sure the caller uses this rule. Hence, at this point, if this boolean is set improperly, there's a run-time issue at play. */
	kRUConditionalReturn(self.needsRedraw == NO, YES);
	
	[self setNeedsRedraw:NO];
}

#pragma mark - SMBMappedDataCollection_MappableObject
-(nonnull NSString*)smb_uniqueKey
{
	return self.uniqueId;
}

@end

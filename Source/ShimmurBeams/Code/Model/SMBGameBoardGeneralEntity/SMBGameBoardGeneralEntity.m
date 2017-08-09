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

#if DEBUG
#pragma mark - needsRedraw
-(void)setNeedsRedraw:(BOOL)needsRedraw
{
	NSAssert([NSThread isMainThread], @"should be");
	kRUConditionalReturn(self.needsRedraw == needsRedraw, NO);

	_needsRedraw = needsRedraw;
}
#endif

#pragma mark - draw
-(void)draw_in_rect:(CGRect)rect
{
	[self setNeedsRedraw:NO];
}

#pragma mark - SMBMappedDataCollection_MappableObject
-(nonnull NSString*)smb_uniqueKey
{
	return self.uniqueId;
}

@end





@implementation SMBGameBoardGeneralEntity_PropertiesForKVO

+(nonnull NSString*)needsRedraw{return NSStringFromSelector(_cmd);}

@end

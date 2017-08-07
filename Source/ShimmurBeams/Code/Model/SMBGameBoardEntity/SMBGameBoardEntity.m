//
//  SMBGameBoardEntity.m
//  ShimmurBeams
//
//  Created by Benjamin Maer on 8/5/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#import "SMBGameBoardEntity.h"
#import "SMBUniqueStringGenerator.h"

#import <ResplendentUtilities/RUConditionalReturn.h>





@interface SMBGameBoardEntity ()

#pragma mark - uniqueTileId
@property (nonatomic, strong, nullable) NSString* uniqueTileId;
-(void)uniqueTileId_generate;

@end





@implementation SMBGameBoardEntity

#pragma mark - NSObject
-(instancetype)init
{
	if (self = [super init])
	{
		[self uniqueTileId_generate];
		kRUConditionalReturn_ReturnValueNil(self.uniqueTileId == nil, YES);
		kRUConditionalReturn_ReturnValueNil(self.uniqueTileId.length == 0, YES);
		
		[self setNeedsRedraw:YES];
	}
	
	return self;
}

#pragma mark - uniqueTileId
-(void)uniqueTileId_generate
{
	static SMBUniqueStringGenerator* uniqueStringGenerator = nil;
	if (uniqueStringGenerator == nil)
	{
		uniqueStringGenerator = [SMBUniqueStringGenerator new];
	}
	
	[self setUniqueTileId:[uniqueStringGenerator uniqueId_next]];
}

#pragma mark - draw
-(void)draw_in_rect:(CGRect)rect
{
	kRUConditionalReturn(self.needsRedraw == NO, NO);
	
	[self setNeedsRedraw:NO];
}

@end

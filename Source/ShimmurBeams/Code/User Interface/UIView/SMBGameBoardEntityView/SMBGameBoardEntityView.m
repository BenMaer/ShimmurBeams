//
//  SMBGameBoardEntityView.m
//  ShimmurBeams
//
//  Created by Benjamin Maer on 8/4/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#import "SMBGameBoardEntityView.h"
#import "SMBGameBoardEntity.h"

#import <ResplendentUtilities/RUConditionalReturn.h>





@implementation SMBGameBoardEntityView

#pragma mark - NSObject
-(instancetype)initWithFrame:(CGRect)frame
{
	kRUConditionalReturn_ReturnValueNil(YES, YES);

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wno-nullability-completeness"

	return [self init_with_gameBoardEntity:nil];

#pragma clang diagnostic pop
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
	kRUConditionalReturn_ReturnValueNil(YES, YES);
	
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wno-nullability-completeness"
	
	return [self init_with_gameBoardEntity:nil];
	
#pragma clang diagnostic pop
}

#pragma mark - init
-(nullable instancetype)init_with_gameBoardEntity:(nonnull SMBGameBoardEntity*)gameBoardEntity
{
	kRUConditionalReturn_ReturnValueNil(gameBoardEntity == nil, YES);

	if (self = [super initWithFrame:CGRectZero])
	{
		[self setBackgroundColor:[UIColor clearColor]];

		_gameBoardEntity = gameBoardEntity;
	}

	return self;
}

#pragma mark - UIView
-(void)drawRect:(CGRect)rect
{
	[super drawRect:rect];

	SMBGameBoardEntity* const gameBoardEntity = self.gameBoardEntity;
	kRUConditionalReturn(gameBoardEntity == nil, YES);

	[gameBoardEntity draw_in_rect:rect];
}

@end

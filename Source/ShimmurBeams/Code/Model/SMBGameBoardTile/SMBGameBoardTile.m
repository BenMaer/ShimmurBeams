//
//  SMBGameBoardTile.m
//  ShimmurBeams
//
//  Created by Benjamin Maer on 8/3/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#import "SMBGameBoardTile.h"
#import "SMBGameBoardTileEntity.h"
#import "SMBGameBoard.h"

#import <ResplendentUtilities/RUConditionalReturn.h>





@interface SMBGameBoardTile ()

#pragma mark - beamEntityTileNodes
@property (nonatomic, copy, nullable) NSArray<SMBBeamEntityTileNode*>* beamEntityTileNodes;

@end





@implementation SMBGameBoardTile

#pragma mark - NSObject
-(instancetype)init
{
	kRUConditionalReturn_ReturnValueNil(YES, YES);

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wno-nullability-completeness"
	return [self init_with_gameBoardTilePosition:nil
									   gameBoard:nil];
#pragma clang diagnostic pop
}

#pragma mark - init
-(nullable instancetype)init_with_gameBoardTilePosition:(nonnull SMBGameBoardTilePosition*)gameBoardTilePosition
											  gameBoard:(nonnull SMBGameBoard*)gameBoard
{
	kRUConditionalReturn_ReturnValueNil(gameBoardTilePosition == nil, YES);
	kRUConditionalReturn_ReturnValueNil(gameBoard == nil, YES);

	if (self = [super init])
	{
		_gameBoardTilePosition = gameBoardTilePosition;
		_gameBoard = gameBoard;
	}

	return self;
}

#pragma mark - gameBoardTileEntity
-(void)setGameBoardTileEntity:(nullable SMBGameBoardTileEntity*)gameBoardTileEntity
{
	kRUConditionalReturn(self.gameBoardTileEntity == gameBoardTileEntity, NO);

	_gameBoardTileEntity = gameBoardTileEntity;

	if (self.gameBoardTileEntity)
	{
		if (self.gameBoardTileEntity.gameBoardTile != self)
		{
			[self.gameBoardTileEntity setGameBoardTile:self];
		}
	}
}

#pragma mark - beamEntityTileNodes
-(void)beamEntityTileNodes_add:(nonnull SMBBeamEntityTileNode*)beamEntityTileNode
{
	kRUConditionalReturn(beamEntityTileNode == nil, YES);

	NSArray<SMBBeamEntityTileNode*>* const beamEntityTileNodes_old = self.beamEntityTileNodes;
	kRUConditionalReturn([beamEntityTileNodes_old containsObject:beamEntityTileNode], YES);

	NSMutableArray<SMBBeamEntityTileNode*>* const beamEntityTileNodes_new = [NSMutableArray<SMBBeamEntityTileNode*> array];

	if (beamEntityTileNodes_old)
	{
		[beamEntityTileNodes_new addObjectsFromArray:beamEntityTileNodes_old];
	}

	[beamEntityTileNodes_new addObject:beamEntityTileNode];

	[self setBeamEntityTileNodes:[NSArray<SMBBeamEntityTileNode*> arrayWithArray:beamEntityTileNodes_new]];
}

-(void)beamEntityTileNodes_remove:(nonnull SMBBeamEntityTileNode*)beamEntityTileNode
{
	kRUConditionalReturn(beamEntityTileNode == nil, YES);

	NSArray<SMBBeamEntityTileNode*>* const beamEntityTileNodes_old = self.beamEntityTileNodes;
	kRUConditionalReturn(beamEntityTileNodes_old == nil, YES);

	NSInteger const beamEntityTileNode_index = [beamEntityTileNodes_old indexOfObject:beamEntityTileNode];
	kRUConditionalReturn(beamEntityTileNode_index == NSNotFound, YES);

	NSMutableArray<SMBBeamEntityTileNode*>* const beamEntityTileNodes_new = [NSMutableArray<SMBBeamEntityTileNode*> arrayWithArray:beamEntityTileNodes_old];
	[beamEntityTileNodes_new removeObjectAtIndex:beamEntityTileNode_index];

	[self setBeamEntityTileNodes:[NSArray<SMBBeamEntityTileNode*> arrayWithArray:beamEntityTileNodes_new]];
}

#pragma mark - gameBoardTile
-(nullable SMBGameBoardTile*)gameBoardTile_next_with_direction:(SMBGameBoardTile__direction)direction
{
	SMBGameBoard* const gameBoard = self.gameBoard;
	kRUConditionalReturn_ReturnValueNil(gameBoard == nil, YES);

	return [gameBoard gameBoardTile_next_from_gameBoardTile:self
												  direction:direction];
}

@end





@implementation SMBGameBoardTile_PropertiesForKVO

+(nonnull NSString*)gameBoardTileEntity{return NSStringFromSelector(_cmd);}
+(nonnull NSString*)beamEntityTileNodes{return NSStringFromSelector(_cmd);}

@end

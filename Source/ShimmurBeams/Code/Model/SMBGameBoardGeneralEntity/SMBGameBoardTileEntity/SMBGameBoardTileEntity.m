//
//  SMBGameBoardTileEntity.m
//  ShimmurBeams
//
//  Created by Benjamin Maer on 8/4/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#import "SMBGameBoardTileEntity.h"
#import "SMBGameBoardTile.h"

#import <ResplendentUtilities/RUConditionalReturn.h>
#import <ResplendentUtilities/NSMutableArray+RUAddObjectIfNotNil.h>
#import <ResplendentUtilities/RUConstants.h>





@interface SMBGameBoardTileEntity ()

#pragma mark - gameBoardTile
-(void)gameBoardTile_removeFromRelationship:(nonnull SMBGameBoardTile*)gameBoardTile;

@end





@implementation SMBGameBoardTileEntity

#pragma mark - NSObject
-(nonnull NSString*)description
{
	NSMutableArray<NSString*>* const description_lines = [NSMutableArray<NSString*> array];
	[description_lines ru_addObjectIfNotNil:[super description]];
	[description_lines ru_addObjectIfNotNil:RUStringWithFormat(@"gameBoardTile: %@",self.gameBoardTile)];
	
	return [description_lines componentsJoinedByString:@"\n"];
}

#pragma mark - gameBoardTile
-(void)setGameBoardTile:(nullable SMBGameBoardTile*)gameBoardTile
{
	kRUConditionalReturn(self.gameBoardTile == gameBoardTile, NO);

	SMBGameBoardTile* const gameBoardTile_old = self.gameBoardTile;
	_gameBoardTile = gameBoardTile;

	if (gameBoardTile_old != nil)
	{
		[self gameBoardTile_removeFromRelationship:gameBoardTile_old];
	}

	if (self.gameBoardTile != nil)
	{
		[self gameBoardTile_add:self.gameBoardTile];
	}
}

#pragma mark - gameBoardTile
-(void)gameBoardTile_removeFromRelationship:(nonnull SMBGameBoardTile*)gameBoardTile
{
	kRUConditionalReturn(gameBoardTile == nil, YES);

	if (gameBoardTile.gameBoardTileEntity_for_beamInteractions == self)
	{
		[gameBoardTile setGameBoardTileEntity_for_beamInteractions:nil];
	}
	else if ([gameBoardTile.gameBoardTileEntities containsObject:self])
	{
		[gameBoardTile gameBoardTileEntities_remove:self];
	}
}

-(void)gameBoardTile_add:(nonnull SMBGameBoardTile*)gameBoardTile
{
	kRUConditionalReturn(gameBoardTile == nil, YES);

	if ((gameBoardTile.gameBoardTileEntity_for_beamInteractions != self)
		&&
		([gameBoardTile.gameBoardTileEntities containsObject:self] == false)
		)
	{
		[gameBoardTile gameBoardTileEntities_add:self];
	}
}

@end





@implementation SMBGameBoardTileEntity_PropertiesForKVO

+(nonnull NSString*)gameBoardEntity{return NSStringFromSelector(_cmd);}
+(nonnull NSString*)needsRedraw{return NSStringFromSelector(_cmd);}

@end

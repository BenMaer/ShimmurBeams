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





#define kSMBGameBoardTileEntity_gameBoardTileOwnership_validation_enabled (kSMBEnvironment__SMBGameBoardTileEntity_gameBoardTileOwnership_validation_enabled && 1)





@interface SMBGameBoardTileEntity ()

#if kSMBGameBoardTileEntity_gameBoardTileOwnership_validation_enabled
#pragma mark - gameBoardTile
-(BOOL)gameBoardTile_belongsTo;
#endif

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
#if kSMBGameBoardTileEntity_gameBoardTileOwnership_validation_enabled
-(void)setGameBoardTile:(nullable SMBGameBoardTile*)gameBoardTile
{
	kRUConditionalReturn(self.gameBoardTile == gameBoardTile, NO);

	SMBGameBoardTile* const gameBoardTile_old = self.gameBoardTile;
	if (gameBoardTile_old)
	{
		[gameBoardTile_old gameBoardTileEntities_remove:self];
	}

#if kSMBGameBoardTileEntity_gameBoardTileOwnership_validation_enabled
	NSAssert((self.gameBoardTile == nil)
			 ||
			 ([self gameBoardTile_belongsTo] == false),
			 @"shouldn't belong to game tile anymore");
#endif

	_gameBoardTile = gameBoardTile;

#if kSMBGameBoardTileEntity_gameBoardTileOwnership_validation_enabled
	NSAssert((self.gameBoardTile == nil)
			 ||
			 ([self gameBoardTile_belongsTo]),
			 @"should belong game tile already");
#endif
}

-(BOOL)gameBoardTile_belongsTo
{
	SMBGameBoardTile* const gameBoardTile = self.gameBoardTile;
	kRUConditionalReturn_ReturnValueFalse(gameBoardTile == nil, YES);

	kRUConditionalReturn_ReturnValueTrue(gameBoardTile.gameBoardTileEntity_for_beamInteractions == self, NO);
	kRUConditionalReturn_ReturnValueTrue([gameBoardTile.gameBoardTileEntities_many containsObject:self], NO);

	return NO;
}
#endif

@end





@implementation SMBGameBoardTileEntity_PropertiesForKVO

+(nonnull NSString*)gameBoardEntity{return NSStringFromSelector(_cmd);}
+(nonnull NSString*)needsRedraw{return NSStringFromSelector(_cmd);}

@end

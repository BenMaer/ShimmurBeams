//
//  SMBGameBoardTileEntity.m
//  ShimmurBeams
//
//  Created by Benjamin Maer on 8/4/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#import "SMBGameBoardTileEntity.h"
#import "SMBGameBoardTile.h"
#import "SMBMappedDataCollection.h"

#import <ResplendentUtilities/RUConditionalReturn.h>
#import <ResplendentUtilities/NSMutableArray+RUAddObjectIfNotNil.h>
#import <ResplendentUtilities/RUConstants.h>





#define kSMBGameBoardTileEntity_gameBoardTileOwnership_validation_enabled (kSMBEnvironment__SMBGameBoardTileEntity_gameBoardTileOwnership_validation_enabled && 1)





@interface SMBGameBoardTileEntity ()

#if kSMBGameBoardTileEntity_gameBoardTileOwnership_validation_enabled
#pragma mark - gameBoardTile
-(BOOL)belongsTo_gameBoardTile:(nonnull SMBGameBoardTile*)gameBoardTile;
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

#if kSMBGameBoardTileEntity_gameBoardTileOwnership_validation_enabled
	NSAssert((self.gameBoardTile == nil)
			 ||
			 ([self belongsTo_gameBoardTile:self.gameBoardTile] == false),
			 @"shouldn't belong to game tile anymore");
#endif

	_gameBoardTile = gameBoardTile;

#if kSMBGameBoardTileEntity_gameBoardTileOwnership_validation_enabled
	NSAssert((self.gameBoardTile == nil)
			 ||
			 ([self belongsTo_gameBoardTile:self.gameBoardTile]),
			 @"should belong game tile already");
#endif
}

-(BOOL)belongsTo_gameBoardTile:(nonnull SMBGameBoardTile*)gameBoardTile
{
	kRUConditionalReturn_ReturnValueFalse(gameBoardTile == nil, YES);

	SMBMappedDataCollection<SMBGameBoardTileEntity*>* const gameBoardTileEntities_all = gameBoardTile.gameBoardTileEntities_all;
	kRUConditionalReturn_ReturnValueFalse(gameBoardTileEntities_all == nil, NO);
	kRUConditionalReturn_ReturnValueFalse([gameBoardTileEntities_all mappableObject_exists:self] == false, NO);

	return YES;
}
#endif

@end





@implementation SMBGameBoardTileEntity_PropertiesForKVO

+(nonnull NSString*)gameBoardTile{return NSStringFromSelector(_cmd);}

@end

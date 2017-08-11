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
#import "SMBMutableMappedDataCollection.h"
#import "SMBGameBoardTileEntity+SMBProvidesPower.h"
#import "SMBBeamBlockerTileEntity.h"
#import "SMBGameBoardTileEntity_PowerProvider.h"

#import <ResplendentUtilities/RUConditionalReturn.h>
#import <ResplendentUtilities/NSMutableArray+RUAddObjectIfNotNil.h>
#import <ResplendentUtilities/RUConstants.h>





@interface SMBGameBoardTile ()

#pragma mark - gameBoardTileEntities
@property (nonatomic, copy, nullable) NSArray<SMBGameBoardTileEntity*>* gameBoardTileEntities;
-(void)gameBoardTileEntities_update;
@property (nonatomic, readonly, strong, nullable) SMBMutableMappedDataCollection<SMBGameBoardTileEntity*>* gameBoardTileEntities_mappedDataCollection;

#pragma mark - gameBoardTileEntities_powerProviders_mappedDataCollection
@property (nonatomic, readonly, strong, nullable) SMBMutableMappedDataCollection<SMBGameBoardTileEntity<SMBGameBoardTileEntity_PowerProvider>*>* gameBoardTileEntities_powerProviders_mappedDataCollection;
-(void)gameBoardTileEntities_powerProviders_mappedDataCollection_add:(nonnull SMBGameBoardTileEntity<SMBGameBoardTileEntity_PowerProvider>*)gameBoardTileEntity;
-(void)gameBoardTileEntities_powerProviders_mappedDataCollection_remove:(nonnull SMBGameBoardTileEntity<SMBGameBoardTileEntity_PowerProvider>*)gameBoardTileEntity;

//#pragma mark - gameBoardTileEntities_beamBlockers
//@property (nonatomic, strong, nullable) SMBMutableMappedDataCollection<SMBGameBoardTileEntity<SMBBeamBlockerTileEntity>*>* gameBoardTileEntities_beamBlockers_mappedDataCollection;
//-(void)gameBoardTileEntities_beamBlockers_mappedDataCollection_add:(nonnull SMBGameBoardTileEntity<SMBBeamBlockerTileEntity>*)gameBoardTileEntity;
//-(void)gameBoardTileEntities_beamBlockers_mappedDataCollection_remove:(nonnull SMBGameBoardTileEntity<SMBBeamBlockerTileEntity>*)gameBoardTileEntity;

//#pragma mark - beamDirectionsBlocked
//@property (nonatomic, assign) SMBGameBoardTile__direction beamDirectionsBlocked;
//-(void)beamDirectionsBlocked_update;
//-(SMBGameBoardTile__direction)beamDirectionsBlocked_generate;

#pragma mark - isPowered
@property (nonatomic, assign) BOOL isPowered;
-(void)isPowered_update;

@end





@implementation SMBGameBoardTile

#pragma mark - NSObject
-(void)dealloc
{
	[[self.gameBoardTileEntities_mappedDataCollection mappableObjects] enumerateObjectsUsingBlock:^(SMBGameBoardTileEntity<SMBMappedDataCollection_MappableObject>*  _Nonnull gameBoardTileEntity, NSUInteger idx, BOOL * _Nonnull stop) {
		[self gameBoardTileEntities_remove:gameBoardTileEntity];
	}];

	[self setGameBoardTileEntity_for_beamInteractions:nil];
}

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

-(nonnull NSString*)description
{
	NSMutableArray<NSString*>* const description_lines = [NSMutableArray<NSString*> array];
	[description_lines ru_addObjectIfNotNil:[super description]];
	[description_lines ru_addObjectIfNotNil:RUStringWithFormat(@"gameBoardTilePosition: %@",self.gameBoardTilePosition)];

	return [description_lines componentsJoinedByString:@"\n"];
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

		_gameBoardTileEntities_mappedDataCollection = [SMBMutableMappedDataCollection<SMBGameBoardTileEntity*> new];
		_gameBoardTileEntities_powerProviders_mappedDataCollection = [SMBMutableMappedDataCollection<SMBGameBoardTileEntity<SMBGameBoardTileEntity_PowerProvider>*> new];
//		_gameBoardTileEntities_beamBlockers_mappedDataCollection = [SMBMutableMappedDataCollection<SMBGameBoardTileEntity<SMBBeamBlockerTileEntity>*> new];
	}

	return self;
}

#pragma mark - gameBoardTileEntity
-(void)gameBoardTileEntity:(nonnull SMBGameBoardTileEntity*)gameBoardTileEntity
		updateRelationship:(BOOL)hasRelationship
{
	kRUConditionalReturn(gameBoardTileEntity == nil, YES);

	SMBGameBoardTile* const gameBoardTile_toSetTo = (hasRelationship ? self : nil);
	kRUConditionalReturn(gameBoardTile_toSetTo == gameBoardTileEntity.gameBoardTile, YES);

	[gameBoardTileEntity setGameBoardTile:gameBoardTile_toSetTo];
}

#pragma mark - gameBoardTileEntity_for_beamInteractions
-(void)setGameBoardTileEntity_for_beamInteractions:(nullable SMBGameBoardTileEntity*)gameBoardTileEntity_for_beamInteractions
{
	kRUConditionalReturn(self.gameBoardTileEntity_for_beamInteractions == gameBoardTileEntity_for_beamInteractions, NO);
	kRUConditionalReturn((self.gameBoardTileEntity_for_beamInteractions == nil)
						 ==
						 (gameBoardTileEntity_for_beamInteractions == nil), NO);

	SMBGameBoardTileEntity* const gameBoardTileEntity_for_beamInteractions_old = self.gameBoardTileEntity_for_beamInteractions;
	_gameBoardTileEntity_for_beamInteractions = gameBoardTileEntity_for_beamInteractions;

	if (gameBoardTileEntity_for_beamInteractions_old)
	{
		[self gameBoardTileEntity:gameBoardTileEntity_for_beamInteractions_old
			   updateRelationship:NO];
	}

	if (self.gameBoardTileEntity_for_beamInteractions)
	{
		[self gameBoardTileEntity:self.gameBoardTileEntity_for_beamInteractions
			   updateRelationship:YES];
	}
}

#pragma mark - gameBoardTileEntities
-(void)gameBoardTileEntities_update
{
	[self setGameBoardTileEntities:[self.gameBoardTileEntities_mappedDataCollection mappableObjects]];
}

-(void)gameBoardTileEntities_add:(nonnull SMBGameBoardTileEntity*)gameBoardTileEntity
{
	kRUConditionalReturn(gameBoardTileEntity == nil, YES);

	[self.gameBoardTileEntities_mappedDataCollection mappableObject_add:gameBoardTileEntity];

	if ([gameBoardTileEntity smb_providesPower])
	{
		[self gameBoardTileEntities_powerProviders_mappedDataCollection_add:[gameBoardTileEntity smb_providesPower_selfOrNull]];
	}

//	if ([gameBoardTileEntity smb_beamBlocker])
//	{
//		[self gameBoardTileEntities_beamBlockers_mappedDataCollection_add:[gameBoardTileEntity smb_beamBlocker_selfOrNull]];
//	}

	[self gameBoardTileEntities_update];

	[self gameBoardTileEntity:gameBoardTileEntity
		   updateRelationship:YES];
}

-(void)gameBoardTileEntities_remove:(nonnull SMBGameBoardTileEntity*)gameBoardTileEntity
{
	kRUConditionalReturn(gameBoardTileEntity == nil, YES);

	[self.gameBoardTileEntities_mappedDataCollection mappableObject_remove:gameBoardTileEntity];

	if ([gameBoardTileEntity smb_providesPower])
	{
		[self gameBoardTileEntities_powerProviders_mappedDataCollection_remove:[gameBoardTileEntity smb_providesPower_selfOrNull]];
	}

//	if ([gameBoardTileEntity smb_beamBlocker])
//	{
//		[self gameBoardTileEntities_beamBlockers_mappedDataCollection_remove:[gameBoardTileEntity smb_beamBlocker_selfOrNull]];
//	}

	[self gameBoardTileEntities_update];

	[self gameBoardTileEntity:gameBoardTileEntity
		   updateRelationship:NO];
}

#pragma mark - gameBoardTileEntities_powerProviders_mappedDataCollection
-(void)gameBoardTileEntities_powerProviders_mappedDataCollection_add:(nonnull SMBGameBoardTileEntity<SMBGameBoardTileEntity_PowerProvider>*)gameBoardTileEntity
{
	kRUConditionalReturn(gameBoardTileEntity == nil, YES);
	kRUConditionalReturn([gameBoardTileEntity smb_providesPower] == false, YES);

	[self.gameBoardTileEntities_powerProviders_mappedDataCollection mappableObject_add:gameBoardTileEntity];

	[self isPowered_update];
}

-(void)gameBoardTileEntities_powerProviders_mappedDataCollection_remove:(nonnull SMBGameBoardTileEntity<SMBGameBoardTileEntity_PowerProvider>*)gameBoardTileEntity
{
	kRUConditionalReturn(gameBoardTileEntity == nil, YES);
	kRUConditionalReturn([gameBoardTileEntity smb_providesPower] == false, YES);

	[self.gameBoardTileEntities_powerProviders_mappedDataCollection mappableObject_remove:gameBoardTileEntity];

	[self isPowered_update];
}

//#pragma mark - gameBoardTileEntities_beamBlockers
//-(void)gameBoardTileEntities_beamBlockers_mappedDataCollection_add:(nonnull SMBGameBoardTileEntity<SMBBeamBlockerTileEntity>*)gameBoardTileEntity
//{
//	kRUConditionalReturn(gameBoardTileEntity == nil, YES);
//	kRUConditionalReturn([gameBoardTileEntity smb_beamBlocker] == false, YES);
//
//	[self.gameBoardTileEntities_powerProviders_mappedDataCollection mappableObject_add:gameBoardTileEntity];
//
//	[self beamDirectionsBlocked_update];
//}
//
//-(void)gameBoardTileEntities_beamBlockers_mappedDataCollection_remove:(nonnull SMBGameBoardTileEntity<SMBBeamBlockerTileEntity>*)gameBoardTileEntity
//{
//	kRUConditionalReturn(gameBoardTileEntity == nil, YES);
//	kRUConditionalReturn([gameBoardTileEntity smb_beamBlocker] == false, YES);
//
//	[self.gameBoardTileEntities_powerProviders_mappedDataCollection mappableObject_remove:gameBoardTileEntity];
//
//	[self beamDirectionsBlocked_update];
//}

//#pragma mark - beamDirectionsBlocked
//-(void)setBeamDirectionsBlocked:(SMBGameBoardTile__direction)beamDirectionsBlocked
//{
//	kRUConditionalReturn(self.beamDirectionsBlocked == beamDirectionsBlocked, NO);
//
//	_beamDirectionsBlocked = beamDirectionsBlocked;
//}
//
//-(void)beamDirectionsBlocked_update
//{
//	[self setBeamDirectionsBlocked:[self beamDirectionsBlocked_generate]];
//}
//
//-(SMBGameBoardTile__direction)beamDirectionsBlocked_generate
//{
//	NSMutableIndexSet* const directions_unblocked = [NSMutableIndexSet indexSet];
//	
//	for (SMBGameBoardTile__direction direction = SMBGameBoardTile__direction__first;
//		 direction <= SMBGameBoardTile__direction__last;
//		 direction = direction << 1)
//	{
//		[directions_unblocked addIndex:direction];
//	}
//
//	[[self.gameBoardTileEntities_mappedDataCollection mappableObjects] enumerateObjectsUsingBlock:^(SMBGameBoardTileEntity<SMBMappedDataCollection_MappableObject>* _Nonnull gameBoardTileEntity, NSUInteger idx, BOOL * _Nonnull stop) {
//
//		SMBGameBoardTileEntity<SMBBeamBlockerTileEntity>* const gameBoardTileEntity_beamBlocker = [gameBoardTileEntity smb_beamBlocker_selfOrNull];
//		kRUConditionalReturn(gameBoardTileEntity_beamBlocker == nil, NO);
//
//		NSIndexSet* const directions_unblocked_copy = [[NSIndexSet alloc] initWithIndexSet:directions_unblocked];
//		[directions_unblocked_copy enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL * _Nonnull stop) {
//			SMBGameBoardTile__direction direction = idx;
//			if ([gameBoardTileEntity_beamBlocker beamEnterDirection_isBlocked:direction])
//			{
//				[directions_unblocked removeIndex:idx];
//			}
//		}];
//	}];
//
//	SMBGameBoardTile__direction beamDirectionsBlocked = 0;
//	for (SMBGameBoardTile__direction direction = SMBGameBoardTile__direction__first;
//		 direction <= SMBGameBoardTile__direction__last;
//		 direction = direction << 1)
//	{
//		if ([directions_unblocked containsIndex:direction] == false)
//		{
//			beamDirectionsBlocked |= direction;
//		}
//	}
//
//	return beamDirectionsBlocked;
//}

#pragma mark - gameBoardTile
-(nullable SMBGameBoardTile*)gameBoardTile_next_with_direction:(SMBGameBoardTile__direction)direction
{
	SMBGameBoard* const gameBoard = self.gameBoard;
	kRUConditionalReturn_ReturnValueNil(gameBoard == nil, YES);

	return [gameBoard gameBoardTile_next_from_gameBoardTile:self
												  direction:direction];
}

#pragma mark - isPowered
-(void)isPowered_update
{
	[self setIsPowered:([self.gameBoardTileEntities_powerProviders_mappedDataCollection mappableObjects].count > 0)];
}

@end





@implementation SMBGameBoardTile_PropertiesForKVO

+(nonnull NSString*)gameBoardTileEntity_for_beamInteractions{return NSStringFromSelector(_cmd);}
+(nonnull NSString*)gameBoardTileEntities{return NSStringFromSelector(_cmd);}
+(nonnull NSString*)beamDirectionsBlocked{return NSStringFromSelector(_cmd);}
+(nonnull NSString*)isPowered{return NSStringFromSelector(_cmd);}

@end

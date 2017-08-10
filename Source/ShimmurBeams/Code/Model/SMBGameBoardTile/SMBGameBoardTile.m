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

#import <ResplendentUtilities/RUConditionalReturn.h>
#import <ResplendentUtilities/NSMutableArray+RUAddObjectIfNotNil.h>
#import <ResplendentUtilities/RUConstants.h>





#define kSMBGameBoardTile_gameBoardTileEntities_powerProviders_validate (kSMBEnvironment__SMBGameBoardTile_gameBoardTileEntities_powerProviders_validate && 1)





@interface SMBGameBoardTile ()

#pragma mark - gameBoardTileEntities
@property (nonatomic, copy, nullable) NSArray<SMBGameBoardTileEntity*>* gameBoardTileEntities;
-(void)gameBoardTileEntities_update;
@property (nonatomic, readonly, strong, nullable) SMBMutableMappedDataCollection<SMBGameBoardTileEntity*>* gameBoardTileEntities_mappedDataCollection;

#pragma mark - gameBoardTileEntities_powerProviders
@property (nonatomic, readonly, strong, nullable) SMBMutableMappedDataCollection<SMBGameBoardTileEntity*>* gameBoardTileEntities_powerProviders;
-(void)gameBoardTileEntities_powerProviders_add:(nonnull SMBGameBoardTileEntity*)gameBoardTileEntity;
-(void)gameBoardTileEntities_powerProviders_remove:(nonnull SMBGameBoardTileEntity*)gameBoardTileEntity;

#if kSMBGameBoardTile_gameBoardTileEntities_powerProviders_validate

-(void)gameBoardTileEntities_powerProviders_validate;

#endif

#pragma mark - isPowered
@property (nonatomic, assign) BOOL isPowered;
-(void)isPowered_update;

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
		_gameBoardTileEntities_powerProviders = [SMBMutableMappedDataCollection<SMBGameBoardTileEntity*> new];
	}

	return self;
}

#pragma mark - gameBoardTileEntity_for_beamInteractions
-(void)setGameBoardTileEntity_for_beamInteractions:(nullable SMBGameBoardTileEntity*)gameBoardTileEntity_for_beamInteractions
{
	kRUConditionalReturn(self.gameBoardTileEntity_for_beamInteractions == gameBoardTileEntity_for_beamInteractions, NO);

	_gameBoardTileEntity_for_beamInteractions = gameBoardTileEntity_for_beamInteractions;

	if (self.gameBoardTileEntity_for_beamInteractions)
	{
		if (self.gameBoardTileEntity_for_beamInteractions.gameBoardTile != self)
		{
			[self.gameBoardTileEntity_for_beamInteractions setGameBoardTile:self];
		}
	}
}

#pragma mark - gameBoardTileEntities
-(void)gameBoardTileEntities_update
{
	[self setGameBoardTileEntities:[self.gameBoardTileEntities_mappedDataCollection mappableObjects]];
}

-(void)gameBoardTileEntities_add:(nonnull SMBGameBoardTileEntity*)gameBoardTileEntity
{
	[self.gameBoardTileEntities_mappedDataCollection mappableObject_add:gameBoardTileEntity];

	if ([gameBoardTileEntity smb_providesPower])
	{
		[self gameBoardTileEntities_powerProviders_add:gameBoardTileEntity];
	}

	[self gameBoardTileEntities_update];
}

-(void)gameBoardTileEntities_remove:(nonnull SMBGameBoardTileEntity*)gameBoardTileEntity
{
	[self.gameBoardTileEntities_mappedDataCollection mappableObject_remove:gameBoardTileEntity];

	if ([gameBoardTileEntity smb_providesPower])
	{
		[self gameBoardTileEntities_powerProviders_remove:gameBoardTileEntity];
	}

	[self gameBoardTileEntities_update];
}

#pragma mark - gameBoardTileEntities_powerProviders
-(void)gameBoardTileEntities_powerProviders_add:(nonnull SMBGameBoardTileEntity*)gameBoardTileEntity
{
	kRUConditionalReturn(gameBoardTileEntity == nil, YES);
	kRUConditionalReturn([gameBoardTileEntity smb_providesPower] == false, YES);

	[self.gameBoardTileEntities_powerProviders mappableObject_add:gameBoardTileEntity];

#if kSMBGameBoardTile_gameBoardTileEntities_powerProviders_validate
	[self gameBoardTileEntities_powerProviders_validate];
#endif

	[self isPowered_update];
}

-(void)gameBoardTileEntities_powerProviders_remove:(nonnull SMBGameBoardTileEntity*)gameBoardTileEntity
{
	kRUConditionalReturn(gameBoardTileEntity == nil, YES);
	kRUConditionalReturn([gameBoardTileEntity smb_providesPower] == false, YES);

	[self.gameBoardTileEntities_powerProviders mappableObject_remove:gameBoardTileEntity];

#if kSMBGameBoardTile_gameBoardTileEntities_powerProviders_validate
	[self gameBoardTileEntities_powerProviders_validate];
#endif

	[self isPowered_update];
}

#if kSMBGameBoardTile_gameBoardTileEntities_powerProviders_validate

-(void)gameBoardTileEntities_powerProviders_validate
{
	
}

#endif

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
	[self setIsPowered:[self.gameBoardTileEntities_powerProviders mappableObjects].count];
}

@end





@implementation SMBGameBoardTile_PropertiesForKVO

+(nonnull NSString*)gameBoardTileEntity_for_beamInteractions{return NSStringFromSelector(_cmd);}
+(nonnull NSString*)gameBoardTileEntities{return NSStringFromSelector(_cmd);}
+(nonnull NSString*)isPowered{return NSStringFromSelector(_cmd);}
@end

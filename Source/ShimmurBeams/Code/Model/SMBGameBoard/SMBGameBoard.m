//
//  SMBGameBoard.m
//  ShimmurBeams
//
//  Created by Benjamin Maer on 8/3/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#import "SMBGameBoard.h"
#import "SMBGameBoardTile.h"
#import "SMBGameBoardTilePosition.h"
#import "SMBGameBoardEntity.h"

#import <ResplendentUtilities/RUConditionalReturn.h>
#import <ResplendentUtilities/RUClassOrNilUtil.h>





static void* kSMBGameBoard__KVOContext = &kSMBGameBoard__KVOContext;





@interface SMBGameBoard ()

#pragma mark - gameBoardTiles
/**
 The first array will contain columns, and then the second array will contain each tile in the column. That way first index is x, similar to the standard x,y system.
 */
@property (nonatomic, copy, nullable) NSArray<NSArray<SMBGameBoardTile*>*>* gameBoardTiles;
-(nullable NSArray<NSArray<SMBGameBoardTile*>*>*)gameBoardTiles_generate_with_numberOfRows:(NSUInteger)numberOfRows
																		   numberOfColumns:(NSUInteger)numberOfColumns;

-(nullable NSArray<SMBGameBoardTile*>*)gameBoardTiles_column_at_column:(NSUInteger)column;

-(void)gameBoardTiles_setKVORegistered:(BOOL)registered;
-(void)gameBoardTile:(nonnull SMBGameBoardTile*)gameBoardTile
	setKVORegistered:(BOOL)registered;

-(BOOL)gameBoardTiles_contains_gameBoardTile:(nonnull SMBGameBoardTile*)gameBoardTile;

#pragma mark - gameBoardEntities
@property (nonatomic, copy, nullable) NSArray<SMBGameBoardEntity*>* gameBoardEntities;
-(void)gameBoardEntity_add:(nonnull SMBGameBoardEntity*)gameBoardEntity;
-(void)gameBoardEntity_remove:(nonnull SMBGameBoardEntity*)gameBoardEntity;

@end





@implementation SMBGameBoard

#pragma mark - NSObject
-(void)dealloc
{
	[self gameBoardTiles_setKVORegistered:NO];
}

-(instancetype)init
{
	kRUConditionalReturn_ReturnValueNil(YES, YES);

	return [self init_with_numberOfColumns:0
							  numberOfRows:0];
}

#pragma mark - init
-(nullable instancetype)init_with_numberOfColumns:(NSUInteger)numberOfColumns
									 numberOfRows:(NSUInteger)numberOfRows
{
	kRUConditionalReturn_ReturnValueNil(numberOfColumns <= 0, YES);
	kRUConditionalReturn_ReturnValueNil(numberOfRows <= 0, YES);

	if (self = [super init])
	{
		[self setGameBoardTiles:[self gameBoardTiles_generate_with_numberOfRows:numberOfRows
																numberOfColumns:numberOfColumns]];
	}

	return self;
}

#pragma mark - gameBoardTiles
-(void)setGameBoardTiles:(NSArray<NSArray<SMBGameBoardTile *> *> *)gameBoardTiles
{
	kRUConditionalReturn((self.gameBoardTiles == gameBoardTiles)
						 ||
						 [self.gameBoardTiles isEqual:gameBoardTiles], NO);

	[self gameBoardTiles_setKVORegistered:NO];

	_gameBoardTiles = (gameBoardTiles ? [NSArray<NSArray<SMBGameBoardTile*>*> arrayWithArray:gameBoardTiles] : nil);

	[self gameBoardTiles_setKVORegistered:YES];
}

-(nullable NSArray<NSArray<SMBGameBoardTile*>*>*)gameBoardTiles_generate_with_numberOfRows:(NSUInteger)numberOfRows
																		   numberOfColumns:(NSUInteger)numberOfColumns
{
	kRUConditionalReturn_ReturnValueNil(numberOfRows == 0, YES);
	kRUConditionalReturn_ReturnValueNil(numberOfColumns == 0, YES);

	NSMutableArray<NSArray<SMBGameBoardTile*>*>* const gameBoardTiles = [NSMutableArray<NSArray<SMBGameBoardTile*>*> array];

	for (NSUInteger column = 0;
		 column < numberOfColumns;
		 column++)
	{
		NSMutableArray<SMBGameBoardTile*>* const gameBoardTiles_column = [NSMutableArray<SMBGameBoardTile*> array];

		for (NSUInteger row = 0;
			 row < numberOfRows;
			 row++)
		{
			SMBGameBoardTile* const gameBoardTile =
			[[SMBGameBoardTile alloc] init_with_gameBoardTilePosition:
			 [[SMBGameBoardTilePosition alloc] init_with_column:column
															row:row]
															gameBoard:self
			 ];

			[gameBoardTiles_column addObject:gameBoardTile];
		}

		[gameBoardTiles addObject:[NSArray<SMBGameBoardTile*> arrayWithArray:gameBoardTiles_column]];
	}

	return [NSArray<NSArray<SMBGameBoardTile*>*> arrayWithArray:gameBoardTiles];
}

-(nullable NSArray<SMBGameBoardTile*>*)gameBoardTiles_column_at_column:(NSUInteger)column
{
	NSArray<NSArray<SMBGameBoardTile*>*>* const gameBoardTiles = self.gameBoardTiles;
	kRUConditionalReturn_ReturnValueNil(gameBoardTiles == nil, YES);
	kRUConditionalReturn_ReturnValueNil(column >= gameBoardTiles.count, YES);

	return [gameBoardTiles objectAtIndex:column];
}

-(nullable SMBGameBoardTile*)gameBoardTile_at_position:(nonnull SMBGameBoardTilePosition*)position
{
	kRUConditionalReturn_ReturnValueNil(position == nil, YES);

	NSArray<SMBGameBoardTile*>* const gameBoardTiles_column = [self gameBoardTiles_column_at_column:position.column];
	kRUConditionalReturn_ReturnValueNil(gameBoardTiles_column == nil, YES);

	NSUInteger const row = position.row;
	kRUConditionalReturn_ReturnValueNil(row >= gameBoardTiles_column.count, YES);

	SMBGameBoardTile* const gameBoardTile = [gameBoardTiles_column objectAtIndex:row];
	kRUConditionalReturn_ReturnValueNil([gameBoardTile.gameBoardTilePosition isEqual_to_gameBoardTilePosition:position] == false, YES);

	return gameBoardTile;
}

-(void)gameBoardTiles_setKVORegistered:(BOOL)registered
{
	[self.gameBoardTiles enumerateObjectsUsingBlock:^(NSArray<SMBGameBoardTile *> * _Nonnull gameBoardTiles_column, NSUInteger idx, BOOL * _Nonnull stop) {
		[gameBoardTiles_column enumerateObjectsUsingBlock:^(SMBGameBoardTile * _Nonnull gameBoardTile, NSUInteger idx, BOOL * _Nonnull stop) {
			[self gameBoardTile:gameBoardTile setKVORegistered:registered];
		}];
	}];
}

-(void)gameBoardTile:(nonnull SMBGameBoardTile*)gameBoardTile
	setKVORegistered:(BOOL)registered
{
	kRUConditionalReturn(gameBoardTile == nil, YES);

	NSMutableArray<NSString*>* const propertiesToObserve_observe_old_and_initial = [NSMutableArray<NSString*> array];
	[propertiesToObserve_observe_old_and_initial addObject:[SMBGameBoardTile_PropertiesForKVO gameBoardEntity]];

	NSMutableDictionary<NSNumber*,NSMutableArray<NSString*>*>* const KVOOptions_to_propertiesToObserve_mapping = [NSMutableDictionary<NSNumber*,NSMutableArray<NSString*>*> dictionary];
	[KVOOptions_to_propertiesToObserve_mapping setObject:propertiesToObserve_observe_old_and_initial forKey:@(NSKeyValueObservingOptionInitial | NSKeyValueObservingOptionOld)];

	[KVOOptions_to_propertiesToObserve_mapping enumerateKeysAndObjectsUsingBlock:^(NSNumber * _Nonnull KVOOptions_number, NSMutableArray<NSString *> * _Nonnull propertiesToObserve, BOOL * _Nonnull stop) {
		[propertiesToObserve enumerateObjectsUsingBlock:^(NSString * _Nonnull propertyToObserve, NSUInteger idx, BOOL * _Nonnull stop) {
			if (registered)
			{
				[gameBoardTile addObserver:self
								forKeyPath:propertyToObserve
								   options:(KVOOptions_number.unsignedIntegerValue)
								   context:&kSMBGameBoard__KVOContext];
			}
			else
			{
				[gameBoardTile removeObserver:self
								   forKeyPath:propertyToObserve
									  context:&kSMBGameBoard__KVOContext];
			}
		}];
	}];
}

-(BOOL)gameBoardTiles_contains_gameBoardTile:(nonnull SMBGameBoardTile*)gameBoardTile
{
	kRUConditionalReturn_ReturnValueFalse(gameBoardTile == nil, YES);

	__block BOOL contains = NO;
	[self.gameBoardTiles enumerateObjectsUsingBlock:^(NSArray<SMBGameBoardTile *> * _Nonnull gameBoardTiles_column, NSUInteger idx, BOOL * _Nonnull gameBoardTiles_column_stop) {
		[gameBoardTiles_column enumerateObjectsUsingBlock:^(SMBGameBoardTile * _Nonnull gameBoardTile_loop, NSUInteger idx, BOOL * _Nonnull gameBoardTile_stop) {
			if (gameBoardTile == gameBoardTile_loop)
			{
				contains = YES;
				*gameBoardTiles_column_stop = YES;
				*gameBoardTile_stop = YES;
			}
		}];
	}];

	return contains;
}

-(NSUInteger)gameBoardTiles_numberOfColumns
{
	return self.gameBoardTiles.count;
}

-(NSUInteger)gameBoardTiles_numberOfRows
{
	kRUConditionalReturn_ReturnValue([self gameBoardTiles_numberOfColumns] == 0, YES, 0);

	return [self gameBoardTiles_column_at_column:0].count;
}

#pragma mark - gameBoardEntities
-(void)gameBoardEntity_add:(nonnull SMBGameBoardEntity*)gameBoardEntity
{
	kRUConditionalReturn(gameBoardEntity == nil, YES);

	NSArray<SMBGameBoardEntity*>* const gameBoardEntities_old = self.gameBoardEntities;
	kRUConditionalReturn([gameBoardEntities_old containsObject:gameBoardEntity], YES);

	NSMutableArray<SMBGameBoardEntity*>* const gameBoardEntities_new = [NSMutableArray<SMBGameBoardEntity*> array];

	if (gameBoardEntities_old)
	{
		[gameBoardEntities_new addObjectsFromArray:gameBoardEntities_old];
	}

	[gameBoardEntities_new addObject:gameBoardEntity];

	[self setGameBoardEntities:[NSArray<SMBGameBoardEntity*> arrayWithArray:gameBoardEntities_new]];
}

-(void)gameBoardEntity_remove:(nonnull SMBGameBoardEntity*)gameBoardEntity
{
	kRUConditionalReturn(gameBoardEntity == nil, YES);

	NSArray<SMBGameBoardEntity*>* const gameBoardEntities_old = self.gameBoardEntities;
	kRUConditionalReturn(gameBoardEntities_old == nil, YES);

	NSInteger const gameBoardEntity_index = [gameBoardEntities_old indexOfObject:gameBoardEntity];
	kRUConditionalReturn(gameBoardEntity_index == NSNotFound, YES);

	NSMutableArray<SMBGameBoardEntity*>* const gameBoardEntities_new = [NSMutableArray<SMBGameBoardEntity*> array];
	[gameBoardEntities_new addObjectsFromArray:gameBoardEntities_old];
	[gameBoardEntities_new removeObjectAtIndex:gameBoardEntity_index];

	[self setGameBoardEntities:[NSArray<SMBGameBoardEntity*> arrayWithArray:gameBoardEntities_new]];
}

#pragma mark - KVO
-(void)observeValueForKeyPath:(nullable NSString*)keyPath ofObject:(nullable id)object change:(nullable NSDictionary*)change context:(nullable void*)context
{
	if (context == kSMBGameBoard__KVOContext)
	{
		if ([self gameBoardTiles_contains_gameBoardTile:kRUClassOrNil(object, SMBGameBoardTile)])
		{
			if ([keyPath isEqualToString:[SMBGameBoardTile_PropertiesForKVO gameBoardEntity]])
			{
				SMBGameBoardTile* const gameBoardTile = kRUClassOrNil(object, SMBGameBoardTile);
				kRUConditionalReturn(gameBoardTile == nil, YES);

				SMBGameBoardEntity* const gameBoardEntity_old = kRUClassOrNil([change objectForKey:NSKeyValueChangeOldKey], SMBGameBoardEntity);
				if (gameBoardEntity_old)
				{
					[self gameBoardEntity_remove:gameBoardEntity_old];
				}

				SMBGameBoardEntity* const gameBoardEntity = gameBoardTile.gameBoardEntity;
				if (gameBoardEntity)
				{
					[self gameBoardEntity_add:gameBoardEntity];
				}
			}
			else
			{
				NSAssert(false, @"unhandled keyPath %@",keyPath);
			}
		}
		else
		{
			NSAssert(false, @"unhandled object %@",object);
		}
	}
	else
	{
		[super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
	}
}

@end





@implementation SMBGameBoard_PropertiesForKVO

+(nonnull NSString*)gameBoardEntities{return NSStringFromSelector(_cmd);}

@end

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
#import "SMBGameBoardTileEntity.h"
#import "SMBGameBoardEntity.h"
#import "NSArray+SMBChanges.h"
#import "SMBBeamEntityTileNode.h"
#import "SMBMutableMappedDataCollection.h"
#import "NSSet+SMBChanges.h"
#import "SMBGenericPowerOutputTileEntity_OutputPowerReceiver.h"
#import "SMBBeamEntityManager.h"
#import "SMBGameBoardMove.h"

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

#pragma mark - gameBoardTileEntities
@property (nonatomic, copy, nullable) NSArray<SMBGameBoardTileEntity*>* gameBoardTileEntities;
-(void)gameBoardTileEntities_update;
-(nullable NSArray<SMBGameBoardTileEntity*>*)gameBoardTileEntities_generate;

#if DEBUG
#pragma mark - deallocWasCalled
@property (nonatomic, assign) BOOL deallocWasCalled;
#endif

#pragma mark - currentNumberOfMoves
@property (nonatomic, assign) NSUInteger currentNumberOfMoves;

@end





@implementation SMBGameBoard

#pragma mark - NSObject
-(void)dealloc
{
#if DEBUG
	[self setDeallocWasCalled:YES];
#endif

	[self gameBoardTiles_setKVORegistered:NO];
	[self setGameBoardEntities:nil];
	[self setOutputPowerReceivers:nil];
}

-(instancetype)init
{
	kRUConditionalReturn_ReturnValueNil(YES, YES);

	return [self init_with_numberOfColumns:0
							  numberOfRows:0
						leastNumberOfMoves:0];
}

#pragma mark - init
-(nullable instancetype)init_with_numberOfColumns:(NSUInteger)numberOfColumns
									 numberOfRows:(NSUInteger)numberOfRows
							   leastNumberOfMoves:(NSUInteger)leastNumberOfMoves
{
	kRUConditionalReturn_ReturnValueNil(numberOfColumns <= 0, YES);
	kRUConditionalReturn_ReturnValueNil(numberOfRows <= 0, YES);
	kRUConditionalReturn_ReturnValueNil(leastNumberOfMoves < 0, YES);

	if (self = [super init])
	{
		[self setGameBoardTiles:[self gameBoardTiles_generate_with_numberOfRows:numberOfRows
																numberOfColumns:numberOfColumns]];

		_leastNumberOfMoves = leastNumberOfMoves;
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

-(void)gameBoardTiles_enumerate:(void (^_Nonnull)(SMBGameBoardTile * _Nonnull gameBoardTile, NSUInteger column, NSUInteger row, BOOL * _Nonnull stop))block
{
	kRUConditionalReturn(block == nil, YES);

	[self.gameBoardTiles enumerateObjectsUsingBlock:^(NSArray<SMBGameBoardTile *> * _Nonnull gameBoardTiles_column, NSUInteger column, BOOL * _Nonnull stop_column) {
		[gameBoardTiles_column enumerateObjectsUsingBlock:^(SMBGameBoardTile * _Nonnull gameBoardTile, NSUInteger row, BOOL * _Nonnull stop_row) {
			BOOL stop = false;

			block(gameBoardTile, column, row, &stop);

			*stop_column = stop;
			*stop_row = stop;
		}];
	}];
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
	kRUConditionalReturn_ReturnValueNil(column >= gameBoardTiles.count, NO);

	return [gameBoardTiles objectAtIndex:column];
}

-(nullable SMBGameBoardTile*)gameBoardTile_at_position:(nonnull SMBGameBoardTilePosition*)position
{
	kRUConditionalReturn_ReturnValueNil(position == nil, YES);

	NSArray<SMBGameBoardTile*>* const gameBoardTiles_column = [self gameBoardTiles_column_at_column:position.column];
	kRUConditionalReturn_ReturnValueNil(gameBoardTiles_column == nil, NO);

	NSUInteger const row = position.row;
	kRUConditionalReturn_ReturnValueNil(row >= gameBoardTiles_column.count, NO);

	SMBGameBoardTile* const gameBoardTile = [gameBoardTiles_column objectAtIndex:row];
	kRUConditionalReturn_ReturnValueNil([gameBoardTile.gameBoardTilePosition isEqual_to_gameBoardTilePosition:position] == false, YES);

	return gameBoardTile;
}

-(void)gameBoardTiles_setKVORegistered:(BOOL)registered
{
	[self gameBoardTiles_enumerate:^(SMBGameBoardTile * _Nonnull gameBoardTile, NSUInteger column, NSUInteger row, BOOL * _Nonnull stop) {
		[self gameBoardTile:gameBoardTile setKVORegistered:registered];
	}];
}

-(void)gameBoardTile:(nonnull SMBGameBoardTile*)gameBoardTile
	setKVORegistered:(BOOL)registered
{
	kRUConditionalReturn(gameBoardTile == nil, YES);

	NSMutableArray<NSString*>* const propertiesToObserve_and_initial = [NSMutableArray<NSString*> array];
	[propertiesToObserve_and_initial addObject:[SMBGameBoardTile_PropertiesForKVO gameBoardTileEntities_all]];

	NSMutableDictionary<NSNumber*,NSMutableArray<NSString*>*>* const KVOOptions_to_propertiesToObserve_mapping = [NSMutableDictionary<NSNumber*,NSMutableArray<NSString*>*> dictionary];
	[KVOOptions_to_propertiesToObserve_mapping setObject:propertiesToObserve_and_initial forKey:@(NSKeyValueObservingOptionInitial)];

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
	[self gameBoardTiles_enumerate:^(SMBGameBoardTile * _Nonnull gameBoardTile_loop, NSUInteger column, NSUInteger row, BOOL * _Nonnull stop) {
		if (gameBoardTile == gameBoardTile_loop)
		{
			contains = YES;
			*stop = YES;
		}
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

-(SMBGameBoardTile__direction_offset)gameBoardTile_next_offset_for_direction:(SMBGameBoardTile__direction)direction
{
	switch (direction)
	{
		case SMBGameBoardTile__direction_unknown:
			break;

		case SMBGameBoardTile__direction_up:
			return (SMBGameBoardTile__direction_offset){
				.vertical = -1,
			};
			break;

		case SMBGameBoardTile__direction_right:
			return (SMBGameBoardTile__direction_offset){
				.horizontal = 1,
			};
			break;

		case SMBGameBoardTile__direction_down:
			return (SMBGameBoardTile__direction_offset){
				.vertical = 1,
			};
			break;

		case SMBGameBoardTile__direction_left:
			return (SMBGameBoardTile__direction_offset){
				.horizontal = -1,
			};
			break;

		case SMBGameBoardTile__direction_none:
			return SMBGameBoardTile__direction_offset_zero;
			break;
	}

	NSAssert(false, @"unhandled direction %li",(long)direction);
	return SMBGameBoardTile__direction_offset_zero;
}

-(nullable SMBGameBoardTile*)gameBoardTile_next_from_gameBoardTile:(nonnull SMBGameBoardTile*)gameBoardTile
														 direction:(SMBGameBoardTile__direction)direction
{
	kRUConditionalReturn_ReturnValueNil(gameBoardTile == nil, YES);

	SMBGameBoardTilePosition* const gameBoardTilePosition = gameBoardTile.gameBoardTilePosition;
	kRUConditionalReturn_ReturnValueNil(gameBoardTilePosition == nil, YES);

	SMBGameBoardTile__direction_offset const offset = [self gameBoardTile_next_offset_for_direction:direction];
	SMBGameBoardTilePosition* const gameBoardTilePosition_next =
	[[SMBGameBoardTilePosition alloc] init_with_column:gameBoardTilePosition.column + offset.horizontal
												   row:gameBoardTilePosition.row + offset.vertical];
	kRUConditionalReturn_ReturnValueNil(gameBoardTilePosition_next == nil, YES);

	return [self gameBoardTile_at_position:gameBoardTilePosition_next];
}

#pragma mark - gameBoardTileEntities
-(void)gameBoardTileEntities_update
{
	[self setGameBoardTileEntities:[self gameBoardTileEntities_generate]];
}

-(nullable NSArray<SMBGameBoardTileEntity*>*)gameBoardTileEntities_generate
{
	NSMutableArray<SMBGameBoardTileEntity*>* const gameBoardTileEntities = [NSMutableArray<SMBGameBoardTileEntity*> array];

	[self.gameBoardTiles enumerateObjectsUsingBlock:^(NSArray<SMBGameBoardTile*>* _Nonnull gameBoardTiles, NSUInteger idx, BOOL * _Nonnull stop) {
		[gameBoardTiles enumerateObjectsUsingBlock:^(SMBGameBoardTile * _Nonnull gameBoardTile, NSUInteger idx, BOOL * _Nonnull stop) {
			[[gameBoardTile.gameBoardTileEntities_all mappableObjects] enumerateObjectsUsingBlock:^(SMBGameBoardTileEntity * _Nonnull gameBoardTileEntity, NSUInteger idx, BOOL * _Nonnull stop) {
				[gameBoardTileEntities addObject:gameBoardTileEntity];
			}];
		}];
	}];

	return [NSArray<SMBGameBoardTileEntity*> arrayWithArray:gameBoardTileEntities];
}

#pragma mark - KVO
-(void)observeValueForKeyPath:(nullable NSString*)keyPath ofObject:(nullable id)object change:(nullable NSDictionary<NSKeyValueChangeKey,id>*)change context:(nullable void*)context
{
	if (context == kSMBGameBoard__KVOContext)
	{
		if ([self gameBoardTiles_contains_gameBoardTile:kRUClassOrNil(object, SMBGameBoardTile)])
		{
			if ([keyPath isEqualToString:[SMBGameBoardTile_PropertiesForKVO gameBoardTileEntities_all]])
			{
				[self gameBoardTileEntities_update];
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

#pragma mark - gameBoardEntities
-(void)setGameBoardEntities:(nullable NSArray<SMBGameBoardEntity*>*)gameBoardEntities
{
	kRUConditionalReturn((self.gameBoardEntities == gameBoardEntities)
						 ||
						 [self.gameBoardEntities isEqual:gameBoardEntities], NO);

	NSArray<SMBGameBoardEntity*>* const gameBoardEntities_old = self.gameBoardEntities;
	_gameBoardEntities = (gameBoardEntities ? [NSArray<SMBGameBoardEntity*> arrayWithArray:gameBoardEntities] : nil);

	NSArray<SMBGameBoardEntity*>* gameBoardEntities_removedObjects = nil;
	NSArray<SMBGameBoardEntity*>* gameBoardEntities_addedObjects = nil;
	[NSArray<SMBGameBoardEntity*> smb_changes_from_objects:gameBoardEntities_old
												to_objects:self.gameBoardEntities
											removedObjects:&gameBoardEntities_removedObjects
												newObjects:&gameBoardEntities_addedObjects];

	[gameBoardEntities_removedObjects enumerateObjectsUsingBlock:^(SMBGameBoardEntity * _Nonnull gameBoardEntity, NSUInteger idx, BOOL * _Nonnull stop) {
		NSAssert(gameBoardEntity.gameBoard == self, @"should be");
		[gameBoardEntity setGameBoard:nil];
	}];

	[gameBoardEntities_addedObjects enumerateObjectsUsingBlock:^(SMBGameBoardEntity * _Nonnull gameBoardEntity, NSUInteger idx, BOOL * _Nonnull stop) {
		NSAssert(gameBoardEntity.gameBoard == nil, @"should be");
		[gameBoardEntity setGameBoard:self];
	}];
}

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
	kRUConditionalReturn(gameBoardEntities_old == nil,
						 (self.deallocWasCalled == false));

	NSInteger const gameBoardEntity_index = [gameBoardEntities_old indexOfObject:gameBoardEntity];
	kRUConditionalReturn(gameBoardEntity_index == NSNotFound, YES);

	NSMutableArray<SMBGameBoardEntity*>* const gameBoardEntities_new = [NSMutableArray<SMBGameBoardEntity*> array];
	[gameBoardEntities_new addObjectsFromArray:gameBoardEntities_old];
	[gameBoardEntities_new removeObjectAtIndex:gameBoardEntity_index];

	[self setGameBoardEntities:[NSArray<SMBGameBoardEntity*> arrayWithArray:gameBoardEntities_new]];
}

#pragma mark - outputPowerReceivers
-(void)setOutputPowerReceivers:(nullable NSSet<SMBGenericPowerOutputTileEntity_OutputPowerReceiver*>*)outputPowerReceivers
{
	kRUConditionalReturn((self.outputPowerReceivers == outputPowerReceivers)
						 ||
						 [self.outputPowerReceivers isEqual:outputPowerReceivers], NO);

	NSSet<SMBGenericPowerOutputTileEntity_OutputPowerReceiver*>* const outputPowerReceivers_old = self.outputPowerReceivers;
	_outputPowerReceivers = (outputPowerReceivers ? [NSSet<SMBGenericPowerOutputTileEntity_OutputPowerReceiver*> setWithSet:outputPowerReceivers] : nil);

	NSSet<SMBGenericPowerOutputTileEntity_OutputPowerReceiver*>* outputPowerReceivers_removedObjects = nil;
	NSSet<SMBGenericPowerOutputTileEntity_OutputPowerReceiver*>* outputPowerReceivers_addedObjects = nil;
	[NSSet<SMBGenericPowerOutputTileEntity_OutputPowerReceiver*> smb_changes_from_objects:outputPowerReceivers_old
																				  to_objects:self.outputPowerReceivers
																			  removedObjects:&outputPowerReceivers_removedObjects
																				  newObjects:&outputPowerReceivers_addedObjects];

	[outputPowerReceivers_removedObjects enumerateObjectsUsingBlock:^(SMBGenericPowerOutputTileEntity_OutputPowerReceiver*  _Nonnull outputPowerReceiver, BOOL * _Nonnull stop) {
		[outputPowerReceiver setGameBoard:nil];
	}];

	[outputPowerReceivers_addedObjects enumerateObjectsUsingBlock:^(SMBGenericPowerOutputTileEntity_OutputPowerReceiver*  _Nonnull outputPowerReceiver, BOOL * _Nonnull stop) {
		[outputPowerReceiver setGameBoard:self];
	}];
}

-(void)outputPowerReceiver_add:(nonnull SMBGenericPowerOutputTileEntity_OutputPowerReceiver*)outputPowerReceiver
{
	kRUConditionalReturn(outputPowerReceiver == nil, YES);

	NSSet<SMBGenericPowerOutputTileEntity_OutputPowerReceiver*>* const outputPowerReceivers_old = self.outputPowerReceivers;
	kRUConditionalReturn([outputPowerReceivers_old containsObject:outputPowerReceiver], YES);

	NSMutableSet<SMBGenericPowerOutputTileEntity_OutputPowerReceiver*>* const outputPowerReceivers_new = [NSMutableSet<SMBGenericPowerOutputTileEntity_OutputPowerReceiver*> set];

	if (outputPowerReceivers_old)
	{
		[outputPowerReceivers_new unionSet:outputPowerReceivers_old];
	}

	[outputPowerReceivers_new addObject:outputPowerReceiver];

	[self setOutputPowerReceivers:[NSSet<SMBGenericPowerOutputTileEntity_OutputPowerReceiver*> setWithSet:outputPowerReceivers_new]];
}

-(void)outputPowerReceiver_remove:(nonnull SMBGenericPowerOutputTileEntity_OutputPowerReceiver*)outputPowerReceiver
{
	kRUConditionalReturn(outputPowerReceiver == nil, YES);

	NSSet<SMBGenericPowerOutputTileEntity_OutputPowerReceiver*>* const outputPowerReceivers_old = self.outputPowerReceivers;
	kRUConditionalReturn(outputPowerReceivers_old == nil,
						 (self.deallocWasCalled == false));

	kRUConditionalReturn([outputPowerReceivers_old containsObject:outputPowerReceiver] == false, YES);

	NSMutableSet<SMBGenericPowerOutputTileEntity_OutputPowerReceiver*>* const outputPowerReceivers_new = [NSMutableSet<SMBGenericPowerOutputTileEntity_OutputPowerReceiver*> set];
	[outputPowerReceivers_new unionSet:outputPowerReceivers_old];
	[outputPowerReceivers_new removeObject:outputPowerReceiver];

	[self setOutputPowerReceivers:[NSSet<SMBGenericPowerOutputTileEntity_OutputPowerReceiver*> setWithSet:outputPowerReceivers_new]];
}

#pragma mark - beamEntityManager
@synthesize beamEntityManager = _beamEntityManager;
-(nonnull SMBBeamEntityManager*)beamEntityManager
{
	if (_beamEntityManager == nil)
	{
		_beamEntityManager = [SMBBeamEntityManager new];
	}
	
	return _beamEntityManager;
}

#pragma mark - gameBoardMove
-(void)gameBoardMove_perform:(nonnull id<SMBGameBoardMove>)gameBoardMove
{
	kRUConditionalReturn(gameBoardMove == nil, YES);

	kRUConditionalReturn([gameBoardMove move_perform_on_gameBoard:self] == false, YES);

	[self setCurrentNumberOfMoves:self.currentNumberOfMoves + 1];
}

@end





@implementation SMBGameBoard_PropertiesForKVO

+(nonnull NSString*)gameBoardTiles{return NSStringFromSelector(_cmd);}
+(nonnull NSString*)gameBoardTileEntities{return NSStringFromSelector(_cmd);}
+(nonnull NSString*)gameBoardEntities{return NSStringFromSelector(_cmd);}
+(nonnull NSString*)outputPowerReceivers{return NSStringFromSelector(_cmd);}
+(nonnull NSString*)currentNumberOfMoves{return NSStringFromSelector(_cmd);}

@end

//
//  SMBBeamEntityTileNode.m
//  ShimmurBeams
//
//  Created by Benjamin Maer on 8/5/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#import "SMBBeamEntityTileNode.h"
#import "SMBGameBoardTile.h"
#import "SMBBeamCreatorTileEntity.h"
#import "SMBGameBoard.h"
#import "SMBGameBoardTilePosition.h"
#import "SMBGeneralBeamExitOrientationRedirectTileEntity.h"
#import "SMBBeamEntityTileNode__beamOrientations_to_SMBGameBoardTileEntity__orientation_utilities.h"

#import <ResplendentUtilities/RUConditionalReturn.h>
#import <ResplendentUtilities/RUClassOrNilUtil.h>





static void* kSMBBeamEntityTileNode__KVOContext = &kSMBBeamEntityTileNode__KVOContext;





@interface SMBBeamEntityTileNode ()

#pragma mark - gameBoardTile
-(void)gameBoardTile_setKVORegistered:(BOOL)registered;

#pragma mark - beamExitOrientation
@property (nonatomic, assign) SMBBeamEntityTileNode__beamOrientation beamExitOrientation;
-(void)beamExitOrientation_update;
-(SMBBeamEntityTileNode__beamOrientation)beamExitOrientation_generate;

#pragma mark - node_next
@property (nonatomic, strong, nullable) SMBBeamEntityTileNode* node_next;
-(void)node_next_update;
-(nullable SMBBeamEntityTileNode*)node_next_generate;

@end





@implementation SMBBeamEntityTileNode

#pragma mark - NSObject
-(void)dealloc
{
	[self gameBoardTile_setKVORegistered:NO];
}

-(instancetype)init
{
	kRUConditionalReturn_ReturnValueNil(YES, YES);
	
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wno-nullability-completeness"
	return [self init_with_gameBoardTile:nil
							  beamEntity:nil
						   node_previous:nil];
#pragma clang diagnostic pop
}

#pragma mark - init
-(nullable instancetype)init_with_gameBoardTile:(nonnull SMBGameBoardTile*)gameBoardTile
									 beamEntity:(nonnull SMBBeamEntity*)beamEntity
								  node_previous:(nullable SMBBeamEntityTileNode*)node_previous
{
	kRUConditionalReturn_ReturnValueNil(gameBoardTile == nil, YES);

	if (self = [super init])
	{
		_gameBoardTile = gameBoardTile;
		_beamEntity = beamEntity;
		_node_previous = node_previous;

		[self beamExitOrientation_update];
		kRUConditionalReturn_ReturnValueNil(self.beamExitOrientation == SMBBeamEntityTileNode__beamOrientation_none, YES);
	}

	return self;
}

#pragma mark - gameBoardTile
-(void)gameBoardTile_setKVORegistered:(BOOL)registered
{
	typeof(self.gameBoardTile) const gameBoardTile = self.gameBoardTile;
	kRUConditionalReturn(gameBoardTile == nil, NO);
	
	NSMutableArray<NSString*>* const propertiesToObserve = [NSMutableArray<NSString*> array];
	[propertiesToObserve addObject:[SMBGameBoardTile_PropertiesForKVO gameBoardTileEntity]];
	
	[propertiesToObserve enumerateObjectsUsingBlock:^(NSString * _Nonnull propertyToObserve, NSUInteger idx, BOOL * _Nonnull stop) {
		if (registered)
		{
			[gameBoardTile addObserver:self
						forKeyPath:propertyToObserve
						   options:(NSKeyValueObservingOptionInitial)
						   context:&kSMBBeamEntityTileNode__KVOContext];
		}
		else
		{
			[gameBoardTile removeObserver:self
						   forKeyPath:propertyToObserve
							  context:&kSMBBeamEntityTileNode__KVOContext];
		}
	}];
}

#pragma mark - beamExitOrientation
-(void)setBeamExitOrientation:(SMBBeamEntityTileNode__beamOrientation)beamExitOrientation
{
	kRUConditionalReturn(self.beamExitOrientation == beamExitOrientation, NO);

	_beamExitOrientation = beamExitOrientation;

	[self node_next_update];
}

-(void)beamExitOrientation_update
{
	[self setBeamExitOrientation:[self beamExitOrientation_generate]];
	kRUConditionalReturn(self.beamExitOrientation == SMBBeamEntityTileNode__beamOrientation_none, YES);
}

-(SMBBeamEntityTileNode__beamOrientation)beamExitOrientation_generate
{
	SMBBeamEntityTileNode__beamOrientation const beamOrientation_error = SMBBeamEntityTileNode__beamOrientation_none;

	SMBGameBoardTile* const gameBoardTile = self.gameBoardTile;
	kRUConditionalReturn_ReturnValue(gameBoardTile == nil, YES, beamOrientation_error);

	SMBGameBoardTileEntity* const gameBoardTileEntity = gameBoardTile.gameBoardTileEntity;

	SMBBeamEntityTileNode* const node_previous = self.node_previous;
	if (node_previous == nil)
	{
		kRUConditionalReturn_ReturnValue(gameBoardTileEntity == nil, YES, beamOrientation_error);

		SMBBeamCreatorTileEntity* const beamCreatorTileEntity = kRUClassOrNil(gameBoardTileEntity, SMBBeamCreatorTileEntity);
		kRUConditionalReturn_ReturnValue(beamCreatorTileEntity == nil, YES, beamOrientation_error);

		return SMBBeamEntityTileNode__beamOrientation_for_gameBoardTileEntity__orientation(beamCreatorTileEntity.orientation);
	}

	if (gameBoardTileEntity)
	{
		SMBGeneralBeamExitOrientationRedirectTileEntity* const generalBeamExitOrientationRedirectTileEntity = kRUClassOrNil(gameBoardTileEntity, SMBGeneralBeamExitOrientationRedirectTileEntity);
		if (generalBeamExitOrientationRedirectTileEntity)
		{
			return [generalBeamExitOrientationRedirectTileEntity beamExitOrientation_for_beamEnterOrientation:[self beamEnterOrientation]];
		}
	}

	return node_previous.beamExitOrientation;
}

#pragma mark - KVO
-(void)observeValueForKeyPath:(nullable NSString*)keyPath ofObject:(nullable id)object change:(nullable NSDictionary*)change context:(nullable void*)context
{
	if (context == kSMBBeamEntityTileNode__KVOContext)
	{
		if (object == self.gameBoardTile)
		{
			if ([keyPath isEqualToString:[SMBGameBoardTile_PropertiesForKVO gameBoardTileEntity]])
			{
				[self beamExitOrientation_update];
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

#pragma mark - node_next
-(void)node_next_update
{
	[self setNode_next:[self node_next_generate]];
}

-(nullable SMBBeamEntityTileNode*)node_next_generate
{
	SMBGameBoardTile* const gameBoardTile = self.gameBoardTile;
	kRUConditionalReturn_ReturnValueNil(gameBoardTile == nil, YES);

	SMBGameBoard* const gameBoard = gameBoardTile.gameBoard;
	kRUConditionalReturn_ReturnValueNil(gameBoard == nil, YES);

	SMBBeamEntityTileNode__beamOrientation const beamExitOrientation = self.beamExitOrientation;
	kRUConditionalReturn_ReturnValueNil(SMBBeamEntityTileNode__beamOrientation__isInRange(beamExitOrientation) == false, YES);

	SMBBeamEntity* const beamEntity = self.beamEntity;
	kRUConditionalReturn_ReturnValueNil(beamEntity == nil, YES);

	SMBGameBoardTile* const gameBoardTile_next =
	[gameBoard gameBoardTile_next_from_gameBoardTile:gameBoardTile
										 orientation:SMBGameBoardTileEntity__orientation_for_beamOrientation(beamExitOrientation)];
	kRUConditionalReturn_ReturnValueNil(gameBoardTile_next == nil, NO);

	SMBBeamEntityTileNode* const node_next =
	[[SMBBeamEntityTileNode alloc] init_with_gameBoardTile:gameBoardTile_next
												beamEntity:beamEntity
											 node_previous:self];

	return node_next;
}

#pragma mark - SMBMappedDataCollection_MappableObject
-(nonnull NSString*)smb_uniqueKey
{
	return [self.gameBoardTile.gameBoardTilePosition smb_uniqueKey];
}

#pragma mark - beamEnterOrientation
-(SMBBeamEntityTileNode__beamOrientation)beamEnterOrientation
{
	SMBBeamEntityTileNode* const node_previous = self.node_previous;
	kRUConditionalReturn_ReturnValue(node_previous == nil, YES, SMBBeamEntityTileNode__beamOrientation_none);

	SMBBeamEntityTileNode__beamOrientation const beamExitOrientation = node_previous.beamExitOrientation;
	switch (beamExitOrientation)
	{
		case SMBBeamEntityTileNode__beamOrientation_none:
			break;

		case SMBBeamEntityTileNode__beamOrientation_up:
			return SMBBeamEntityTileNode__beamOrientation_down;
			break;

		case SMBBeamEntityTileNode__beamOrientation_right:
			return SMBBeamEntityTileNode__beamOrientation_left;
			break;

		case SMBBeamEntityTileNode__beamOrientation_down:
			return SMBBeamEntityTileNode__beamOrientation_up;
			break;

		case SMBBeamEntityTileNode__beamOrientation_left:
			return SMBBeamEntityTileNode__beamOrientation_right;
			break;
	}

	NSAssert(false, @"unhandled beamExitOrientation %li",(long)beamExitOrientation);
	return SMBBeamEntityTileNode__beamOrientation_none;
}

@end





@implementation SMBBeamEntityTileNode_PropertiesForKVO

+(nonnull NSString*)node_next{return NSStringFromSelector(_cmd);}

@end

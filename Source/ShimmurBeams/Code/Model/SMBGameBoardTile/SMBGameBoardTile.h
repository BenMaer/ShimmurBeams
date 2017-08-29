//
//  SMBGameBoardTile.h
//  ShimmurBeams
//
//  Created by Benjamin Maer on 8/3/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#import "SMBDrawableObject.h"
#import "SMBGameBoardTile__directions.h"
#import "SMBGameBoardTile__entityTypes.h"

#import <Foundation/Foundation.h>





@class SMBGameBoardTilePosition;
@class SMBGameBoard;
@class SMBGameBoardTileEntity;





@interface SMBGameBoardTile : SMBDrawableObject

#pragma mark - gameBoardTilePosition
@property (nonatomic, readonly, strong, nullable) SMBGameBoardTilePosition* gameBoardTilePosition;

#pragma mark - gameBoard
@property (nonatomic, readonly, weak, nullable) SMBGameBoard* gameBoard;

#pragma mark - gameBoardTileEntity_for_beamInteractions
@property (nonatomic, readonly, strong, nullable) SMBGameBoardTileEntity* gameBoardTileEntity_for_beamInteractions;

#pragma mark - gameBoardTileEntities_many
@property (nonatomic, readonly, copy, nullable) NSArray<SMBGameBoardTileEntity*>* gameBoardTileEntities_many;

#pragma mark - gameBoardTileEntities
-(void)gameBoardTileEntities_add:(nonnull SMBGameBoardTileEntity*)gameBoardTileEntity
					  entityType:(SMBGameBoardTile__entityType)entityType;
-(void)gameBoardTileEntities_remove:(nonnull SMBGameBoardTileEntity*)gameBoardTileEntity
						 entityType:(SMBGameBoardTile__entityType)entityType;
-(SMBGameBoardTile__entityType)gameBoardTileEntity_currentType:(nonnull SMBGameBoardTileEntity*)gameBoardTileEntity;
-(void)gameBoardTileEntities_remove:(nonnull SMBGameBoardTileEntity*)gameBoardTileEntity;

#pragma mark - init
-(nullable instancetype)init_with_gameBoardTilePosition:(nonnull SMBGameBoardTilePosition*)gameBoardTilePosition
											  gameBoard:(nonnull SMBGameBoard*)gameBoard NS_DESIGNATED_INITIALIZER;

#pragma mark - gameBoardTile
-(nullable SMBGameBoardTile*)gameBoardTile_next_with_direction:(SMBGameBoardTile__direction)direction;

#pragma mark - isPowered
@property (nonatomic, readonly, assign) BOOL isPowered;

#pragma mark - isPowered_notByBeam
@property (nonatomic, readonly, assign) BOOL isPowered_notByBeam;

#pragma mark - beamEnterDirections_blocked
@property (nonatomic, assign) SMBGameBoardTile__direction beamEnterDirections_blocked;

#pragma mark - isHighlighted
@property (nonatomic, assign) BOOL isHighlighted;

@end





@interface SMBGameBoardTile_PropertiesForKVO : NSObject

+(nonnull NSString*)gameBoardTileEntity_for_beamInteractions;
+(nonnull NSString*)gameBoardTileEntities_many;
+(nonnull NSString*)isPowered;
+(nonnull NSString*)isPowered_notByBeam;
+(nonnull NSString*)beamEnterDirections_blocked;

@end

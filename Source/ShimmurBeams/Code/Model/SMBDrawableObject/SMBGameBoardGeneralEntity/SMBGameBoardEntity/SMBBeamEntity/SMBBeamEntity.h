//
//  SMBBeamEntity.h
//  ShimmurBeams
//
//  Created by Benjamin Maer on 8/5/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#import "SMBGameBoardEntity.h"
#import "SMBGameBoardTile__directions.h"





@class SMBBeamEntityTileNode;
@class SMBGameBoardTile;
@class SMBGameBoardTilePosition;





@interface SMBBeamEntity : SMBGameBoardEntity

#pragma mark - gameBoardTilePosition
@property (nonatomic, readonly, strong, nullable) SMBGameBoardTilePosition* gameBoardTilePosition;

#pragma mark - beamEntityTileNode_initial
@property (nonatomic, readonly, strong, nullable) SMBBeamEntityTileNode* beamEntityTileNode_initial;

#pragma mark - beamEntityTileNodes
/**
 A method to determine if this beam entity contains a specific node.

 If you want to KVO on changes to this, use the following KVO values:
 `[SMBBeamEntity_PropertiesForKVO beamEntityTileNode_mappedDataCollection]`

 @param beamEntityTileNode The node to check if exists in this beam.
 @return YES if the node exists in this beam, otherwise NO.
 */
-(BOOL)beamEntityTileNodes_contains:(nonnull SMBBeamEntityTileNode*)beamEntityTileNode;
-(nullable NSArray<SMBBeamEntityTileNode*>*)beamEntityTileNodes_contained_at_position:(nonnull SMBGameBoardTilePosition*)gameBoardTilePosition;
-(nullable NSArray<SMBBeamEntityTileNode*>*)beamEntityTileNodes_contained_at_position:(nonnull SMBGameBoardTilePosition*)gameBoardTilePosition
															   with_beamExitDirection:(SMBGameBoardTile__direction)direction;

#pragma mark - init
-(nullable instancetype)init_with_gameBoardTilePosition:(nonnull SMBGameBoardTilePosition*)gameBoardTilePosition NS_DESIGNATED_INITIALIZER;

@end





@interface SMBBeamEntity_PropertiesForKVO : NSObject

+(nonnull NSString*)beamEntityTileNode_mappedDataCollection;

@end

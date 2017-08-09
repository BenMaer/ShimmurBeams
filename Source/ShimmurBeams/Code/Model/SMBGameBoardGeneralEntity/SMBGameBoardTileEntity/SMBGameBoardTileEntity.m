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





@interface SMBGameBoardTileEntity ()

@end





@implementation SMBGameBoardTileEntity

#pragma mark - gameBoardTile
-(void)setGameBoardTile:(nullable SMBGameBoardTile*)gameBoardTile
{
	kRUConditionalReturn(self.gameBoardTile == gameBoardTile, NO);

	_gameBoardTile = gameBoardTile;

	if ((self.gameBoardTile != nil)
		&&
		(self.gameBoardTile.gameBoardTileEntity != self))
	{
		[self.gameBoardTile setGameBoardTileEntity:self];
	}
}

#pragma mark - entityAction
-(void)entityAction_setup{}

@end





@implementation SMBGameBoardTileEntity_PropertiesForKVO

+(nonnull NSString*)gameBoardEntity{return NSStringFromSelector(_cmd);}
+(nonnull NSString*)needsRedraw{return NSStringFromSelector(_cmd);}

@end

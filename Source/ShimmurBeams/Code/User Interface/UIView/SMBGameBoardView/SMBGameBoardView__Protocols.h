//
//  SMBGameBoardView__Protocols.h
//  ShimmurBeams
//
//  Created by Benjamin Maer on 8/9/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#import <Foundation/Foundation.h>





@class SMBGameBoardView;
@class SMBGameBoardTile;





@protocol SMBGameBoardView_tileTapDelegate <NSObject>

-(void)gameBoardView:(nonnull SMBGameBoardView*)gameBoardView
	  tile_wasTapped:(nonnull SMBGameBoardTile*)gameBoardTile;

@end

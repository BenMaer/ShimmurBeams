//
//  SMBGameBoardTileView__Protocols.h
//  ShimmurBeams
//
//  Created by Benjamin Maer on 8/9/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#import <Foundation/Foundation.h>





@class SMBGameBoardTileView;





@protocol SMBGameBoardTileView__tapDelegate <NSObject>

-(void)gameBoardTileView_wasTapped:(nonnull SMBGameBoardTileView*)gameBoardTileView;

@end

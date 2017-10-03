//
//  SMBGenericPowerOutputTileEntity_OutputPowerReceiver.h
//  ShimmurBeams
//
//  Created by Benjamin Maer on 10/2/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#import <Foundation/Foundation.h>





@class SMBGameBoard;





@interface SMBGenericPowerOutputTileEntity_OutputPowerReceiver : NSObject

#pragma mark - isPowered
@property (nonatomic, assign) BOOL isPowered;

#pragma mark - gameBoard
@property (nonatomic, assign, nullable) SMBGameBoard* gameBoard;

@end

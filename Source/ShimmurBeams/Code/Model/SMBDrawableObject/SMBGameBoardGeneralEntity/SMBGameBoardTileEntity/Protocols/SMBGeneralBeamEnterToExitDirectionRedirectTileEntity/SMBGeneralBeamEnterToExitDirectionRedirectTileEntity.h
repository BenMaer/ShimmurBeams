//
//  SMBGeneralBeamEnterToExitDirectionRedirectTileEntity.h
//  ShimmurBeams
//
//  Created by Benjamin Maer on 8/10/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#import <Foundation/Foundation.h>





@class SMBGameBoardTileBeamEnterToExitDirectionMapping;





/**
 Should only be used on instance of class/subclass of `SMBGameBoardTileEntity`.
 */
@protocol SMBGeneralBeamEnterToExitDirectionRedirectTileEntity <NSObject>

@property (nonatomic, strong, nullable) SMBGameBoardTileBeamEnterToExitDirectionMapping* beamEnterToExitDirectionMapping;

@end

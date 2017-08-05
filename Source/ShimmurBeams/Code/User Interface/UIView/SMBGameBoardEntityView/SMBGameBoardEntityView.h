//
//  SMBGameBoardEntityView.h
//  ShimmurBeams
//
//  Created by Benjamin Maer on 8/4/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#import <UIKit/UIKit.h>





@class SMBGameBoardEntity;





@interface SMBGameBoardEntityView : UIView

#pragma mark - gameBoardEntity
@property (nonatomic, readonly, strong, nullable) SMBGameBoardEntity* gameBoardEntity;

#pragma mark - init
-(nullable instancetype)init_with_gameBoardEntity:(nonnull SMBGameBoardEntity*)gameBoardEntity NS_DESIGNATED_INITIALIZER;

@end

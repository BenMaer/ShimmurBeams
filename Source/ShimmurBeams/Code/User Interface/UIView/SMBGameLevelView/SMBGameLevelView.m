//
//  SMBGameLevelView.m
//  ShimmurBeams
//
//  Created by Benjamin Maer on 8/3/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#import "SMBGameLevelView.h"
#import "SMBGameBoardView.h"
#import "SMBGameLevel.h"

#import <ResplendentUtilities/RUConditionalReturn.h>





@interface SMBGameLevelView ()

#pragma mark - gameBoardView
@property (nonatomic, readonly, strong, nullable) SMBGameBoardView* gameBoardView;
-(CGRect)gameBoardView_frame;

@end





@implementation SMBGameLevelView

#pragma mark - UIView
-(instancetype)initWithFrame:(CGRect)frame
{
	if (self = [super initWithFrame:frame])
	{
		[self setBackgroundColor:[UIColor cyanColor]];

		_gameBoardView = [SMBGameBoardView new];
		[self addSubview:self.gameBoardView];
	}

	return self;
}

-(void)layoutSubviews
{
	[super layoutSubviews];

	[self.gameBoardView setFrame:[self gameBoardView_frame]];
}

#pragma mark - gameLevel
-(void)setGameLevel:(nullable SMBGameLevel*)gameLevel
{
	kRUConditionalReturn(self.gameLevel == gameLevel, NO);

	_gameLevel = gameLevel;

	[self.gameBoardView setGameBoard:self.gameLevel.gameBoard];
}

#pragma mark - gameBoardView
-(CGRect)gameBoardView_frame
{
	return self.bounds;
}

@end

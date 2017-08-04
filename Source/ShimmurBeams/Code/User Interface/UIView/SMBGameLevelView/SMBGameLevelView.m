//
//  SMBGameLevelView.m
//  ShimmurBeams
//
//  Created by Benjamin Maer on 8/3/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#import "SMBGameLevelView.h"

#import <ResplendentUtilities/RUConditionalReturn.h>





@implementation SMBGameLevelView

#pragma mark - UIView
-(instancetype)initWithFrame:(CGRect)frame
{
	if (self = [super initWithFrame:frame])
	{
		[self setBackgroundColor:[UIColor greenColor]];
	}
	
	return self;
}

#pragma mark - gameLevel
-(void)setGameLevel:(nullable SMBGameLevel*)gameLevel
{
	kRUConditionalReturn(self.gameLevel == gameLevel, NO);

	_gameLevel = gameLevel;
}

@end

//
//  SMBGameBoardTileView.m
//  ShimmurBeams
//
//  Created by Benjamin Maer on 8/9/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#import "SMBGameBoardTileView.h"
#import "SMBDrawableObjectView.h"
#import "SMBGameBoardTile.h"

#import <ResplendentUtilities/RUConditionalReturn.h>





@interface SMBGameBoardTileView ()

#pragma mark - drawableObjectView
@property (nonatomic, readonly, strong, nullable) SMBDrawableObjectView* drawableObjectView;
-(CGRect)drawableObjectView_frame;

#pragma mark - tapGestureRecognizer
@property (nonatomic, readonly, strong, nullable) UITapGestureRecognizer* tapGestureRecognizer;
-(void)tapGestureRecognizer_action_didFire;

@end





@implementation SMBGameBoardTileView

#pragma mark - UIView
-(instancetype)initWithFrame:(CGRect)frame
{
	kRUConditionalReturn_ReturnValueNil(YES, YES);
	
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wno-nullability-completeness"
	return [self init_with_gameBoardTile:nil];
#pragma clang diagnostic pop
}

-(instancetype)initWithCoder:(nonnull NSCoder*)aDecoder
{
	kRUConditionalReturn_ReturnValueNil(YES, YES);
	
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wno-nullability-completeness"
	return [self init_with_gameBoardTile:nil];
#pragma clang diagnostic pop
}

#pragma mark - init
-(nullable instancetype)init_with_gameBoardTile:(nonnull SMBGameBoardTile*)gameBoardTile
{
	kRUConditionalReturn_ReturnValueNil(gameBoardTile == nil, YES);
	
	if (self = [super initWithFrame:CGRectZero])
	{
		_gameBoardTile = gameBoardTile;

		_drawableObjectView = [[SMBDrawableObjectView alloc] init_with_drawableObject:self.gameBoardTile];
		[self.drawableObjectView setUserInteractionEnabled:NO];
		[self addSubview:self.drawableObjectView];

		_tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureRecognizer_action_didFire)];
		[self addGestureRecognizer:self.tapGestureRecognizer];
	}
	
	return self;
}

-(void)layoutSubviews
{
	[super layoutSubviews];
	
	[self.drawableObjectView setFrame:[self drawableObjectView_frame]];
}

#pragma mark - drawableObjectView
-(CGRect)drawableObjectView_frame
{
	return self.bounds;
}

#pragma mark - tapGestureRecognizer
-(void)tapGestureRecognizer_action_didFire
{
	id<SMBGameBoardTileView__tapDelegate> const tapDelegate = self.tapDelegate;
	kRUConditionalReturn(tapDelegate == nil, YES);

	[tapDelegate gameBoardTileView_wasTapped:self];
}

@end

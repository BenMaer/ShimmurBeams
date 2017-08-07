//
//  SMBGameBoardTileEntityView.m
//  ShimmurBeams
//
//  Created by Benjamin Maer on 8/4/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#import "SMBGameBoardTileEntityView.h"
#import "SMBGameBoardTileEntity.h"

#import <ResplendentUtilities/RUConditionalReturn.h>





static void* kSMBGameBoardTileEntityView__KVOContext = &kSMBGameBoardTileEntityView__KVOContext;





@interface SMBGameBoardTileEntityView ()

#pragma mark - gameBoardEntity
-(void)gameBoardEntity_setKVORegistered:(BOOL)registered;

@end





@implementation SMBGameBoardTileEntityView

#pragma mark - NSObject
-(void)dealloc
{
	[self gameBoardEntity_setKVORegistered:NO];
}

-(instancetype)initWithFrame:(CGRect)frame
{
	kRUConditionalReturn_ReturnValueNil(YES, YES);

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wno-nullability-completeness"

	return [self init_with_gameBoardEntity:nil];

#pragma clang diagnostic pop
}

#pragma mark - NSCoding
-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
	kRUConditionalReturn_ReturnValueNil(YES, YES);

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wno-nullability-completeness"

	return [self init_with_gameBoardEntity:nil];

#pragma clang diagnostic pop
}

#pragma mark - init
-(nullable instancetype)init_with_gameBoardEntity:(nonnull SMBGameBoardTileEntity*)gameBoardEntity
{
	kRUConditionalReturn_ReturnValueNil(gameBoardEntity == nil, YES);

	if (self = [super initWithFrame:CGRectZero])
	{
		[self setBackgroundColor:[UIColor clearColor]];

		_gameBoardEntity = gameBoardEntity;
		[self gameBoardEntity_setKVORegistered:YES];
	}

	return self;
}

#pragma mark - UIView
-(void)drawRect:(CGRect)rect
{
	[super drawRect:rect];

	SMBGameBoardTileEntity* const gameBoardEntity = self.gameBoardEntity;
	kRUConditionalReturn(gameBoardEntity == nil, YES);

	if (gameBoardEntity.needsRedraw)
	{
		[gameBoardEntity draw_in_rect:rect];
	}
}

#pragma mark - gameBoardEntity
-(void)gameBoardEntity_setKVORegistered:(BOOL)registered
{
	typeof(self.gameBoardEntity) const gameBoardEntity = self.gameBoardEntity;
	kRUConditionalReturn(gameBoardEntity == nil, YES);

	NSMutableArray<NSString*>* const propertiesToObserve = [NSMutableArray<NSString*> array];
	[propertiesToObserve addObject:[SMBGameBoardTileEntity_PropertiesForKVO needsRedraw]];

	[propertiesToObserve enumerateObjectsUsingBlock:^(NSString * _Nonnull propertyToObserve, NSUInteger idx, BOOL * _Nonnull stop) {
		if (registered)
		{
			[gameBoardEntity addObserver:self
							  forKeyPath:propertyToObserve
								 options:(NSKeyValueObservingOptionInitial)
								 context:&kSMBGameBoardTileEntityView__KVOContext];
		}
		else
		{
			[gameBoardEntity removeObserver:self
								 forKeyPath:propertyToObserve
									context:&kSMBGameBoardTileEntityView__KVOContext];
		}
	}];
}

#pragma mark - KVO
-(void)observeValueForKeyPath:(nullable NSString*)keyPath ofObject:(nullable id)object change:(nullable NSDictionary*)change context:(nullable void*)context
{
	if (context == kSMBGameBoardTileEntityView__KVOContext)
	{
		if (object == self.gameBoardEntity)
		{
			if ([keyPath isEqualToString:[SMBGameBoardTileEntity_PropertiesForKVO needsRedraw]])
			{
				[self setNeedsDisplay];
			}
			else
			{
				NSAssert(false, @"unhandled keyPath %@",keyPath);
			}
		}
		else
		{
			NSAssert(false, @"unhandled object %@",object);
		}
	}
	else
	{
		[super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
	}
}

#pragma mark - SMBMappedDataCollection_MappableObject
-(nonnull NSString*)smb_uniqueKey
{
	return [self.gameBoardEntity smb_uniqueKey];
}

@end

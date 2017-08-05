//
//  SMBGameBoardEntityView.m
//  ShimmurBeams
//
//  Created by Benjamin Maer on 8/4/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#import "SMBGameBoardEntityView.h"
#import "SMBGameBoardEntity.h"

#import <ResplendentUtilities/RUConditionalReturn.h>





static void* kSMBGameBoardEntityView__KVOContext = &kSMBGameBoardEntityView__KVOContext;





@interface SMBGameBoardEntityView ()

#pragma mark - gameBoardEntity
-(void)gameBoardEntity_setKVORegistered:(BOOL)registered;

@end





@implementation SMBGameBoardEntityView

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
-(nullable instancetype)init_with_gameBoardEntity:(nonnull SMBGameBoardEntity*)gameBoardEntity
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

	SMBGameBoardEntity* const gameBoardEntity = self.gameBoardEntity;
	kRUConditionalReturn(gameBoardEntity == nil, YES);

	[gameBoardEntity draw_in_rect:rect];
}

#pragma mark - gameBoardEntity
-(void)gameBoardEntity_setKVORegistered:(BOOL)registered
{
	typeof(self.gameBoardEntity) const gameBoardEntity = self.gameBoardEntity;
	kRUConditionalReturn(gameBoardEntity == nil, YES);

	NSMutableArray<NSString*>* const propertiesToObserve = [NSMutableArray<NSString*> array];
	[propertiesToObserve addObject:[SMBGameBoardEntity_PropertiesForKVO needsRedraw]];

	[propertiesToObserve enumerateObjectsUsingBlock:^(NSString * _Nonnull propertyToObserve, NSUInteger idx, BOOL * _Nonnull stop) {
		if (registered)
		{
			[gameBoardEntity addObserver:self
							  forKeyPath:propertyToObserve
								 options:(NSKeyValueObservingOptionInitial)
								 context:&kSMBGameBoardEntityView__KVOContext];
		}
		else
		{
			[gameBoardEntity removeObserver:self
								 forKeyPath:propertyToObserve
									context:&kSMBGameBoardEntityView__KVOContext];
		}
	}];
}

#pragma mark - KVO
-(void)observeValueForKeyPath:(nullable NSString*)keyPath ofObject:(nullable id)object change:(nullable NSDictionary*)change context:(nullable void*)context
{
	if (context == kSMBGameBoardEntityView__KVOContext)
	{
		if (object == self.gameBoardEntity)
		{
			if ([keyPath isEqualToString:[SMBGameBoardEntity_PropertiesForKVO needsRedraw]])
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

@end

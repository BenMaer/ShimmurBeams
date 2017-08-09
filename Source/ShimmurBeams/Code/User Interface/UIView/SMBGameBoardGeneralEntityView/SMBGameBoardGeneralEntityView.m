//
//  SMBGameBoardGeneralEntityView.m
//  ShimmurBeams
//
//  Created by Benjamin Maer on 8/4/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#import "SMBGameBoardGeneralEntityView.h"
#import "SMBGameBoardGeneralEntity.h"

#import <ResplendentUtilities/RUConditionalReturn.h>





static void* kSMBGameBoardGeneralEntityView__KVOContext = &kSMBGameBoardGeneralEntityView__KVOContext;





@interface SMBGameBoardGeneralEntityView ()

#pragma mark - gameBoardGeneralEntity
-(void)gameBoardGeneralEntity_setKVORegistered:(BOOL)registered;

@end





@implementation SMBGameBoardGeneralEntityView

#pragma mark - NSObject
-(void)dealloc
{
	[self gameBoardGeneralEntity_setKVORegistered:NO];
}

-(instancetype)initWithFrame:(CGRect)frame
{
	kRUConditionalReturn_ReturnValueNil(YES, YES);

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wno-nullability-completeness"
	return [self init_with_gameBoardGeneralEntity:nil];
#pragma clang diagnostic pop
}

#pragma mark - NSCoding
-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
	kRUConditionalReturn_ReturnValueNil(YES, YES);

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wno-nullability-completeness"
	return [self init_with_gameBoardGeneralEntity:nil];
#pragma clang diagnostic pop
}

#pragma mark - init
-(nullable instancetype)init_with_gameBoardGeneralEntity:(nonnull SMBGameBoardGeneralEntity*)gameBoardGeneralEntity
{
//	kRUConditionalReturn_ReturnValueNil(gameBoardView == nil, YES);
	kRUConditionalReturn_ReturnValueNil(gameBoardGeneralEntity == nil, YES);

	if (self = [super initWithFrame:CGRectZero])
	{
		[self setBackgroundColor:[UIColor clearColor]];

//		_gameBoardView = gameBoardView;

		_gameBoardGeneralEntity = gameBoardGeneralEntity;
		[self gameBoardGeneralEntity_setKVORegistered:YES];
	}

	return self;
}

#pragma mark - UIView
-(void)drawRect:(CGRect)rect
{
	[super drawRect:rect];

	SMBGameBoardGeneralEntity* const gameBoardGeneralEntity = self.gameBoardGeneralEntity;
	kRUConditionalReturn(gameBoardGeneralEntity == nil, YES);

	if (gameBoardGeneralEntity.needsRedraw)
	{
		CGContextRef const context = UIGraphicsGetCurrentContext();
		
		CGContextSaveGState(context);

		[gameBoardGeneralEntity draw_in_rect:rect];

		CGContextRestoreGState(context);
	}
}

#pragma mark - gameBoardGeneralEntity
-(void)gameBoardGeneralEntity_setKVORegistered:(BOOL)registered
{
	typeof(self.gameBoardGeneralEntity) const gameBoardGeneralEntity = self.gameBoardGeneralEntity;
	kRUConditionalReturn(gameBoardGeneralEntity == nil, YES);

	NSMutableArray<NSString*>* const propertiesToObserve = [NSMutableArray<NSString*> array];
	[propertiesToObserve addObject:[SMBGameBoardGeneralEntity_PropertiesForKVO needsRedraw]];

	[propertiesToObserve enumerateObjectsUsingBlock:^(NSString * _Nonnull propertyToObserve, NSUInteger idx, BOOL * _Nonnull stop) {
		if (registered)
		{
			[gameBoardGeneralEntity addObserver:self
									 forKeyPath:propertyToObserve
										options:(NSKeyValueObservingOptionInitial)
										context:&kSMBGameBoardGeneralEntityView__KVOContext];
		}
		else
		{
			[gameBoardGeneralEntity removeObserver:self
										forKeyPath:propertyToObserve
										   context:&kSMBGameBoardGeneralEntityView__KVOContext];
		}
	}];
}

#pragma mark - KVO
-(void)observeValueForKeyPath:(nullable NSString*)keyPath ofObject:(nullable id)object change:(nullable NSDictionary*)change context:(nullable void*)context
{
	if (context == kSMBGameBoardGeneralEntityView__KVOContext)
	{
		if (object == self.gameBoardGeneralEntity)
		{
			if ([keyPath isEqualToString:[SMBGameBoardGeneralEntity_PropertiesForKVO needsRedraw]])
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
	return [self.gameBoardGeneralEntity smb_uniqueKey];
}

@end

//
//  SMBGameBoardEntity.m
//  ShimmurBeams
//
//  Created by Benjamin Maer on 8/4/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#import "SMBGameBoardEntity.h"
#import "SMBGameBoardTile.h"

#import <ResplendentUtilities/RUConditionalReturn.h>





@interface SMBGameBoardEntity ()

#pragma mark - uniqueEntityId
@property (nonatomic, strong, nullable) NSString* uniqueEntityId;
-(void)uniqueEntityId_generate;
-(nonnull NSString*)uniqueEntityId_generate_initial;
-(nullable NSString*)uniqueEntityId_generate_next:(nonnull NSString*)currentId;

#pragma mark - draw
-(CGFloat)draw_angle_radians;
-(CGFloat)draw_angle_degrees;

@end





@implementation SMBGameBoardEntity

#pragma mark - NSObject
-(instancetype)init
{
	if (self = [super init])
	{
		[self uniqueEntityId_generate];
		kRUConditionalReturn_ReturnValueNil(self.uniqueEntityId == nil, YES);
		kRUConditionalReturn_ReturnValueNil(self.uniqueEntityId.length == 0, YES);

		[self setNeedsRedraw:YES];
	}

	return self;
}

#pragma mark - uniqueEntityId
-(void)uniqueEntityId_generate
{
	static NSString* uniqueEntityId_last = nil;

	NSString* const uniqueEntityId_new =
	(uniqueEntityId_last
	 ?
	 [self uniqueEntityId_generate_next:uniqueEntityId_last]
	 :
	 [self uniqueEntityId_generate_initial]
	);

	kRUConditionalReturn(uniqueEntityId_new == nil, YES);

	uniqueEntityId_last = uniqueEntityId_new;

	[self setUniqueEntityId:uniqueEntityId_new];
}

-(nonnull NSString*)uniqueEntityId_generate_initial
{
	unichar const character = 32;
	return [NSString stringWithCharacters:&character length:1];
}

-(nullable NSString*)uniqueEntityId_generate_next:(nonnull NSString*)currentId
{
	kRUConditionalReturn_ReturnValueNil(currentId == nil, YES);
	kRUConditionalReturn_ReturnValueNil(currentId.length <= 0, YES);

	unichar const character_last = [currentId characterAtIndex:currentId.length - 1];
	unichar const character_next = character_last + 1;

	NSString* const string_suffix =
	(character_next == 0
	 ?
	 [self uniqueEntityId_generate_initial]
	 :
	 [NSString stringWithCharacters:&character_next length:1]
	 );

	NSMutableString* const entityId_next = [NSMutableString stringWithString:currentId];

	if (character_next == 0)
	{
		[entityId_next appendString:string_suffix];
	}
	else
	{
		[entityId_next replaceCharactersInRange:(NSRange){
			.location	= entityId_next.length - 1,
			.length		= 1,
		}
									 withString:string_suffix];
	}

	return [NSString stringWithString:entityId_next];
}

#pragma mark - gameBoardTile
-(void)setGameBoardTile:(nullable SMBGameBoardTile*)gameBoardTile
{
	kRUConditionalReturn(self.gameBoardTile == gameBoardTile, NO);

	_gameBoardTile = gameBoardTile;

	if ((self.gameBoardTile != nil)
		&&
		(self.gameBoardTile.gameBoardEntity != self))
	{
		[self.gameBoardTile setGameBoardEntity:self];
	}
}

#pragma mark - draw
-(void)draw_in_rect:(CGRect)rect
{
	kRUConditionalReturn(self.needsRedraw == NO, NO);

	[self setNeedsRedraw:NO];

	CGContextRef const context = UIGraphicsGetCurrentContext();

	CGContextTranslateCTM(context, CGRectGetMidX(rect), CGRectGetMidY(rect));
	CGContextRotateCTM(context, [self draw_angle_radians]);
	CGContextTranslateCTM(context, -CGRectGetWidth(rect) / 2.0f, -CGRectGetHeight(rect) / 2.0f);
}

-(CGFloat)draw_angle_radians
{
	return ([self draw_angle_degrees] / 180.0f) * M_PI;
}

-(CGFloat)draw_angle_degrees
{
	SMBGameBoardEntity__orientation const orientation = self.orientation;
	switch (orientation)
	{
		case SMBGameBoardEntity__orientation_up:
			return 0.0f;
			break;
		
		case SMBGameBoardEntity__orientation_right:
			return 90.0f;
			break;

		case SMBGameBoardEntity__orientation_down:
			return 180.0f;
			break;

		case SMBGameBoardEntity__orientation_left:
			return -90.0f;
			break;
	}

	NSAssert(false, @"unhandled orientation %li",(long)orientation);
	return 0.0f;
}

#pragma mark - entityAction
-(void)entityAction_setup{}

@end





@implementation SMBGameBoardEntity_PropertiesForKVO

+(nonnull NSString*)gameBoardEntity{return NSStringFromSelector(_cmd);}
+(nonnull NSString*)needsRedraw{return NSStringFromSelector(_cmd);}

@end

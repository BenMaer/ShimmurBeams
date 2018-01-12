//
//  SMBGameLevel.m
//  ShimmurBeams
//
//  Created by Benjamin Maer on 8/3/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#import "SMBGameLevel.h"
#import "SMBGameBoard.h"
#import "NSArray+SMBChanges.h"

#import <ResplendentUtilities/RUConditionalReturn.h>





@interface SMBGameLevel ()

#pragma mark - gameBoardTileEntitySpawnerManager
@property (nonatomic, strong, nullable) SMBGameBoardTileEntitySpawnerManager* gameBoardTileEntitySpawnerManager;

@end

@interface SMBGameLevel_Attributes_For_NSCoding : NSObject
+(nonnull NSString*)gameBoard;
+(nonnull NSString*)gameBoardTileEntitySpawnerManager;
@end





@implementation SMBGameLevel

#pragma mark - NSObject
-(void)dealloc
{
	[self.gameBoard setGameLevel:nil];
}

-(instancetype)init
{
	kRUConditionalReturn_ReturnValueNil(YES, YES);

#if __has_feature(nullability)
#pragma clang diagnostic push
#pragma GCC diagnostic ignored "-Wnullability-completeness"
#endif
	return [self init_with_gameBoard:nil
   gameBoardTileEntitySpawnerManager:nil];
#if __has_feature(nullability)
#pragma clang diagnostic pop
#endif
}

#pragma mark - init
-(nullable instancetype)init_with_gameBoard:(nonnull SMBGameBoard*)gameBoard
		  gameBoardTileEntitySpawnerManager:(nullable SMBGameBoardTileEntitySpawnerManager*)gameBoardTileEntitySpawnerManager
{
	kRUConditionalReturn_ReturnValueNil(gameBoard == nil, YES);

	if (self = [super init])
	{
		_gameBoard = gameBoard;
		[self.gameBoard setGameLevel:self];
		kRUConditionalReturn_ReturnValueNil(self.completion != nil, YES);

		_gameBoardTileEntitySpawnerManager = gameBoardTileEntitySpawnerManager;
	}

	return self;
}

#pragma mark - NSCoding
-(nullable instancetype)initWithCoder:(nonnull NSCoder*)aDecoder
{
	if (self = [self init_with_gameBoard:[aDecoder decodeObjectForKey:[SMBGameLevel_Attributes_For_NSCoding gameBoard]]
	   gameBoardTileEntitySpawnerManager:[aDecoder decodeObjectForKey:[SMBGameLevel_Attributes_For_NSCoding gameBoardTileEntitySpawnerManager]]])
	{
	}
	
	return self;
}

-(void)encodeWithCoder:(nonnull NSCoder*)aCoder
{
	[aCoder encodeObject:self.gameBoard forKey:[SMBGameLevel_Attributes_For_NSCoding gameBoard]];
}

@end





@implementation SMBGameLevel_PropertiesForKVO

+(nonnull NSString*)completion{return NSStringFromSelector(_cmd);}

@end

@implementation SMBGameLevel_Attributes_For_NSCoding
+(nonnull NSString*)gameBoard{return NSStringFromSelector(_cmd);}
+(nonnull NSString*)gameBoardTileEntitySpawnerManager{return NSStringFromSelector(_cmd);}
@end

//
//  SMBLevelEditorCreationData.m
//  ShimmurBeams
//
//  Created by Benjamin Maer on 1/11/18.
//  Copyright © 2018 Shimmur. All rights reserved.
//

#import "SMBLevelEditorCreationData.h"
#import "SMBGameLevelGenerator.h"
#import "SMBGameLevel+SMBLevelEditor.h"





@interface SMBLevelEditorCreationData ()

#pragma mark - gameLevelGenerator
@property (nonatomic, readonly, strong, nullable) SMBGameLevelGenerator* gameLevelGenerator;

@end





@implementation SMBLevelEditorCreationData

#pragma mark - gameLevelGenerator
-(nullable SMBGameLevelGenerator*)gameLevelGenerator_generate
{
	return
	[[SMBGameLevelGenerator alloc] init_with_generateLevelBlock:^SMBGameLevel * _Nonnull{
		return [SMBGameLevel smb_levelEditor_with_numberOfColumns:self.columns
													 numberOfRows:self.rows];
	}
														   name:@"Level Editor"];
}

@end

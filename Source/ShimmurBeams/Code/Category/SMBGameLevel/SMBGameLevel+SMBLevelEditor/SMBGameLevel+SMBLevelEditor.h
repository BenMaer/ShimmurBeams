//
//  SMBGameLevel+SMBLevelEditor.h
//  ShimmurBeams
//
//  Created by Benjamin Maer on 11/8/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#import "SMBGameLevel.h"





@interface SMBGameLevel (SMBLevelEditor)

#pragma mark - levelEditor
+(nonnull instancetype)smb_levelEditor_with_numberOfColumns:(NSUInteger)numberOfColumns
											   numberOfRows:(NSUInteger)numberOfRows;

@end

//
//  NSURL+SMBSavedLevelsPath.h
//  ShimmurBeams
//
//  Created by Benjamin Maer on 1/12/18.
//  Copyright © 2018 Shimmur. All rights reserved.
//

#import <Foundation/Foundation.h>





@interface NSURL (SMBSavedLevelsPath)

+(nullable instancetype)smb_savedLevelsPath;
+(nullable instancetype)smb_savedLevelPath_with_levelName:(nonnull NSString*)levelName;

@end

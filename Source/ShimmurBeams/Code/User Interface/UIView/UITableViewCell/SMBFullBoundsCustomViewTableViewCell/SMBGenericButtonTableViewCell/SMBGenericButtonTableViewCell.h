//
//  SMBGenericButtonTableViewCell.h
//  ShimmurBeams
//
//  Created by Benjamin Maer on 12/7/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#import "SMBFullBoundsCustomViewTableViewCell.h"
#import "SMBGenericButtonTableViewCell__Protocols.h"





@interface SMBGenericButtonTableViewCell : SMBFullBoundsCustomViewTableViewCell

#pragma mark - genericButton
@property (nonatomic, readonly, nullable) UIButton* genericButton;

#pragma mark - genericButtonDelegate
@property (nonatomic, assign, nonnull) id<SMBGenericButtonTableViewCell_genericButtonDelegate> genericButtonDelegate;

@end

//
//  SMBGenericLabelTableViewCell.h
//  ShimmurBeams
//
//  Created by Benjamin Maer on 12/7/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#import "SMBGenericLabelTableViewCell__label_layoutStyles.h"

#import <UIKit/UIKit.h>





@interface SMBGenericLabelTableViewCell : UITableViewCell

#pragma mark - genericLabel
@property (nonatomic, readonly, strong, nullable) UILabel* genericLabel;
@property (nonatomic, assign) UIEdgeInsets genericLabel_frame_insets;
@property (nonatomic, assign) UIOffset genericLabel_frame_offset;
@property (nonatomic, assign) SMBGenericLabelTableViewCell__label_layoutStyle genericLabel_layoutStyle;
-(CGRect)genericLabel_frame;

@end

//
//  SMBFullBoundsCustomViewTableViewCell.h
//  ShimmurBeams
//
//  Created by Benjamin Maer on 12/7/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#import <UIKit/UIKit.h>





@interface SMBFullBoundsCustomViewTableViewCell : UITableViewCell

#pragma mark - fullBoundsCustomView
@property (nonatomic, strong, nullable) UIView* fullBoundsCustomView;
@property (nonatomic, assign) UIEdgeInsets fullBoundsCustomView_edgeInsets;
-(CGRect)fullBoundsCustomView_frame;

@end

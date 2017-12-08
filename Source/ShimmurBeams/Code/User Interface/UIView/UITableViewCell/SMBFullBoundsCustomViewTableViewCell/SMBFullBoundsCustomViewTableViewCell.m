//
//  SMBFullBoundsCustomViewTableViewCell.m
//  ShimmurBeams
//
//  Created by Benjamin Maer on 12/7/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#import "SMBFullBoundsCustomViewTableViewCell.h"

#import <ResplendentUtilities/UIView+RUUtility.h>
#import <ResplendentUtilities/RUClassOrNilUtil.h>
#import <ResplendentUtilities/RUConditionalReturn.h>





@implementation SMBFullBoundsCustomViewTableViewCell

#pragma mark - UIView
-(void)layoutSubviews
{
	[super layoutSubviews];
	
	[self.fullBoundsCustomView setFrame:[self fullBoundsCustomView_frame]];
}

#pragma mark - fullBoundsCustomView
-(void)setFullBoundsCustomView_edgeInsets:(UIEdgeInsets)fullBoundsCustomView_edgeInsets
{
	kRUConditionalReturn(UIEdgeInsetsEqualToEdgeInsets(self.fullBoundsCustomView_edgeInsets, fullBoundsCustomView_edgeInsets), NO);
	
	_fullBoundsCustomView_edgeInsets = fullBoundsCustomView_edgeInsets;
	
	[self setNeedsLayout];
}

-(void)setFullBoundsCustomView:(nullable UIView*)fullBoundsCustomView
{
	kRUConditionalReturn(self.fullBoundsCustomView == fullBoundsCustomView, NO);
	
	if (self.fullBoundsCustomView != nil)
	{
		[self.fullBoundsCustomView removeFromSuperview];
	}
	
	_fullBoundsCustomView = fullBoundsCustomView;
	
	if (self.fullBoundsCustomView)
	{
		[self.contentView addSubview:self.fullBoundsCustomView];
		[self setNeedsLayout];
	}
}

-(CGRect)fullBoundsCustomView_frame
{
	return CGRectCeilOrigin(UIEdgeInsetsInsetRect(self.contentView.bounds, self.fullBoundsCustomView_edgeInsets));
}

@end

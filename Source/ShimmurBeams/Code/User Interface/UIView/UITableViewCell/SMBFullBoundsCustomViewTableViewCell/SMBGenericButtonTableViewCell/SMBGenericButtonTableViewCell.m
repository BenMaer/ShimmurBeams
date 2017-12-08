//
//  SMBGenericButtonTableViewCell.m
//  ShimmurBeams
//
//  Created by Benjamin Maer on 12/7/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#import "SMBGenericButtonTableViewCell.h"

#import <ResplendentUtilities/RUClassOrNilUtil.h>





@interface SMBGenericButtonTableViewCell ()

#pragma mark - genericButton
-(void)genericButton_didTouchUpInside;

@end





@implementation SMBGenericButtonTableViewCell

#pragma mark - UITableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
	if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
	{
		UIButton *genericButton = [UIButton buttonWithType:UIButtonTypeCustom];
		[genericButton addTarget:self action:@selector(genericButton_didTouchUpInside) forControlEvents:UIControlEventTouchUpInside];
		[self setFullBoundsCustomView:genericButton];
	}

	return self;
}

#pragma mark - genericButton
-(nullable UIButton*)genericButton
{
	return kRUClassOrNil(self.fullBoundsCustomView, UIButton);
}

#pragma mark - genericButton
-(void)genericButton_didTouchUpInside
{
	[self.genericButtonDelegate genericButtonTableViewCell_didTouchUpInsideButton:self];
}

@end

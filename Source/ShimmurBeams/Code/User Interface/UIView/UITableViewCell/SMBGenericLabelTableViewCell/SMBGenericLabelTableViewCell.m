//
//  SMBGenericLabelTableViewCell.m
//  ShimmurBeams
//
//  Created by Benjamin Maer on 12/7/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#import "SMBGenericLabelTableViewCell.h"

#import <ResplendentUtilities/RUConditionalReturn.h>
#import <ResplendentUtilities/UIView+RUUtility.h>

#import <RUTextSize/UILabel+RUTextSize.h>





static void* kSMBGenericLabelTableViewCell__KVOContext = &kSMBGenericLabelTableViewCell__KVOContext;





@interface SMBGenericLabelTableViewCell ()

#pragma mark - genericLabel
-(CGRect)genericLabel_frame_layoutStyle_entireCell;
-(CGRect)genericLabel_frame_layoutStyle_textSize;
-(void)genericLabel_setKVORegistered:(BOOL)registered;

#pragma mark - KVO
-(void)observeValueForKeyPath:(nullable NSString*)keyPath ofObject:(nullable id)object change:(nullable NSDictionary*)change context:(nullable void*)context;

@end





@implementation SMBGenericLabelTableViewCell

#pragma mark - NSObject
-(void)dealloc
{
	[self genericLabel_setKVORegistered:NO];
}

#pragma mark - UITableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
	if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
	{
		_genericLabel = [UILabel new];
		[self.contentView addSubview:self.genericLabel];

		[self genericLabel_setKVORegistered:YES];
	}

	return self;
}

#pragma mark - UIView
-(void)layoutSubviews
{
	[super layoutSubviews];

	[self.genericLabel setFrame:self.genericLabel_frame];
}

#pragma mark - genericLabel
-(void)setGenericLabel_frame_insets:(UIEdgeInsets)genericLabel_frame_insets
{
	kRUConditionalReturn(UIEdgeInsetsEqualToEdgeInsets(self.genericLabel_frame_insets, genericLabel_frame_insets), NO);

	_genericLabel_frame_insets = genericLabel_frame_insets;

	[self setNeedsLayout];
}

-(void)setGenericLabel_frame_offset:(UIOffset)genericLabel_frame_offset
{
	kRUConditionalReturn(UIOffsetEqualToOffset(self.genericLabel_frame_offset, genericLabel_frame_offset), NO);

	_genericLabel_frame_offset = genericLabel_frame_offset;

	[self setNeedsLayout];
}

-(void)setGenericLabel_layoutStyle:(SMBGenericLabelTableViewCell__label_layoutStyle)genericLabel_layoutStyle
{
	kRUConditionalReturn(self.genericLabel_layoutStyle == genericLabel_layoutStyle, NO);

	_genericLabel_layoutStyle = genericLabel_layoutStyle;

	[self setNeedsLayout];
}

-(CGRect)genericLabel_frame
{
	SMBGenericLabelTableViewCell__label_layoutStyle const genericLabel_layoutStyle = self.genericLabel_layoutStyle;
	switch (genericLabel_layoutStyle)
	{
		case SMBGenericLabelTableViewCell__label_layoutStyle_entireCell:
			return self.genericLabel_frame_layoutStyle_entireCell;
			break;

		case SMBGenericLabelTableViewCell__label_layoutStyle_textSize:
			return self.genericLabel_frame_layoutStyle_textSize;
			break;
	}

	NSAssert(false, @"unhandled genericLabel_layoutStyle %li",(long)genericLabel_layoutStyle);
	return CGRectZero;
}

-(CGRect)genericLabel_frame_layoutStyle_entireCell
{
	UIOffset const genericLabel_frame_offset = self.genericLabel_frame_offset;

	return CGRectCeilOrigin(UIEdgeInsetsInsetRect((CGRect){
		.origin.x	= genericLabel_frame_offset.horizontal,
		.origin.y	= genericLabel_frame_offset.vertical,
		.size		= self.bounds.size,
	}, self.genericLabel_frame_insets));
}

-(CGRect)genericLabel_frame_layoutStyle_textSize
{
	UIOffset const genericLabel_frame_offset = self.genericLabel_frame_offset;

	CGSize const size = [self.genericLabel ruTextSize];
	CGFloat const xCoord = genericLabel_frame_offset.horizontal;

	return CGRectCeilOrigin(UIEdgeInsetsInsetRect((CGRect){
		.origin.x		= xCoord,
		.origin.y		= genericLabel_frame_offset.vertical,
		.size.width		= MIN(size.width, CGRectGetWidth(self.contentView.bounds) - xCoord),
		.size.height	= size.height
	},
												  self.genericLabel_frame_insets));
}

-(void)genericLabel_setKVORegistered:(BOOL)registered
{
	typeof(self.genericLabel) genericLabel = self.genericLabel;
	kRUConditionalReturn(genericLabel == nil, YES);

	NSMutableArray<NSString*>* const propertiesToObserve = [NSMutableArray<NSString*> array];
	[propertiesToObserve addObject:NSStringFromSelector(@selector(text))];
	[propertiesToObserve addObject:NSStringFromSelector(@selector(attributedText))];

	[propertiesToObserve enumerateObjectsUsingBlock:^(NSString * _Nonnull propertyToObserve, NSUInteger idx, BOOL * _Nonnull stop) {
		if (registered)
		{
			[genericLabel addObserver:self
						   forKeyPath:propertyToObserve
							  options:(0)
							  context:&kSMBGenericLabelTableViewCell__KVOContext];
		}
		else
		{
			[genericLabel removeObserver:self
							  forKeyPath:propertyToObserve
								 context:&kSMBGenericLabelTableViewCell__KVOContext];
		}
	}];
}

#pragma mark - KVO
-(void)observeValueForKeyPath:(nullable NSString*)keyPath ofObject:(nullable id)object change:(nullable NSDictionary*)change context:(nullable void*)context
{
	if (context == kSMBGenericLabelTableViewCell__KVOContext)
	{
		if (object == self.genericLabel)
		{
			if ([keyPath isEqualToString:NSStringFromSelector(@selector(text))])
			{
				[self setNeedsLayout];
			}
			else if ([keyPath isEqualToString:NSStringFromSelector(@selector(attributedText))])
			{
				[self setNeedsLayout];
			}
			else
			{
				NSAssert(false, @"unhandled keyPath %@",keyPath);
			}
		}
		else
		{
			NSAssert(false, @"unhandled object %@",object);
		}
	}
	else
	{
		[super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
	}
}

@end

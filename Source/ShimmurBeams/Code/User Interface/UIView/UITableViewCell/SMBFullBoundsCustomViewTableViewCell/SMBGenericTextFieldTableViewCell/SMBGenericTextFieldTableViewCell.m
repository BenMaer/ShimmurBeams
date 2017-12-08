//
//  SMBGenericTextFieldTableViewCell.m
//  ShimmurBeams
//
//  Created by Benjamin Maer on 12/7/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#import "SMBGenericTextFieldTableViewCell.h"

#import <ResplendentUtilities/UIView+RUUtility.h>
#import <ResplendentUtilities/RUConditionalReturn.h>





@interface SMBGenericTextFieldTableViewCell ()

#pragma mark - nextToolBar
@property (nonatomic, readonly, nullable) UIToolbar* nextToolBar;
-(CGRect)nextToolBar_frame;
-(void)nextToolBar_nextButton_didTouchUpInside;

@end





@implementation SMBGenericTextFieldTableViewCell

#pragma mark - UITableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
	if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
	{
		_nextToolBar = [UIToolbar new];
		[self.nextToolBar setBarStyle:UIBarStyleDefault];
		UIBarButtonItem* const spacer =
		[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
													  target:nil
													  action:nil];
		[self.nextToolBar setItems: [NSArray arrayWithObjects: spacer, [[UIBarButtonItem alloc]
																		initWithTitle:@"Next"
																		style:UIBarButtonItemStyleDone
																		target:self
																		action:@selector(nextToolBar_nextButton_didTouchUpInside)],nil ] animated:YES];
		[self setFullBoundsCustomView:[UIView new]];
		
		_textField = [UITextField new];
		[self.textField setDelegate:self];
		[self.textField addTarget:self
						   action:@selector(textField_textDidChange)
				 forControlEvents:UIControlEventEditingChanged];
		[self.fullBoundsCustomView addSubview:self.textField];
	}
	
	return self;
}

#pragma mark - UIView
-(void)layoutSubviews
{
	[super layoutSubviews];
	
	[self.textField setFrame:self.textField_frame];
	
	[self.nextToolBar setFrame:self.nextToolBar_frame];
}

#pragma mark - UIResponder
-(BOOL)becomeFirstResponder
{
	if ([super becomeFirstResponder])
	{
		return YES;
	}
	
	return [self.textField becomeFirstResponder];
}

-(BOOL)resignFirstResponder
{
	if ([super resignFirstResponder])
	{
		return YES;
	}
	
	return [self.textField resignFirstResponder];
}

-(BOOL)isFirstResponder
{
	return
	(
	 [super isFirstResponder]
	 ||
	 [self.textField isFirstResponder]
	 );
}

#pragma mark - textField
-(CGRect)textField_frame_raw
{
	return CGRectCeilOrigin(UIEdgeInsetsInsetRect(self.fullBoundsCustomView_frame, self.textFieldFrameInsets));
}

-(CGRect)textField_frame
{
	return [self textField_frame_raw];
}

-(void)setTextFieldFrameInsets:(UIEdgeInsets)textFieldFrameInsets
{
	kRUConditionalReturn(UIEdgeInsetsEqualToEdgeInsets(self.textFieldFrameInsets, textFieldFrameInsets), NO);
	
	_textFieldFrameInsets = textFieldFrameInsets;
	
	[self setNeedsLayout];
}

-(void)textField_textDidChange
{
	[self.textChangeDelegate genericTextFieldTableViewCell:self textDidChange:self.textField.text];
}

#pragma mark - UITextFieldDelegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
	if (textField == self.textField)
	{
		if ([self.keyboardDelegate respondsToSelector:@selector(genericTextFieldTableViewCell_shouldReturn:)])
		{
			return [self.keyboardDelegate genericTextFieldTableViewCell_shouldReturn:self];
		}
		
		[self.textField resignFirstResponder];
	}
	else
	{
		NSAssert(false, @"unhandled");
	}
	
	return NO;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
	if ([self.keyboardDelegate respondsToSelector:@selector(genericTextFieldTableViewCell_shouldBeginEditing:)])
	{
		return [self.keyboardDelegate genericTextFieldTableViewCell_shouldBeginEditing:self];
	}
	else
	{
		return YES;
	}
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
	if ([self.keyboardDelegate respondsToSelector:@selector(genericTextFieldTableViewCell_didBeginEditing:)])
	{
		[self.keyboardDelegate genericTextFieldTableViewCell_didBeginEditing:self];
	}
}

-(BOOL)textField:(nonnull UITextField*)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(nonnull NSString*)string
{
	if ([self.textShouldChangeDelegate respondsToSelector:@selector(genericTextFieldTableViewCell:textField:shouldChangeCharactersInRange:replacementString:)])
	{
		return [self.textShouldChangeDelegate genericTextFieldTableViewCell:self textField:textField shouldChangeCharactersInRange:range replacementString:string];
	}
	
	return YES;
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
	if ([self.keyboardDelegate respondsToSelector:@selector(genericTextFieldTableViewCell_didEndEditing:)])
	{
		[self.keyboardDelegate genericTextFieldTableViewCell_didEndEditing:self];
	}
}

#pragma mark - nextToolBar
-(CGRect)nextToolBar_frame
{
	return CGRectCeilOrigin((CGRect){
		.size.width		= CGRectGetWidth([UIScreen mainScreen].bounds),
		.size.height	= 44.0f
	});
}

-(void)nextToolBar_nextButton_didTouchUpInside
{
	[self.nextToolbarDelegate genericTextFieldTableViewCell_nextButtonWasPressed:self];
}

-(BOOL)nextToolBar_visibility
{
	return (self.textField.inputAccessoryView == self.nextToolBar);
}

-(void)setNextToolBar_visibility:(BOOL)nextToolBar_visibility
{
	kRUConditionalReturn(self.nextToolBar_visibility == nextToolBar_visibility, NO);
	
	[self.textField setInputAccessoryView:(nextToolBar_visibility ? self.nextToolBar : nil)];
	
	NSAssert(self.nextToolBar_visibility == nextToolBar_visibility, @"should be");
}

@end

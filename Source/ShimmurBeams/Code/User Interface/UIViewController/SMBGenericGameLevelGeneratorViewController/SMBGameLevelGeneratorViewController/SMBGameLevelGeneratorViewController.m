//
//  SMBGameLevelGeneratorViewController.m
//  ShimmurBeams
//
//  Created by Benjamin Maer on 8/14/17.
//  Copyright © 2017 Shimmur. All rights reserved.
//

#import "SMBGameLevelGeneratorViewController.h"
#import "SMBGameLevelGenerator.h"
#import "SMBGameLevelView.h"
#import "SMBGameLevel.h"
#import "SMBGameLevelCompletion.h"
#import "SMBGameBoard.h"
#import "SMBGameLevelMetaData.h"

#import <ResplendentUtilities/RUConditionalReturn.h>
#import <ResplendentUtilities/UIView+RUUtility.h>
#import <ResplendentUtilities/RUConstants.h>
#import <ResplendentUtilities/NSMutableArray+RUAddObjectIfNotNil.h>





static void* kSMBGameLevelGeneratorViewController__KVOContext__gameLevelGenerator_gameLevel = &kSMBGameLevelGeneratorViewController__KVOContext__gameLevelGenerator_gameLevel;
static void* kSMBGameLevelGeneratorViewController__KVOContext__gameBoard_forKVO = &kSMBGameLevelGeneratorViewController__KVOContext__gameBoard_forKVO;





@interface SMBGameLevelGeneratorViewController ()

#pragma mark - gameLevelGenerator_gameLevel
-(void)gameLevelGenerator_gameLevel_didComplete;
-(void)gameLevelGenerator_gameLevel_didComplete_check;
-(void)gameLevelGenerator_gameLevel_setKVORegistered:(BOOL)registered;

#pragma mark - hintLabel
@property (nonatomic, readonly, strong, nullable) UILabel* hintLabel;
-(CGRect)hintLabel_frame;
-(void)hintLabel_text_update;

#pragma mark - gameLevelView
-(UIEdgeInsets)gameLevelView_frame_insets_generate;

#pragma mark - navigationItem_title
-(void)navigationItem_title_update;
-(nullable NSString*)navigationItem_title_generate;

#pragma mark - levelSuccessBarButtonItem
@property (nonatomic, strong, nullable) UIBarButtonItem* levelSuccessBarButtonItem;
-(void)levelSuccessBarButtonItem_update;
-(nullable UIBarButtonItem*)levelSuccessBarButtonItem_generate;

#pragma mark - leastMovesBarButtonItem
@property (nonatomic, strong, nullable) UIBarButtonItem* leastMovesBarButtonItem;
-(void)leastMovesBarButtonItem_update;
@property (nonatomic, readonly, strong, nullable) UILabel* leastMovesBarButtonItem_label;
-(void)leastMovesBarButtonItem_label_text_update;

#pragma mark - SMBGameLevelGeneratorViewController_gameBoard_forKVO
@property (nonatomic, strong, nullable) SMBGameBoard* SMBGameLevelGeneratorViewController_gameBoard_forKVO;
-(void)SMBGameLevelGeneratorViewController_gameBoard_forKVO_update;
-(nullable SMBGameBoard*)SMBGameLevelGeneratorViewController_gameBoard_forKVO_appropriate;
-(void)SMBGameLevelGeneratorViewController_gameBoard_setKVORegistered:(BOOL)registered;

@end





@implementation SMBGameLevelGeneratorViewController

#pragma mark - NSObject
-(void)dealloc
{
	if (self.isViewLoaded)
	{
		[self gameLevelGenerator_gameLevel_setKVORegistered:NO];
		[self SMBGameLevelGeneratorViewController_gameBoard_setKVORegistered:NO];
	}
}

#pragma mark - UIViewController
-(void)viewDidLoad
{
	[super viewDidLoad];

	[self.navigationItem setLeftItemsSupplementBackButton:YES];

	_hintLabel = [UILabel new];
	[self.hintLabel setFont:[UIFont systemFontOfSize:18.0f]];
	[self.hintLabel setTextColor:[UIColor darkTextColor]];
	[self.hintLabel setBackgroundColor:[UIColor clearColor]];
	[self.hintLabel setNumberOfLines:0];
	[self.view addSubview:self.hintLabel];
	[self hintLabel_text_update];

	[self navigationItem_title_update];

	_leastMovesBarButtonItem_label = [UILabel new];
	[self.leastMovesBarButtonItem_label setFont:[UIFont systemFontOfSize:8.0f]];
	[self.leastMovesBarButtonItem_label setTextColor:[UIColor darkTextColor]];
	[self.leastMovesBarButtonItem_label setBackgroundColor:[UIColor clearColor]];

	[self gameLevelGenerator_gameLevel_setKVORegistered:YES];
	[self SMBGameLevelGeneratorViewController_gameBoard_setKVORegistered:YES];
}

-(void)viewWillLayoutSubviews
{
	[super viewWillLayoutSubviews];

	[self.hintLabel setFrame:[self hintLabel_frame]];

	[self setGameLevelView_frame_insets:[self gameLevelView_frame_insets_generate]];
}

#pragma mark - gameLevelGenerator
-(void)setGameLevelGenerator:(nullable SMBGameLevelGenerator*)gameLevelGenerator
{
	SMBGameLevelGenerator* const gameLevelGenerator_old = self.gameLevelGenerator;
	[super setGameLevelGenerator:gameLevelGenerator];

	kRUConditionalReturn(gameLevelGenerator_old == gameLevelGenerator, NO);

	[self hintLabel_text_update];
	[self navigationItem_title_update];
}

#pragma mark - gameLevelGenerator_gameLevel
-(void)gameLevelGenerator_gameLevel_will_update
{
	[super gameLevelGenerator_gameLevel_will_update];

	if (self.isViewLoaded)
	{
		[self gameLevelGenerator_gameLevel_setKVORegistered:NO];
	}
}

-(void)gameLevelGenerator_gameLevel_did_update
{
	[super gameLevelGenerator_gameLevel_did_update];

	if (self.isViewLoaded)
	{
		[self gameLevelGenerator_gameLevel_setKVORegistered:YES];
	}

	[self SMBGameLevelGeneratorViewController_gameBoard_forKVO_update];
}

-(void)gameLevelGenerator_gameLevel_didComplete
{
	id<SMBGameLevelGeneratorViewController_gameLevelDidCompleteDelegate> const gameLevelDidCompleteDelegate = self.gameLevelDidCompleteDelegate;
	kRUConditionalReturn(gameLevelDidCompleteDelegate == nil, YES);

	SMBGameLevel* const gameLevelGenerator_gameLevel = self.gameLevelGenerator_gameLevel;
	kRUConditionalReturn(gameLevelGenerator_gameLevel == nil, YES);

	[self.view setUserInteractionEnabled:NO];

	/*
	 If the level was successfully completed in less moves than what we thought was the least number of moves... we should probably updates least number of moves.
	 */
	NSAssert((gameLevelGenerator_gameLevel.completion.failureReason != SMBGameLevelCompletion__completionType_success)
			 ||
			 (
			  self.SMBGameLevelGeneratorViewController_gameBoard_forKVO.currentNumberOfMoves
			  >=
			  self.SMBGameLevelGeneratorViewController_gameBoard_forKVO.leastNumberOfMoves
			  ),
			 @"The least number of moves is wrong!");

	[gameLevelDidCompleteDelegate gameLevelGeneratorViewController:self
											  gameLevelDidComplete:gameLevelGenerator_gameLevel];
}

-(void)gameLevelGenerator_gameLevel_didComplete_check
{
	SMBGameBoard* const SMBGameLevelGeneratorViewController_gameBoard_forKVO = self.SMBGameLevelGeneratorViewController_gameBoard_forKVO;
	kRUConditionalReturn(SMBGameLevelGeneratorViewController_gameBoard_forKVO == nil, YES);
	kRUConditionalReturn(SMBGameLevelGeneratorViewController_gameBoard_forKVO.gameBoardMove_isProcessing == YES, NO);

	SMBGameLevel* const gameLevelGenerator_gameLevel = self.gameLevelGenerator_gameLevel;
	kRUConditionalReturn(gameLevelGenerator_gameLevel == nil, YES);

	kRUConditionalReturn(gameLevelGenerator_gameLevel.completion == NO, NO);

	[self gameLevelGenerator_gameLevel_didComplete];
}

-(void)gameLevelGenerator_gameLevel_setKVORegistered:(BOOL)registered
{
	typeof(self.gameLevelGenerator_gameLevel) const gameLevelGenerator_gameLevel = self.gameLevelGenerator_gameLevel;
	kRUConditionalReturn(gameLevelGenerator_gameLevel == nil, NO);

	NSMutableDictionary<NSNumber*,NSMutableArray<NSString*>*>* const KVOOptions_to_propertiesToObserve_mapping = [NSMutableDictionary<NSNumber*,NSMutableArray<NSString*>*> dictionary];

	NSMutableArray<NSString*>* const propertiesToObserve_observe_initial = [NSMutableArray<NSString*> array];
	[propertiesToObserve_observe_initial addObject:[SMBGameLevel_PropertiesForKVO completion]];
	[KVOOptions_to_propertiesToObserve_mapping setObject:propertiesToObserve_observe_initial forKey:@(NSKeyValueObservingOptionInitial)];

	[KVOOptions_to_propertiesToObserve_mapping enumerateKeysAndObjectsUsingBlock:^(NSNumber * _Nonnull KVOOptions_number, NSMutableArray<NSString *> * _Nonnull propertiesToObserve, BOOL * _Nonnull stop) {
		[propertiesToObserve enumerateObjectsUsingBlock:^(NSString * _Nonnull propertyToObserve, NSUInteger idx, BOOL * _Nonnull stop) {
			if (registered)
			{
				[gameLevelGenerator_gameLevel addObserver:self
											 forKeyPath:propertyToObserve
												options:(KVOOptions_number.unsignedIntegerValue)
												context:&kSMBGameLevelGeneratorViewController__KVOContext__gameLevelGenerator_gameLevel];
			}
			else
			{
				[gameLevelGenerator_gameLevel removeObserver:self
												forKeyPath:propertyToObserve
												   context:&kSMBGameLevelGeneratorViewController__KVOContext__gameLevelGenerator_gameLevel];
			}
		}];
	}];
}

#pragma mark - hintLabel
-(CGRect)hintLabel_frame
{
	CGFloat const inset_horizontal = 12.0f;

	return
	CGRectCeilOrigin(UIEdgeInsetsInsetRect((CGRect){
		.size.width		= CGRectGetWidth(self.view.bounds),
		.size.height	= 70.0f,
	},
										   (UIEdgeInsets)
	{
		.left	= inset_horizontal,
		.right	= inset_horizontal,
	}));
}

-(void)hintLabel_text_update
{
	[self.hintLabel setText:self.gameLevelGenerator.gameLevelMetaData.hint];
}

#pragma mark - gameLevelView
-(UIEdgeInsets)gameLevelView_frame_insets_generate
{
	return (UIEdgeInsets){
		.top	= CGRectGetMaxY([self hintLabel_frame]) - CGRectGetMinY(self.view.bounds),
	};
}

#pragma mark - navigationItem_title
-(void)navigationItem_title_update
{
	[self.navigationItem setTitle:[self navigationItem_title_generate]];
}

-(nullable NSString*)navigationItem_title_generate
{
	return self.gameLevelGenerator.gameLevelMetaData.name;
}

#pragma mark - KVO
-(void)observeValueForKeyPath:(nullable NSString*)keyPath ofObject:(nullable id)object change:(nullable NSDictionary*)change context:(nullable void*)context
{
	if (context == kSMBGameLevelGeneratorViewController__KVOContext__gameLevelGenerator_gameLevel)
	{
		if (object == self.gameLevelGenerator_gameLevel)
		{
			if ([keyPath isEqualToString:[SMBGameLevel_PropertiesForKVO completion]])
			{
				[self levelSuccessBarButtonItem_update];

				[self gameLevelGenerator_gameLevel_didComplete_check];
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
	else if (context == kSMBGameLevelGeneratorViewController__KVOContext__gameBoard_forKVO)
	{
		if (object == self.SMBGameLevelGeneratorViewController_gameBoard_forKVO)
		{
			if ([keyPath isEqualToString:[SMBGameBoard_PropertiesForKVO currentNumberOfMoves]])
			{
				[self leastMovesBarButtonItem_label_text_update];

				kRUConditionalReturn(self.SMBGameLevelGeneratorViewController_gameBoard_forKVO.gameBoardMove_isProcessing == YES, YES);

				[self gameLevelGenerator_gameLevel_didComplete_check];
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

#pragma mark - navigationItem_rightBarButtonItems
-(nullable NSArray<UIBarButtonItem*>*)navigationItem_rightBarButtonItems_generate
{
	NSMutableArray<UIBarButtonItem*>* const navigationItem_rightBarButtonItems = [NSMutableArray<UIBarButtonItem*> array];


	NSArray<UIBarButtonItem*>* const navigationItem_rightBarButtonItems_generate_super = [super navigationItem_rightBarButtonItems_generate];
	if (navigationItem_rightBarButtonItems_generate_super)
	{
		[navigationItem_rightBarButtonItems addObjectsFromArray:navigationItem_rightBarButtonItems_generate_super];
	}

	[navigationItem_rightBarButtonItems ru_addObjectIfNotNil:self.levelSuccessBarButtonItem];

	return [NSArray<UIBarButtonItem*> arrayWithArray:navigationItem_rightBarButtonItems];
}

#pragma mark - levelSuccessBarButtonItem
-(void)setLevelSuccessBarButtonItem:(nullable UIBarButtonItem*)levelSuccessBarButtonItem
{
	kRUConditionalReturn(self.levelSuccessBarButtonItem == levelSuccessBarButtonItem, NO);

	_levelSuccessBarButtonItem = levelSuccessBarButtonItem;

	[self navigationItem_rightBarButtonItems_update];
}

-(void)levelSuccessBarButtonItem_update
{
	[self setLevelSuccessBarButtonItem:[self levelSuccessBarButtonItem_generate]];
}

-(nullable UIBarButtonItem*)levelSuccessBarButtonItem_generate
{
	SMBGameLevel* const gameLevelGenerator_gameLevel = self.gameLevelGenerator_gameLevel;
	kRUConditionalReturn_ReturnValueNil(gameLevelGenerator_gameLevel == nil, NO);

	kRUConditionalReturn_ReturnValueNil(gameLevelGenerator_gameLevel.completion == NO, NO);
	kRUConditionalReturn_ReturnValueNil(gameLevelGenerator_gameLevel.completion.failureReason != nil, NO);

	id<SMBGameLevelGeneratorViewController_levelSuccessBarButtonItemDelegate> const levelSuccessBarButtonItemDelegate = self.levelSuccessBarButtonItemDelegate;
	kRUConditionalReturn_ReturnValueNil(levelSuccessBarButtonItemDelegate == nil, YES);

	return [levelSuccessBarButtonItemDelegate gameLevelGeneratorViewController_levelSuccessBarButtonItem:self];
}

#pragma mark - leastMovesBarButtonItem
-(void)setLeastMovesBarButtonItem:(nullable UIBarButtonItem*)leastMovesBarButtonItem
{
	kRUConditionalReturn(self.leastMovesBarButtonItem == leastMovesBarButtonItem, NO);

	_leastMovesBarButtonItem = leastMovesBarButtonItem;

	[self.navigationItem setLeftBarButtonItem:self.leastMovesBarButtonItem];
}

-(void)leastMovesBarButtonItem_update
{
	[self setLeastMovesBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:self.leastMovesBarButtonItem_label]];
}

-(void)leastMovesBarButtonItem_label_text_update
{
	UILabel* const leastMovesBarButtonItem_label = self.leastMovesBarButtonItem_label;
	kRUConditionalReturn(leastMovesBarButtonItem_label == nil, NO);

	NSUInteger const leastNumberOfMoves = self.SMBGameLevelGeneratorViewController_gameBoard_forKVO.leastNumberOfMoves;
	[self.leastMovesBarButtonItem_label setText:
	 ((leastNumberOfMoves > 0)
	  ?
	  RUStringWithFormat(@"%lu (%lu)",
						 (unsigned long)self.SMBGameLevelGeneratorViewController_gameBoard_forKVO.currentNumberOfMoves,
						 (unsigned long)leastNumberOfMoves)
	  :
	  nil
	  )];

	[self.leastMovesBarButtonItem_label sizeToFit];
	[self leastMovesBarButtonItem_update];
}

#pragma mark - SMBGameLevelGeneratorViewController_gameBoard_forKVO
-(void)setSMBGameLevelGeneratorViewController_gameBoard_forKVO:(nullable SMBGameBoard*)SMBGameLevelGeneratorViewController_gameBoard_forKVO
{
	kRUConditionalReturn(self.SMBGameLevelGeneratorViewController_gameBoard_forKVO == SMBGameLevelGeneratorViewController_gameBoard_forKVO, NO);

	if (self.isViewLoaded)
	{
		[self SMBGameLevelGeneratorViewController_gameBoard_setKVORegistered:NO];
	}

	_SMBGameLevelGeneratorViewController_gameBoard_forKVO = SMBGameLevelGeneratorViewController_gameBoard_forKVO;

	if (self.isViewLoaded)
	{
		[self SMBGameLevelGeneratorViewController_gameBoard_setKVORegistered:YES];
	}
}

-(void)SMBGameLevelGeneratorViewController_gameBoard_forKVO_update
{
	[self setSMBGameLevelGeneratorViewController_gameBoard_forKVO:[self SMBGameLevelGeneratorViewController_gameBoard_forKVO_appropriate]];
}

-(nullable SMBGameBoard*)SMBGameLevelGeneratorViewController_gameBoard_forKVO_appropriate
{
	SMBGameLevel* const gameLevelGenerator_gameLevel = self.gameLevelGenerator_gameLevel;
	kRUConditionalReturn_ReturnValueNil(gameLevelGenerator_gameLevel == nil, NO);

	SMBGameBoard* const gameBoard = gameLevelGenerator_gameLevel.gameBoard;
	kRUConditionalReturn_ReturnValueNil(gameBoard == nil, YES);

	return gameBoard;
}

-(void)SMBGameLevelGeneratorViewController_gameBoard_setKVORegistered:(BOOL)registered
{
	typeof(self.SMBGameLevelGeneratorViewController_gameBoard_forKVO) const gameBoard_forKVO = self.SMBGameLevelGeneratorViewController_gameBoard_forKVO;
	kRUConditionalReturn(gameBoard_forKVO == nil, NO);

	NSMutableArray<NSString*>* const propertiesToObserve = [NSMutableArray<NSString*> array];
	[propertiesToObserve addObject:[SMBGameBoard_PropertiesForKVO currentNumberOfMoves]];

	[propertiesToObserve enumerateObjectsUsingBlock:^(NSString * _Nonnull propertyToObserve, NSUInteger idx, BOOL * _Nonnull stop) {
		if (registered)
		{
			[gameBoard_forKVO addObserver:self
							   forKeyPath:propertyToObserve
								  options:(NSKeyValueObservingOptionInitial)
								  context:&kSMBGameLevelGeneratorViewController__KVOContext__gameBoard_forKVO];
		}
		else
		{
			[gameBoard_forKVO removeObserver:self
								  forKeyPath:propertyToObserve
									 context:&kSMBGameLevelGeneratorViewController__KVOContext__gameBoard_forKVO];
		}
	}];
}

@end

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

#import <ResplendentUtilities/RUConditionalReturn.h>
#import <ResplendentUtilities/UIView+RUUtility.h>
#import <ResplendentUtilities/RUConstants.h>
#import <ResplendentUtilities/NSMutableArray+RUAddObjectIfNotNil.h>





static void* kSMBGameLevelGeneratorViewController__KVOContext = &kSMBGameLevelGeneratorViewController__KVOContext;





@interface SMBGameLevelGeneratorViewController ()

#pragma mark - gameLevelGenerator_gameLevel
@property (nonatomic, strong, nullable) SMBGameLevel* gameLevelGenerator_gameLevel;
-(void)gameLevelGenerator_gameLevel_update;
-(nullable SMBGameLevel*)gameLevelGenerator_gameLevel_generate;
-(void)gameLevelGenerator_gameLevel_didComplete;
-(void)gameLevelGenerator_gameLevel_setKVORegistered:(BOOL)registered;

#pragma mark - hintLabel
@property (nonatomic, readonly, strong, nullable) UILabel* hintLabel;
-(CGRect)hintLabel_frame;
-(void)hintLabel_text_update;

#pragma mark - gameLevelView
@property (nonatomic, readonly, strong, nullable) SMBGameLevelView* gameLevelView;
-(CGRect)gameLevelView_frame;
-(void)gameLevelView_level_update;

#pragma mark - navigationItem_title
-(void)navigationItem_title_update;
-(nullable NSString*)navigationItem_title_generate;

#pragma mark - navigationItem_rightBarButtonItems
-(void)navigationItem_rightBarButtonItems_update;
-(nullable NSArray<UIBarButtonItem*>*)navigationItem_rightBarButtonItems_generate;

#pragma mark - navigationItem_resetButton
-(void)navigationItem_resetButton_action_didFire;

#pragma mark - levelSuccessBarButtonItem
@property (nonatomic, strong, nullable) UIBarButtonItem* levelSuccessBarButtonItem;
-(void)levelSuccessBarButtonItem_update;
-(nullable UIBarButtonItem*)levelSuccessBarButtonItem_generate;

#pragma mark - levelSuccessBarButtonItem
@property (nonatomic, readonly, strong, nullable) UIBarButtonItem* resetBarButtonItem;

@end





@implementation SMBGameLevelGeneratorViewController

#pragma mark - NSObject
-(void)dealloc
{
	[self gameLevelGenerator_gameLevel_setKVORegistered:NO];
}

#pragma mark - UIViewController
-(void)viewDidLoad
{
	[super viewDidLoad];

	[self setEdgesForExtendedLayout:UIRectEdgeNone];
	[self setAutomaticallyAdjustsScrollViewInsets:NO];

	[self.view setBackgroundColor:[UIColor whiteColor]];

	_hintLabel = [UILabel new];
	[self.hintLabel setFont:[UIFont systemFontOfSize:18.0f]];
	[self.hintLabel setTextColor:[UIColor darkTextColor]];
	[self.hintLabel setBackgroundColor:[UIColor clearColor]];
	[self.hintLabel setNumberOfLines:0];
	[self.view addSubview:self.hintLabel];
	[self hintLabel_text_update];

	_gameLevelView = [SMBGameLevelView new];
	[self.view addSubview:self.gameLevelView];
	[self gameLevelView_level_update];

	[self navigationItem_title_update];

	_resetBarButtonItem =
	[[UIBarButtonItem alloc] initWithTitle:@"Reset"
									 style:UIBarButtonItemStylePlain
									target:self
									action:@selector(navigationItem_resetButton_action_didFire)];

	[self navigationItem_rightBarButtonItems_update];
}

-(void)viewWillLayoutSubviews
{
	[super viewWillLayoutSubviews];

	[self.hintLabel setFrame:[self hintLabel_frame]];

	[self.gameLevelView setFrame:[self gameLevelView_frame]];
}

#pragma mark - gameLevelGenerator
-(void)setGameLevelGenerator:(nullable SMBGameLevelGenerator*)gameLevelGenerator
{
	kRUConditionalReturn(self.gameLevelGenerator == gameLevelGenerator, NO);

	_gameLevelGenerator = gameLevelGenerator;

	[self hintLabel_text_update];
	[self navigationItem_title_update];
	[self gameLevelGenerator_gameLevel_update];
}

#pragma mark - gameLevelGenerator_gameLevel
-(void)setGameLevelGenerator_gameLevel:(nullable SMBGameLevel*)gameLevelGenerator_gameLevel
{
	kRUConditionalReturn(self.gameLevelGenerator_gameLevel == gameLevelGenerator_gameLevel, NO)

	[self gameLevelGenerator_gameLevel_setKVORegistered:NO];

	_gameLevelGenerator_gameLevel = gameLevelGenerator_gameLevel;

	[self gameLevelGenerator_gameLevel_setKVORegistered:YES];

	[self gameLevelView_level_update];
}

-(void)gameLevelGenerator_gameLevel_update
{
	[self setGameLevelGenerator_gameLevel:[self gameLevelGenerator_gameLevel_generate]];
}

-(nullable SMBGameLevel*)gameLevelGenerator_gameLevel_generate
{
	SMBGameLevelGenerator* const gameLevelGenerator = self.gameLevelGenerator;
	kRUConditionalReturn_ReturnValueNil(gameLevelGenerator == nil, NO);

	return [gameLevelGenerator gameLevel_generate];
}

-(void)gameLevelGenerator_gameLevel_didComplete
{
	id<SMBGameLevelGeneratorViewController_gameLevelDidCompleteDelegate> const gameLevelDidCompleteDelegate = self.gameLevelDidCompleteDelegate;
	kRUConditionalReturn(gameLevelDidCompleteDelegate == nil, YES);

	SMBGameLevel* const gameLevelGenerator_gameLevel = self.gameLevelGenerator_gameLevel;
	kRUConditionalReturn(gameLevelGenerator_gameLevel == nil, YES);

	[self.view setUserInteractionEnabled:NO];

	[gameLevelDidCompleteDelegate gameLevelGeneratorViewController:self
											  gameLevelDidComplete:gameLevelGenerator_gameLevel];
}

-(void)gameLevelGenerator_gameLevel_setKVORegistered:(BOOL)registered
{
	typeof(self.gameLevelGenerator_gameLevel) const gameLevelGenerator_gameLevel = self.gameLevelGenerator_gameLevel;
	kRUConditionalReturn(gameLevelGenerator_gameLevel == nil, NO);

	NSMutableArray<NSString*>* const propertiesToObserve = [NSMutableArray<NSString*> array];
	[propertiesToObserve addObject:[SMBGameLevel_PropertiesForKVO completion]];

	[propertiesToObserve enumerateObjectsUsingBlock:^(NSString * _Nonnull propertyToObserve, NSUInteger idx, BOOL * _Nonnull stop) {
		if (registered)
		{
			[gameLevelGenerator_gameLevel addObserver:self
										   forKeyPath:propertyToObserve
											  options:(NSKeyValueObservingOptionInitial)
											  context:&kSMBGameLevelGeneratorViewController__KVOContext];
		}
		else
		{
			[gameLevelGenerator_gameLevel removeObserver:self
											  forKeyPath:propertyToObserve
												 context:&kSMBGameLevelGeneratorViewController__KVOContext];
		}
	}];
}

-(void)gameLevelGenerator_gameLevel_regenerate
{
	kRUConditionalReturn(self.gameLevelGenerator == nil, YES);
	kRUConditionalReturn(self.gameLevelGenerator_gameLevel == nil, YES);

	[self gameLevelGenerator_gameLevel_update];
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
	[self.hintLabel setText:self.gameLevelGenerator.hint];
}

#pragma mark - gameLevelView
-(CGRect)gameLevelView_frame
{
	CGSize const size = [self.gameLevelView sizeThatFits:self.view.bounds.size];

	return CGRectCeilOrigin((CGRect){
		.origin.x	= CGRectGetHorizontallyAlignedXCoordForWidthOnWidth(size.width, CGRectGetWidth(self.view.bounds)),
		.origin.y	= CGRectGetMaxY([self hintLabel_frame]),
		.size		= size,
	});
}

-(void)gameLevelView_level_update
{
	SMBGameLevelView* const gameLevelView = self.gameLevelView;
	kRUConditionalReturn(gameLevelView == nil, NO);

	[gameLevelView setGameLevel:self.gameLevelGenerator_gameLevel];

	if ([self isViewLoaded])
	{
		[self.view setUserInteractionEnabled:YES];
		[self.view setNeedsLayout];
	}
}

#pragma mark - navigationItem_title
-(void)navigationItem_title_update
{
	[self.navigationItem setTitle:[self navigationItem_title_generate]];
}

-(nullable NSString*)navigationItem_title_generate
{
	return self.gameLevelGenerator.name;
}

#pragma mark - KVO
-(void)observeValueForKeyPath:(nullable NSString*)keyPath ofObject:(nullable id)object change:(nullable NSDictionary*)change context:(nullable void*)context
{
	if (context == kSMBGameLevelGeneratorViewController__KVOContext)
	{
		if (object == self.gameLevelGenerator_gameLevel)
		{
			if ([keyPath isEqualToString:[SMBGameLevel_PropertiesForKVO completion]])
			{
				[self levelSuccessBarButtonItem_update];

				SMBGameLevel* const gameLevelGenerator_gameLevel = self.gameLevelGenerator_gameLevel;
				kRUConditionalReturn(gameLevelGenerator_gameLevel == nil, YES);

				kRUConditionalReturn(gameLevelGenerator_gameLevel.completion == NO, NO);

				[self gameLevelGenerator_gameLevel_didComplete];
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
-(void)navigationItem_rightBarButtonItems_update
{
	[self.navigationItem setRightBarButtonItems:[self navigationItem_rightBarButtonItems_generate]];
}

-(nullable NSArray<UIBarButtonItem*>*)navigationItem_rightBarButtonItems_generate
{
	NSMutableArray<UIBarButtonItem*>* const navigationItem_rightBarButtonItems = [NSMutableArray<UIBarButtonItem*> array];
	[navigationItem_rightBarButtonItems ru_addObjectIfNotNil:self.resetBarButtonItem];
	[navigationItem_rightBarButtonItems ru_addObjectIfNotNil:self.levelSuccessBarButtonItem];

	return [NSArray<UIBarButtonItem*> arrayWithArray:navigationItem_rightBarButtonItems];
}

#pragma mark - navigationItem_resetButton
-(void)navigationItem_resetButton_action_didFire
{
	[self gameLevelGenerator_gameLevel_update];
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

@end

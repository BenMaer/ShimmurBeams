//
//  SMBLevelEditorViewController.m
//  ShimmurBeams
//
//  Created by Benjamin Maer on 1/11/18.
//  Copyright © 2018 Shimmur. All rights reserved.
//

#import "SMBLevelEditorViewController.h"
#import "SMBGameLevelView.h"





@interface SMBLevelEditorViewController ()

#pragma mark - gameLevelView
@property (nonatomic, readonly, strong, nullable) SMBGameLevelView* gameLevelView;
-(CGRect)gameLevelView_frame;
-(void)gameLevelView_level_update;

@end





@implementation SMBLevelEditorViewController

#pragma mark - UIViewController
-(void)viewDidLoad
{
	[super viewDidLoad];
	
	[self setEdgesForExtendedLayout:UIRectEdgeNone];
	[self setAutomaticallyAdjustsScrollViewInsets:NO];
	[self.navigationItem setLeftItemsSupplementBackButton:YES];
	
	[self.view setBackgroundColor:[UIColor whiteColor]];
	
	_gameLevelView = [SMBGameLevelView new];
	[self.view addSubview:self.gameLevelView];
	[self gameLevelView_level_update];
}

-(void)viewWillLayoutSubviews
{
	[super viewWillLayoutSubviews];

	[self.gameLevelView setFrame:[self gameLevelView_frame]];
}

//#pragma mark - gameLevelView
//-(CGRect)gameLevelView_frame
//{
//	CGFloat const yCoord = CGRectGetMaxY([self hintLabel_frame]);
//	CGSize const gameLevelView_boundingSize =
//	UIEdgeInsetsInsetRect(self.view.bounds,
//						  (UIEdgeInsets){
//							  .top	= yCoord,
//						  }).size;
//	
//	CGSize const size = [self.gameLevelView sizeThatFits:gameLevelView_boundingSize];
//	
//	return CGRectCeilOrigin((CGRect){
//		.origin.x	= CGRectGetHorizontallyAlignedXCoordForWidthOnWidth(size.width, gameLevelView_boundingSize.width),
//		.origin.y	= yCoord,
//		.size		= size,
//	});
//}

@end

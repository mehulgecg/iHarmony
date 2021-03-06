//
//  MGSplitCornersView.h
//  MGSplitView
//
//  Created by Matt Gemmell on 28/07/2010.
//  Copyright 2010 Instinctive Code.
//

#import <UIKit/UIKit.h>

int floatsAreEqual(float a, float b);

typedef enum _MGCornersPosition {
	MGCornersPositionLeadingVertical	= 0, // top of screen for a left/right split.
	MGCornersPositionTrailingVertical	= 1, // bottom of screen for a left/right split.
	MGCornersPositionLeadingHorizontal	= 2, // left of screen for a top/bottom split.
	MGCornersPositionTrailingHorizontal	= 3  // right of screen for a top/bottom split.
} MGCornersPosition;

@class MGSplitViewController;
@interface MGSplitCornersView : UIView {
	float cornerRadius_;
	MGSplitViewController *__unsafe_unretained splitViewController_;
	MGCornersPosition cornersPosition_;
	UIColor *cornerBackgroundColor_;
}

@property (nonatomic, assign) float cornerRadius;
@property (nonatomic, unsafe_unretained) MGSplitViewController *splitViewController; // weak ref.
@property (nonatomic, assign) MGCornersPosition cornersPosition; // don't change this manually; let the splitViewController manage it.
@property (nonatomic, strong) UIColor *cornerBackgroundColor;

@end

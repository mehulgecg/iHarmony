//
//  iHDetailTitleView.m
//  iHarmony
//
//  Created by Alberto De Bortoli on 01/11/11.
//  Copyright (c) 2013 iHarmony. All rights reserved.
//

#import "iHDetailTitleView.h"

@implementation iHDetailTitleView
{    
    UILabel *_titleLabel;
    UILabel *_subtitleLabel;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 17)];
        _titleLabel.font = kIHDetailNavigationFont;
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.shadowColor = [UIColor grayColor];
        _titleLabel.shadowOffset = CGSizeMake(0, -1);
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin;
        _titleLabel.minimumScaleFactor = 8.0f/12.0f;
        _titleLabel.adjustsFontSizeToFitWidth = YES;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_titleLabel];
        
        _subtitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 18, 200, 14)];
        _subtitleLabel.font = kIHDetailNavigationSubtitleFont;
        _subtitleLabel.textColor = [UIColor whiteColor];
        _subtitleLabel.shadowColor = [UIColor grayColor];
        _subtitleLabel.shadowOffset = CGSizeMake(0, -1);
        _subtitleLabel.backgroundColor = [UIColor clearColor];
        _subtitleLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin;
        _subtitleLabel.minimumScaleFactor = 6.0f/12.0f;
        _subtitleLabel.adjustsFontSizeToFitWidth = YES;
        _subtitleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_subtitleLabel];
    }
    return self;
}

- (void)drawTitle:(NSString *)title subtitle:(NSString *)subtitle
{
    _titleLabel.text = title;
    _subtitleLabel.text = subtitle;
}

@end

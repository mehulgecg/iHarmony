//
//  iHSlider.m
//  iHarmony
//
//  Created by Alberto De Bortoli on 9/29/12.
//
//

#import "iHSlider.h"
#import "Constants.h"

@implementation iHSlider

- (id)initWithFrame:(CGRect)frame delegate:(id <DCControlDelegate>)delegate
{
    self = [super initWithDelegate:delegate];
    
    if (self) {
        self.frame = frame;
        self.handleSize = 45.0f;
        self.isHorizontalSlider = YES;
        self.labelFont = [UIFont boldSystemFontOfSize:14.0];
        self.labelColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
        self.color = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:1.0];
        self.backgroundColor = [UIColor clearColor];
        self.cornerRadius = 13.0f;
        self.displaysValue = YES;
        self.labelFont = kIHDetailNavigationSubtitleFont;
        self.backgroundColorAlpha = 0.4f;
    }
    
    return self;
}

- (void)setFrame:(CGRect)frame
{
	CGFloat tmp = self.handleSize;
    [super setFrame:frame];
	self.handleSize = tmp;
}

- (void)drawRect:(CGRect)rect
{
	CGContextRef context = UIGraphicsGetCurrentContext();
	CGRect boundsRect = self.bounds;
	const CGFloat *colorComponents = CGColorGetComponents(self.color.CGColor);
	UIColor *backgroundColor = [UIColor colorWithRed:colorComponents[0]
											   green:colorComponents[1]
												blue:colorComponents[2]
											   alpha:self.backgroundColorAlpha];
	UIColor *lighterBackgroundColor = [UIColor colorWithRed:colorComponents[0]
                                                      green:colorComponents[1]
                                                       blue:colorComponents[2]
                                                      alpha:self.backgroundColorAlpha / 2.0];
    
	// draw background of slider
	[lighterBackgroundColor set];
	[self context:context addRoundedRect:boundsRect cornerRadius:self.cornerRadius];
	CGContextFillPath(context);
    
	// draw the 'filled' section to the left of the handle (or from the handle if in bidirectional mode)
	CGRect valueRect;
	[backgroundColor set];
	if (self.isHorizontalSlider)
	{
		CGFloat handlePos = CGRectGetMinX([self rectForHandle]);
		CGFloat handleMid = CGRectGetMidX([self rectForHandle]);
		CGFloat handleMax = CGRectGetMaxX([self rectForHandle]);
		if (self.biDirectional)
		{
			if (self.value > (self.max - self.min) / 2)
				valueRect = CGRectMake(self.bounds.size.width / 2.0, 0, handleMid - self.bounds.size.width / 2.0, self.bounds.size.height);
			else
				valueRect = CGRectMake(handleMid, 0, (self.bounds.size.width - handleMid - self.bounds.size.width / 2.0), self.bounds.size.height);
			[self context:context addRoundedRect:valueRect cornerRadius:0];
		}
		else
		{
			valueRect = CGRectMake(0, 0, self.bounds.size.width - (self.bounds.size.width - handleMax), self.bounds.size.height);
			[self context:context addRoundedRect:valueRect cornerRadius:self.cornerRadius];
		}
        
		CGContextFillPath(context);
        
		valueRect = CGRectMake(handlePos, 0, self.handleSize, self.bounds.size.height);
	}
	else
	{
		// draw the 'filled' section below the handle (or from the handle if in bidirectional mode) using a colour slightly lighter than the theme
		CGFloat handlePos = CGRectGetMinY([self rectForHandle]);
		CGFloat handleMid = CGRectGetMidY([self rectForHandle]);
		CGFloat handleMin = CGRectGetMinY([self rectForHandle]);
		if (self.biDirectional)
		{
			if (self.value > (self.max - self.min) / 2)
				valueRect = CGRectMake(0, handleMid, self.bounds.size.width, self.bounds.size.height / 2.0 - handleMid);
			else
				valueRect = CGRectMake(0, self.bounds.size.height / 2.0, self.bounds.size.width, handleMid - self.bounds.size.height / 2.0);
			[self context:context addRoundedRect:valueRect cornerRadius:0];
		}
		else
		{
			valueRect = CGRectMake(0, handleMin, self.bounds.size.width, self.bounds.size.height - handleMin);
			[self context:context addRoundedRect:valueRect cornerRadius:self.cornerRadius];
		}
        
		CGContextFillPath(context);
        
		valueRect = CGRectMake(0, handlePos, self.bounds.size.width, self.handleSize);
	}
    
	// draw the handle
	[self.color set];
	[self context:context addRoundedRect:valueRect cornerRadius:self.cornerRadius];
	CGContextFillPath(context);
    
	// draw value string as needed
	if (self.displaysValue)
	{
		[self.labelColor set];
		NSString *valueString = nil;
		if (self.biDirectional)
			valueString = [NSString stringWithFormat:@"%0.02f s", self.value];
		else
			valueString = [NSString stringWithFormat:@"%0.02f s", self.value];
        
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        
		CGSize valueStringSize = [valueString sizeWithFont:self.labelFont];
		CGRect handleRect = [self rectForHandle];
		[valueString drawInRect:CGRectMake(handleRect.origin.x + (handleRect.size.width - valueStringSize.width) / 2,
										   handleRect.origin.y + (handleRect.size.height - valueStringSize.height) / 2,
										   valueRect.size.width,
										   valueRect.size.height)
					   withFont:self.labelFont
				  lineBreakMode:NSLineBreakByTruncatingTail];

#pragma clang diagnostic pop
        
	}
}

@end

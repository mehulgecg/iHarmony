//
//  iHItemiPhoneDetailViewController.h
//  iHarmony
//
//  Created by Alberto De Bortoli on 29/09/2013.
//
//

#import "iHDetailViewController.h"

@interface iHItemiPhoneDetailViewController : iHDetailViewController

@property (nonatomic, strong) NSMutableArray *tableViews;

- (instancetype)initWithIndex:(NSUInteger)index;

@end

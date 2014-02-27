//
//  RUScrollWithKeyboardAdjustmentView.h
//  Resplendent
//
//  Created by Benjamin Maer on 12/21/13.
//  Copyright (c) 2013 Resplendent G.P.. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RUKeyboardAdjustmentHelperProtocols.h"





@interface RUScrollWithKeyboardAdjustmentView : UIView <RUKeyboardAdjustmentHelperDelegate>
{
    UIScrollView* _scrollView;
    
    RUKeyboardAdjustmentHelper* _keyboardHelper;
}

@property (nonatomic, assign) CGFloat scrollViewBottomKeyboardPadding;

@property (nonatomic, readonly) CGSize scrollViewContentSize;
@property (nonatomic, readonly) CGFloat scrollViewContentSizeHeight;

-(void)addSubviewToScrollView:(UIView*)view;

@end

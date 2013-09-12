//
//  RUImageViewFullscreenRotatingView.m
//  Pineapple
//
//  Created by Benjamin Maer on 9/10/13.
//  Copyright (c) 2013 Pineapple. All rights reserved.
//

#import "RUImageViewFullscreenRotatingView.h"

CGFloat const kRUImageViewFullscreenRotatingViewDefaultShowAnimationDuration = 0.4f;

@interface RUImageViewFullscreenRotatingView ()

@property (nonatomic, readonly) CGRect imageViewFrame;

@end

@implementation RUImageViewFullscreenRotatingView

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self setShowAnimationDuration:kRUImageViewFullscreenRotatingViewDefaultShowAnimationDuration];
    }

    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

#pragma mark - Frames
-(CGRect)imageViewFrame
{
    CGSize adjustedContentViewSize = self.adjustedContentViewFrame.size;
//    CGRect newFrame = self.bounds;

    CGRect newFrame = (CGRect){0,0,adjustedContentViewSize};
//    if (_animationTransitionImageView.contentMode == UIViewContentModeScaleAspectFill)
//    {
//        switch ([UIDevice currentDevice].orientation)
//        {
//            case UIInterfaceOrientationLandscapeLeft:
//            case UIInterfaceOrientationLandscapeRight:
//                newFrame.size = adjustedContentViewSize;
////                newFrame.size.height = CGRectGetWidth(self.bounds);
////                newFrame.size.width = _animationTransitionImageView.image.size.width * (CGRectGetHeight(newFrame) / _animationTransitionImageView.image.size.height);
//                break;
//                
//            default:
//                newFrame.size.width = CGRectGetWidth(self.bounds);
//                newFrame.size.height = CGRectGetHeight(self.bounds);
////                newFrame.size.height = _animationTransitionImageView.image.size.height * (CGRectGetWidth(newFrame) / _animationTransitionImageView.image.size.width);
//                break;
//        }
//    }
    
    switch ([UIDevice currentDevice].orientation)
    {
        case UIInterfaceOrientationLandscapeLeft:
        case UIInterfaceOrientationLandscapeRight:
            newFrame.origin.y = floorf((adjustedContentViewSize.height - CGRectGetHeight(newFrame)) / 2.0f);
            newFrame.origin.x = floorf((adjustedContentViewSize.width - CGRectGetWidth(newFrame)) / 2.0f);
            break;
            
        default:
            newFrame.origin.y = floorf((adjustedContentViewSize.height - CGRectGetHeight(newFrame)) / 2.0f);
            break;
    }
    
    return newFrame;
}

#pragma mark - Animation Transition View
-(void)addAnimationTransitionViewWithImageView:(UIImageView*)imageView
{
    if (imageView.image)
    {
        _animationTransitionImageView = [[UIImageView alloc]initWithImage:imageView.image];
        [_animationTransitionImageView setContentMode:imageView.contentMode];
        [_animationTransitionImageView setClipsToBounds:YES];
        [_contentView addSubview:_animationTransitionImageView];
    }
}

-(void)removeAnimationTransitionView
{
    if (_animationTransitionImageView)
    {
        [_animationTransitionImageView removeFromSuperview];
        _animationTransitionImageView = nil;
    }
}

#pragma mark - Show
-(void)showWithImageView:(UIImageView*)imageView completion:(void (^)(BOOL didShow))completion
{
    if (self.readyToShow)
    {
        _sourceImageView = imageView;
        [self addAnimationTransitionViewWithImageView:imageView];

        [self showWithCompletion:^(BOOL didShow) {
            [imageView setHidden:NO];
            [_animationTransitionImageView setAlpha:0.0f];
            if (completion)
                completion(didShow);
        }];
    }
    else
    {
        [self removeAnimationTransitionView];
        if (completion)
            completion(NO);
    }
}

#pragma mark - Overloaded
-(void)willPerformShowAnimation
{
    [super willPerformShowAnimation];

    [_sourceImageView setHidden:YES];

    _convertedOriginalFrame = [_sourceImageView convertRect:_sourceImageView.frame toView:self];
    [_animationTransitionImageView setFrame:_convertedOriginalFrame];

    _sourceImageView = nil;
}

-(void)performShowAnimation
{
    [super performShowAnimation];
    [_animationTransitionImageView setFrame:self.imageViewFrame];
}

-(BOOL)preparedToShow
{
    return [super preparedToShow] && (_animationTransitionImageView != nil);
}

-(void)willPerformHideAnimation
{
    [super willPerformHideAnimation];
}

@end

//
//  FBFAnimation.h
//  FBFAnimation
//
//  Created by Masaki Hirokawa on 2013/04/03.
//  Copyright (c) 2013年 Masaki Hirokawa. All rights reserved.
//

#import <UIKit/UIKit.h>

#define ANIM_FPS                24.0f
#define ANIM_IMAGE_X            0
#define ANIM_IMAGE_Y            0
#define ANIM_IMAGE_WIDTH        320
#define ANIM_IMAGE_HEIGHT       480
#define ANIM_IMAGE_HEIGHT_4INCH 568
#define ANIM_IMAGE_EXT          @"png"

@protocol FrameByFrameAnimationDelegate;

@interface FrameByFrameAnimation : UIImageView {
    id<FrameByFrameAnimationDelegate> _fa_delegate;
}

@property (nonatomic, assign) id<FrameByFrameAnimationDelegate> fa_delegate;
@property (nonatomic, retain) UIImageView *animationImageView;

- (id)init;
- (void)setAnimating:(NSString *)animationType :(NSInteger)animationImageNum :(NSString *)animationImagePrefix :(NSInteger)animationRepeatNum;
- (void)setFps:(float)fps;
- (void)resetFps;
- (void)setRectangle:(CGRect)rect;
- (void)resetRectangle;

@end

#pragma mark delegate prottype
@protocol FrameByFrameAnimationDelegate<NSObject>
@optional

@end

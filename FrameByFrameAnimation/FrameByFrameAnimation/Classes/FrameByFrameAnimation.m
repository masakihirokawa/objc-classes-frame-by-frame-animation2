//
//  FBFAnimation.m
//  FBFAnimation
//
//  Created by Masaki Hirokawa on 2013/04/03.
//  Copyright (c) 2013年 Masaki Hirokawa. All rights reserved.
//

#import "FrameByFrameAnimation.h"

@implementation FrameByFrameAnimation

@synthesize fa_delegate;
@synthesize animationImageView  = _animationImageView;

NSInteger _animationImageX      = ANIM_IMAGE_X;
NSInteger _animationImageY      = ANIM_IMAGE_Y;
NSInteger _animationImageWidth  = ANIM_IMAGE_WIDTH;
NSInteger _animationImageHeight = ANIM_IMAGE_HEIGHT;
CGFloat   _animationFps         = ANIM_FPS;
NSString *_animationImageExt    = ANIM_IMAGE_EXT;
NSString *_animationType;

//アニメーション設定
- (void)setAnimating:(NSString *)animationType
                    :(NSInteger)animationImageNum
                    :(NSString *)animationImagePrefix
                    :(NSInteger)animationRepeatNum
{
    //アニメーションの種類を保持
    _animationType = animationType;
    
    //イメージビュー初期化
    _animationImageView = [[UIImageView alloc] initWithFrame:CGRectMake(_animationImageX,
                                                                        _animationImageY,
                                                                        _animationImageWidth,
                                                                        _animationImageHeight)];
    
    //最後の画像が消えないようにする
    _animationImageView.image = [FrameByFrameAnimation getUIImageFromResources:[self animationImageName:animationImagePrefix:animationImageNum]
                                                                           ext:_animationImageExt];
    
    //画像をタップ可能にする
    _animationImageView.userInteractionEnabled = YES;
    
    //アニメーションフレームを配列に入れる
    NSMutableArray *animationImageArray = [NSMutableArray array];
    for (int i = 1; i <= animationImageNum; i++) {
        [animationImageArray addObject:[self animationImageName:animationImagePrefix:i]];
    }
    _animationImageView.animationImages = [self animationImages:animationImageArray];
    
    //アニメーションの秒数を設定
    _animationImageView.animationDuration = [self animationSeconds:animationImageNum];
    
    //アニメーションのリピート回数を設定
    _animationImageView.animationRepeatCount = animationRepeatNum;
    
    //アニメーション開始
    [_animationImageView startAnimating];
    
    //アニメーション終了時のメソッド定義
    [self performSelector:@selector(animationDidFinish:)
               withObject:nil
               afterDelay:_animationImageView.animationDuration];
}

//アニメーション終了時のメソッド
- (void)animationDidFinish:(id)selector
{
    if ([_animationType isEqualToString:@"sample"]) {
        //ここでデリゲートメソッドを呼ぶことができます
        
    }
}

//fps指定
- (void)setFps:(CGFloat)fps
{
    _animationFps = fps;
}

//fpsリセット
- (void)resetFps
{
    _animationFps = ANIM_FPS;
}

//レクタングル指定
- (void)setRectangle:(CGRect)rect
{
    _animationImageX = rect.origin.x;
    _animationImageY = rect.origin.y;
    _animationImageWidth = rect.size.width;
    _animationImageHeight = rect.size.height;
}

//レクタングルリセット
- (void)resetRectangle
{
    [self setRectangle:CGRectMake(ANIM_IMAGE_X,
                                  ANIM_IMAGE_Y,
                                  ANIM_IMAGE_WIDTH,
                                  ANIM_IMAGE_HEIGHT)];
}

//アニメーション秒数を取得
- (CGFloat)animationSeconds:(NSInteger)animationImageNum
{
    return (animationImageNum / _animationFps);
}

//アニメーション画像を取得
- (NSString *)animationImageName:(NSString *)animationImageSuffix
                                :(int)animationFrame
{
    return ([NSString stringWithFormat:@"%@%@", animationImageSuffix, [NSString stringWithFormat:@"%d", animationFrame]]);
}

//画像ファイル名を配列で取得する
- (NSArray *)animationImages:(NSMutableArray *)animationImageNameList
{
    //画像の配列を作成
    NSMutableArray *imageArray = [NSMutableArray array];
    for (int i = 0; i < animationImageNameList.count; i++) {
        NSString *imageTitle = [animationImageNameList objectAtIndex:i];
        
        //画像の配列に画像ファイルを追加
        [imageArray addObject:[FrameByFrameAnimation getUIImageFromResources:imageTitle
                                                                         ext:_animationImageExt]];
    }
    return (imageArray);
}

+ (UIImage *)getUIImageFromResources:(NSString*)fileName ext:(NSString*)ext
{
	NSString *path = [[NSBundle mainBundle] pathForResource:fileName ofType:ext];
	UIImage *img = [[UIImage alloc] initWithContentsOfFile:path];
	return (img);
}

@end

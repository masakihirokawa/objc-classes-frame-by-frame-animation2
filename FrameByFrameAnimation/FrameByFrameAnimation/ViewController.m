//
//  ViewController.m
//  FBFAnimation
//
//  Created by 廣川政樹 on 2013/04/03.
//  Copyright (c) 2013年 Dolice. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //アニメーション開始
	[self startAnimation];
}

//アニメーション開始
- (void)startAnimation
{
    //クラス初期化
    FrameByFrameAnimation *fbfAnimation = [[FrameByFrameAnimation alloc] init];
    
    //fps変更 (指定がない場合は 24fpsになります)
    [fbfAnimation setFps:24.0f];
    
    //アニメーション画像のレクタングル指定 (指定がない場合は W320*H480pxになります)
    [fbfAnimation setRectangle:CGRectMake(self.view.center.x - (IMAGE_WIDTH / 2),
                                          self.view.center.y - (IMAGE_HEIGHT / 2),
                                          IMAGE_WIDTH,
                                          IMAGE_HEIGHT)];
    
    //クラス側のデリゲートに渡す
    fbfAnimation.fa_delegate = (id)self;
    
    //アニメーションのタイプ (アニメーション終了時の処理を分岐させる時に指定します)
    NSString *animationType = @"sample";
    
    //アニメーションの総フレーム数
    NSInteger animationFrames = 14;
    
    //アニメーションファイルの接頭詞
    NSString *animationPrefix = @"frame";
    
    //アニメーションのリピート回数 (0の場合は無限ループします)
    NSInteger animationRepeatNum = 0;
    
    //アニメーション開始
    [fbfAnimation setAnimating:animationType
                              :animationFrames
                              :animationPrefix
                              :animationRepeatNum];
   
    //タグを指定 (省いても問題ありません)
    [fbfAnimation animationImageView].tag = 0;
    
    //ステージに追加
    [self.view addSubview:[fbfAnimation animationImageView]];
}

@end

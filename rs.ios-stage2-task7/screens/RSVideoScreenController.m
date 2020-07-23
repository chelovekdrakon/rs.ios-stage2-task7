//
//  RSVideoScreenController.m
//  rs.ios-stage2-task7
//
//  Created by Фёдор Морев on 7/23/20.
//  Copyright © 2020 Фёдор Морев. All rights reserved.
//

#import "RSVideoScreenController.h"
#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>

@interface RSVideoScreenController ()
@property (nonatomic, strong) RSTedVideoContent *video;
@property (nonatomic, strong) AVPlayerViewController *playerVC;
@end

@implementation RSVideoScreenController

- (instancetype)initWithRSVideo:(RSTedVideoContent *)video {
    self = [super init];
    if (self) {
        _video = video;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.playerVC = [[AVPlayerViewController alloc] init];
    self.playerVC.player = [AVPlayer playerWithURL:self.video.videoUrl];
    self.playerVC.view.frame = self.view.bounds;
    self.playerVC.showsPlaybackControls = YES;

    [self.view addSubview:self.playerVC.view];
    self.view.autoresizesSubviews = YES;
}

@end

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
    [self layoutScreen];
}

- (void)viewWillAppear:(BOOL)animated {
    self.navigationController.navigationBar.hidden = NO;
    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(pop)];
    backButton.tintColor = [UIColor lightGrayColor];
    self.navigationItem.leftBarButtonItem = backButton;
}

- (void)layoutScreen {
    UIImage *image;
    if (self.video.imageData) {
        image = [UIImage imageWithData:self.video.imageData];
    } else {
        NSData *imageData = [NSData dataWithContentsOfURL:self.video.imageUrl];
        image = [UIImage imageWithData:imageData];
        self.video.imageData = imageData;
    }
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    imageView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:imageView];
    
    UIButton *playButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100.0f, 100.0f)];
    [playButton setTitle:@"PLAY" forState:UIControlStateNormal];
    playButton.titleLabel.font = [UIFont systemFontOfSize:24.0f weight:UIFontWeightBold];
    playButton.translatesAutoresizingMaskIntoConstraints = NO;
    [playButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [playButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    playButton.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.8f];
    playButton.layer.cornerRadius = 40.0f;
    playButton.clipsToBounds = true;
    [self.view addSubview:playButton];
    [playButton addTarget:self action:@selector(handlePlayPress:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.font = [UIFont systemFontOfSize:20.0f weight:UIFontWeightBold];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.numberOfLines = 0;
    titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    titleLabel.text = self.video.title;
    [titleLabel sizeToFit];
    [self.view addSubview:titleLabel];
    
    UILabel *subtitleLabel = [[UILabel alloc] init];
    subtitleLabel.font = [UIFont systemFontOfSize:14.0f weight:UIFontWeightRegular];
    subtitleLabel.textColor = [UIColor lightGrayColor];
    subtitleLabel.numberOfLines = 0;
    subtitleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    subtitleLabel.text = self.video.title;
    [subtitleLabel sizeToFit];
    [self.view addSubview:subtitleLabel];
    
    UIButton *likeButton = [UIButton new];
    [likeButton setTitle:self.video.favorite ? @"Dislike" : @"Like" forState:UIControlStateNormal];
    likeButton.titleLabel.font = [UIFont systemFontOfSize:18.0f weight:UIFontWeightMedium];
    likeButton.translatesAutoresizingMaskIntoConstraints = NO;
    [likeButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [likeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [likeButton.titleLabel sizeToFit];
    [self.view addSubview:likeButton];
    [likeButton addTarget:self action:@selector(handleLikePress:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *shareButton = [UIButton new];
    [shareButton setTitle:@"Share" forState:UIControlStateNormal];
    shareButton.titleLabel.font = [UIFont systemFontOfSize:18.0f weight:UIFontWeightMedium];
    shareButton.translatesAutoresizingMaskIntoConstraints = NO;
    [shareButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [shareButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [shareButton.titleLabel sizeToFit];
    [self.view addSubview:shareButton];
    [shareButton addTarget:self action:@selector(handleSharePress:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *detailsLabel = [[UILabel alloc] init];
    detailsLabel.font = [UIFont systemFontOfSize:14.0f weight:UIFontWeightRegular];
    detailsLabel.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.8f];
    detailsLabel.numberOfLines = 0;
    detailsLabel.translatesAutoresizingMaskIntoConstraints = NO;
    detailsLabel.text = self.video.details;
    [detailsLabel sizeToFit];
    [self.view addSubview:detailsLabel];
    
    [NSLayoutConstraint activateConstraints:@[
        [imageView.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor],
        [imageView.leadingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.leadingAnchor],
        [imageView.trailingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.trailingAnchor],
        
        [playButton.centerXAnchor constraintEqualToAnchor:imageView.centerXAnchor],
        [playButton.centerYAnchor constraintEqualToAnchor:imageView.centerYAnchor],
        [playButton.widthAnchor constraintEqualToConstant:80.0f],
        [playButton.heightAnchor constraintEqualToConstant:80.0f],
        
        [titleLabel.topAnchor constraintEqualToAnchor:imageView.bottomAnchor],
        [titleLabel.leadingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.leadingAnchor constant:16.0f],
        [titleLabel.trailingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.trailingAnchor constant:-16.0f],
        
        [subtitleLabel.topAnchor constraintEqualToAnchor:titleLabel.bottomAnchor constant:8.0f],
        [subtitleLabel.leadingAnchor constraintEqualToAnchor:titleLabel.leadingAnchor],
        [subtitleLabel.trailingAnchor constraintEqualToAnchor:titleLabel.trailingAnchor],
        
        [likeButton.topAnchor constraintEqualToAnchor:subtitleLabel.bottomAnchor constant:18.0f],
        [likeButton.leadingAnchor constraintEqualToAnchor:titleLabel.leadingAnchor],
        
        [likeButton.topAnchor constraintEqualToAnchor:subtitleLabel.bottomAnchor constant:18.0f],
        [likeButton.leadingAnchor constraintEqualToAnchor:titleLabel.leadingAnchor],
        
        [shareButton.topAnchor constraintEqualToAnchor:likeButton.topAnchor],
        [shareButton.leadingAnchor constraintEqualToAnchor:likeButton.trailingAnchor constant:8.0f],
        
        [detailsLabel.topAnchor constraintEqualToAnchor:likeButton.bottomAnchor constant:16.0f],
        [detailsLabel.leadingAnchor constraintEqualToAnchor:titleLabel.leadingAnchor],
        [detailsLabel.trailingAnchor constraintEqualToAnchor:titleLabel.trailingAnchor],
    ]];
}

- (void)pop {
    [self.navigationController popViewControllerAnimated:YES];
}
                            
#pragma mark - Handlers

- (void)handleLikePress:(UIButton *)button {
    [button setTitle:self.video.favorite ? @"Like" : @"Dislike" forState:UIControlStateNormal];
    self.video.favorite = !self.video.favorite;
}

- (void)handleSharePress:(UIButton *)button {
    NSLog(@"Share!");
}

- (void)handlePlayPress:(UIButton *)button {
    [self.navigationController pushViewController:self.playerVC animated:YES];
}

- (AVPlayerViewController *)playerVC {
    if (!_playerVC) {
        _playerVC = [[AVPlayerViewController alloc] init];
        _playerVC.player = [AVPlayer playerWithURL:self.video.videoUrl];
        _playerVC.view.frame = self.view.bounds;
        _playerVC.showsPlaybackControls = YES;
    }
    return _playerVC;
}

@end

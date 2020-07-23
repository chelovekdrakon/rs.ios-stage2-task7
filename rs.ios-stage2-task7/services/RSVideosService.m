//
//  RSNetworkService.m
//  rs.ios-stage2-task7
//
//  Created by Фёдор Морев on 7/22/20.
//  Copyright © 2020 Фёдор Морев. All rights reserved.
//

#import "RSVideosService.h"
#import "RSTedXMLParser.h"

@interface RSVideosService () <NSURLSessionDownloadDelegate>
@property (nonatomic, strong) RSTedXMLParser *parser;
@property (nonatomic, strong) NSMutableArray<RSTedVideoContent *> *videos;

@property (nonatomic, copy) void (^onDownloadComplete)(NSURL *path, NSError *error);
@end

@implementation RSVideosService

- (instancetype)init {
    self = [super init];
    if (self) {
        NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]
                                                              delegate:self
                                                         delegateQueue:nil];
        
        
        _session = session;
        _parser = [RSTedXMLParser new];
    }
    return self;
}

+ (RSVideosService *)sharedService {
    static RSVideosService *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [RSVideosService new];
    });
    return sharedMyManager;
}

- (void)getVideos:(void (^)(NSMutableArray <RSTedVideoContent *> *videos, NSError *error))completion {
    if (self.videos) {
        completion(self.videos, nil);
    }
    
    NSURL *url = [NSURL URLWithString:@"https://www.ted.com/themes/rss/id"];
    
    __weak typeof(self) weakSelf = self;
    
    NSURLSessionDataTask *dataTask = [self.session dataTaskWithURL:url
                                                 completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            completion(nil, error);
            return;
        }
        
        [self.parser parseVideos:data
                      completion:^(NSMutableArray<RSTedVideoContent *> * _Nonnull videos, NSError * _Nonnull error) {
            weakSelf.videos = videos;
            completion(videos, error);
        }];
    }];
    
    [dataTask resume];
}

- (void)downloadVideoFromUrl:(NSURL *)url completion:(void (^)(NSURL *path, NSError *error))completion {
    self.onDownloadComplete = completion;
    
    NSURLSessionDownloadTask *downloadingTask = [self.session downloadTaskWithURL:url];
    [downloadingTask resume];
}

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error {
    if (self.onDownloadComplete) {
        self.onDownloadComplete(nil, error);
        self.onDownloadComplete = nil;
    }
}

- (void)URLSession:(NSURLSession *)session didBecomeInvalidWithError:(NSError *)error {
    if (self.onDownloadComplete) {
        self.onDownloadComplete(nil, error);
        self.onDownloadComplete = nil;
    }
}

- (void)URLSession:(nonnull NSURLSession *)session downloadTask:(nonnull NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(nonnull NSURL *)location {
    if (self.onDownloadComplete) {
        self.onDownloadComplete(location, nil);
        self.onDownloadComplete = nil;
    }
}

@end

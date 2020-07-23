//
//  RSNetworkService.m
//  rs.ios-stage2-task7
//
//  Created by Фёдор Морев on 7/22/20.
//  Copyright © 2020 Фёдор Морев. All rights reserved.
//

#import "RSVideosService.h"
#import "RSTedXMLParser.h"

@interface RSVideosService ()
@property (nonatomic, strong) RSTedXMLParser *parser;
@end

@implementation RSVideosService

- (instancetype)init {
    self = [super init];
    if (self) {
        _session = [NSURLSession sharedSession];
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

- (void)loadVideos:(void (^)(NSMutableArray <RSTedVideoContent *> *videos, NSError *error))completion {
    NSURL *url = [NSURL URLWithString:@"https://www.ted.com/themes/rss/id"];
    
    NSURLSessionDataTask *dataTask = [self.session dataTaskWithURL:url
                                                 completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            completion(nil, error);
            return;
        }
        
        [self.parser parseVideos:data completion:completion];
    }];
    
    [dataTask resume];
}

@end

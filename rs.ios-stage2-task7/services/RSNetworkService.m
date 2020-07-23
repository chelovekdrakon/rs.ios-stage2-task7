//
//  RSNetworkService.m
//  rs.ios-stage2-task7
//
//  Created by Фёдор Морев on 7/22/20.
//  Copyright © 2020 Фёдор Морев. All rights reserved.
//

#import "RSVideosService.h"

@interface RSVideosService

@end

@implementation RSVideosService

- (instancetype)init {
    self = [super init];
    if (self) {
        _session = [NSURLSession sharedSession];
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

- (void)performGetRequestForUrl:(NSString *)urlString
                      arguments:(NSDictionary *)argumets
                     completion:(void (^)(NSDictionary *, NSError *))completion {
    NSURLComponents *urlComponent = [NSURLComponents componentsWithString:urlString];
    
    if (argumets) {
        NSMutableArray <NSURLQueryItem *> *queryItems = [NSMutableArray array];
        for (NSString *key in argumets) {
            NSURLQueryItem *item = [NSURLQueryItem queryItemWithName:key value:argumets[key]];
            [queryItems addObject:item];
        }
        urlComponent.queryItems = queryItems;
    }
    
    NSURL *url = urlComponent.URL;
    
    NSURLSessionDataTask *dataTask = [self.session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            completion(nil, error);
            return;
        }
        
        
    }];
}

@end

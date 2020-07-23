//
//  RSTedXMLParser.m
//  rs.ios-stage2-task7
//
//  Created by Фёдор Морев on 7/22/20.
//  Copyright © 2020 Фёдор Морев. All rights reserved.
//

#import "RSTedXMLParser.h"

@interface RSTedXMLParser() <NSXMLParserDelegate>
@property (nonatomic, copy) void (^completion)(NSMutableArray <RSTedVideoContent *> *videos, NSError *error);
@property (nonatomic, strong) NSMutableArray <RSTedVideoContent *> *videos;
@property (nonatomic, strong) NSMutableDictionary *videoDictionary;
@property (nonatomic, strong) NSMutableString *parsingString;
@end

@implementation RSTedXMLParser

- (void)parseVideos:(NSData *)data completion:(void (^)(NSMutableArray <RSTedVideoContent *> *videos, NSError *error))completion {
    self.completion = completion;
    NSXMLParser *parser = [[NSXMLParser alloc] initWithData:data];
    parser.delegate = self;
    [parser parse];
}

- (void)resetParserState {
    self.completion = nil;
    self.videos = nil;
    self.parsingString = nil;
    self.videoDictionary = nil;
}

#pragma mark - NSXMLParser Delegate

- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError {
    if (self.completion) {
        self.completion(nil, parseError);
    }
    
    [self resetParserState];
}

- (void)parserDidStartDocument:(NSXMLParser *)parser {
    self.videos = [NSMutableArray array];
}

- (void)parserDidEndDocument:(NSXMLParser *)parser {
    if (self.completion) {
        self.completion(self.videos, nil);
    }
    
    [self resetParserState];
}

- (void)parser:(NSXMLParser *)parser
didStartElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qName
    attributes:(NSDictionary<NSString *,NSString *> *)attributeDict {
    if ([elementName isEqualToString:@"item"]) {
        
        self.videoDictionary = [NSMutableDictionary new];
        
    } else if (self.videoDictionary != nil) {
        
        if ([elementName isEqualToString:@"title"]) {
            self.parsingString = [NSMutableString new];
        } else if ([elementName isEqualToString:@"description"]) {
            self.parsingString = [NSMutableString new];
        } else if ([elementName isEqualToString:@"media:credit"] && [attributeDict[@"role"] isEqualToString:@"speaker"]) {
            self.parsingString = [NSMutableString new];
            self.videoDictionary[@"authors"] = [NSMutableArray array];
            self.parsingString = [NSMutableString new];
        } else if ([elementName isEqualToString:@"media:thumbnail"]) {
            self.videoDictionary[@"imageThumbnailUrl"] = [NSURL URLWithString:attributeDict[@"url"]];
        } else if ([elementName isEqualToString:@"itunes:duration"]) {
            self.parsingString = [NSMutableString new];
        } else if ([elementName isEqualToString:@"itunes:image"]) {
            self.videoDictionary[@"imageUrl"] = [NSURL URLWithString:attributeDict[@"url"]];
        } else if ([elementName isEqualToString:@"enclosure"]) {
            self.videoDictionary[@"videoUrl"] = [NSURL URLWithString:attributeDict[@"url"]];
        }
        
            
        
    }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    if (self.videoDictionary != nil && self.parsingString != nil) {
        [self.parsingString appendString:string];
    }
}

- (void)parser:(NSXMLParser *)parser
 didEndElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qName {
    if (self.videoDictionary != nil && self.parsingString != nil) {
        
        if ([elementName isEqualToString:@"title"]) {
            NSString *title = [self.parsingString componentsSeparatedByString:@" | "].firstObject;
            self.videoDictionary[@"title"] = title;
            self.parsingString = nil;
        } else if ([elementName isEqualToString:@"description"]) {
            self.videoDictionary[@"details"] = self.parsingString;
            self.parsingString = nil;
        } else if ([elementName isEqualToString:@"media:credit"]) {
            [self.videoDictionary[@"authors"] addObject:self.parsingString];
            self.parsingString = nil;
        } else if ([elementName isEqualToString:@"itunes:duration"]) {
            self.videoDictionary[@"duration"] = self.parsingString;
            self.parsingString = nil;
        }
        
    } else if ([elementName isEqualToString:@"item"]) {
        RSTedVideoContent *video = [[RSTedVideoContent alloc] initWithDictionary:self.videoDictionary];
        [self.videos addObject:video];
        self.videoDictionary = nil;
    }
}

@end

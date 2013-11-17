//
//  KRAClient.h
//  KRANetworking
//
//  Created by Olivier Larivain on 11/16/13.
//  Copyright (c) 2013 kra. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "KRARequestSerializer.h"
#import "KRARequestDeserializer.h"

@interface KRAHTTPClient : NSObject

@property (nonatomic) NSDictionary *defaultHeaders;
@property (nonatomic) id<KRARequestSerializer> requestSerializer;
@property (nonatomic) id<KRARequestDeserializer> requestDeserializer;

- (instancetype) initWithBaseURL: (NSString *) baseURL;
- (instancetype) initWithBaseURL: (NSString *) baseURL
				   configuration: (NSURLSessionConfiguration *) configuration;

- (void) get:(NSString *) pathOrURL
  parameters:(NSDictionary *) parameters
	 success:(KRARequestSuccessBlock) success
	 failure:(KRARequestErrorBlock) failure;

- (void) get:(NSString *) pathOrURL
	 headers:(NSDictionary *) headers
  parameters:(NSDictionary *) parameters
	 success:(KRARequestSuccessBlock) success
	 failure:(KRARequestErrorBlock) failure;

@end

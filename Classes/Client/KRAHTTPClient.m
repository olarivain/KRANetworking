//
//  KRAClient.m
//  KRANetworking
//
//  Created by Olivier Larivain on 11/16/13.
//  Copyright (c) 2013 kra. All rights reserved.
//
#import "KRANetworking.h"

#import "KRAHTTPClient.h"
#import "KRAHTTPClient_Protected.h"

@implementation KRAHTTPClient

- (instancetype) initWithBaseURL: (NSString *) baseURL
{
	return [self initWithBaseURL:baseURL configuration:[NSURLSessionConfiguration ephemeralSessionConfiguration]];
}

- (instancetype) initWithBaseURL: (NSString *) baseURL
				   configuration: (NSURLSessionConfiguration *) configuration
{
	self = [super init];
	if(self)
	{
		self.baseURL = [NSURL URLWithString: baseURL];
		self.session = [NSURLSession sessionWithConfiguration: configuration];
	}
	
	return self;
}

- (void) get: (NSString *) pathOrURL
  parameters: (NSDictionary *) parameters
	 success: (KRARequestSuccessBlock) success
	   error: (KRARequestErrorBlock) error
{
	[self get:pathOrURL headers:nil parameters:parameters success:success error:error];
	
}

- (void) get: (NSString *) pathOrURL
	 headers: (NSDictionary *) headers
  parameters: (NSDictionary *) parameters
	 success: (KRARequestSuccessBlock) success
	   error: (KRARequestErrorBlock) error
{
	NSURLRequest *request = [self requestForPathOrURL:pathOrURL method:@"GET" headers:headers parameters:parameters];
	NSURLSessionDataTask *task = [self.session dataTaskWithRequest:request];
	[task resume];
}

-(NSURLRequest *) requestForPathOrURL:(NSString *)pathOrURL
							   method:(NSString *)method
							  headers:(NSDictionary *)headers
						   parameters:(NSDictionary *)parameters
{
	// build the URL
	NSURL *url = [self URLForPathOrURL: pathOrURL];
	
	// the headers
	NSMutableDictionary *allHeaders = [NSMutableDictionary dictionaryWithDictionary:headers];
	[allHeaders addEntriesFromDictionary: self.defaultHeaders];
	
	return [self.requestSerializer URLRequest:url method:method headers:allHeaders parameters:parameters];
}

#pragma mark - Building URLs
- (NSURL *)URLForPathOrURL: (NSString *) pathOrURL
{
	if(self.baseURL)
	{
		return [NSURL URLWithString:pathOrURL relativeToURL:self.baseURL];
	}
	
	return [NSURL URLWithString: pathOrURL];
}

@end

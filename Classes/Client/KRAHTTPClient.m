//
//  KRAClient.m
//  KRANetworking
//
//  Created by Olivier Larivain on 11/16/13.
//  Copyright (c) 2013 kra. All rights reserved.
//
#import "KRANetworking.h"

#import "KRAHTTPClient.h"

#import "KRAHTTPSeralizer.h"
#import "KRAHTTPDeserializer.h"

#define DispatchMainThread(block, ...) if(block) dispatch_async(dispatch_get_main_queue(), ^{ block(__VA_ARGS__); })
#define InvokeBlock(block, ...) if(block) block(__VA_ARGS__)

@interface KRAHTTPClient ()

@property (nonatomic) NSURL *baseURL;
@property (nonatomic) NSURLSession *session;
@property (nonatomic) NSOperationQueue *callbackQueue;

@end

@implementation KRAHTTPClient

- (instancetype) initWithBaseURL:(NSString *) baseURL
{
	return [self initWithBaseURL:baseURL configuration:[NSURLSessionConfiguration ephemeralSessionConfiguration]];
}

- (instancetype) initWithBaseURL:(NSString *) baseURL
				   configuration:(NSURLSessionConfiguration *) configuration
{
	self = [super init];
	if(self)
	{
		self.callbackQueue = [[NSOperationQueue alloc] init];
		self.callbackQueue.maxConcurrentOperationCount = 6;
		
		self.baseURL = [NSURL URLWithString: baseURL];
		self.session = [NSURLSession sessionWithConfiguration: configuration delegate:nil delegateQueue:self.callbackQueue];
	}
	
	return self;
}

#pragma mark - lazy getters/setters
-(id<KRARequestSerializer>) requestSerializer
{
	if (_requestSerializer == nil)
	{
		_requestSerializer = [[KRAHTTPSeralizer alloc] init];
	}
	
	return _requestSerializer;
}

-(id<KRARequestDeserializer>) requestDeserializer
{
	if(_requestDeserializer == nil)
	{
		_requestDeserializer = [[KRAHTTPDeserializer alloc] init];
	}
	
	return _requestDeserializer;
}

#pragma mark - public network API
- (void) get:(NSString *) pathOrURL
  parameters:(NSDictionary *) parameters
	 success:(KRARequestSuccessBlock) success
	 failure:(KRARequestErrorBlock) failure
{
	[self get:pathOrURL headers:nil parameters:parameters success:success failure:failure];
	
}

- (void) get:(NSString *) pathOrURL
	 headers:(NSDictionary *) headers
  parameters:(NSDictionary *) parameters
	 success:(KRARequestSuccessBlock) success
	 failure:(KRARequestErrorBlock) failure
{
	NSURLRequest *request = [self requestForPathOrURL:pathOrURL method:@"GET" headers:headers parameters:parameters];
	[[self.session dataTaskWithRequest:request
					 completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
						 [self sessionTaskDidFinish:response data:data error:error success:success failure:failure];
					 }] resume];
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
	
	// now ask our request serializer to build the NSURLRequest
	return [self.requestSerializer URLRequest:url method:method headers:allHeaders parameters:parameters];
}

#pragma mark - response handling
-(void) sessionTaskDidFinish:(NSURLResponse *)response
						data:(NSData *)data
					   error:(NSError *)error
					 success:(KRARequestSuccessBlock) success
					 failure:(KRARequestErrorBlock) failure
{

	if(![response isKindOfClass: NSHTTPURLResponse.class] && error == nil)
	{
		DispatchMainThread(success, response, data);
		return;
	}
	
	NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
	id parsedData = [self.requestDeserializer parseResponse:httpResponse data:data];
	
	NSError *finalError = error ?: [self errorFromResponse: httpResponse];
	if(finalError != nil)
	{
		DispatchMainThread(failure, response, parsedData, finalError);
		return;
	}
	
	DispatchMainThread(success, response, parsedData);
}

-(NSError *) errorFromResponse:(NSHTTPURLResponse *)response
{
	if(response.statusCode >= 200 && response.statusCode <= 299)
	{
		return nil;
	}
	
	return [NSError errorWithDomain:@"KRA" code:-1000 userInfo:nil];
}

#pragma mark - Building URLs
- (NSURL *)URLForPathOrURL:(NSString *) pathOrURL
{
	if(self.baseURL)
	{
		return [NSURL URLWithString:pathOrURL relativeToURL:self.baseURL];
	}
	
	return [NSURL URLWithString: pathOrURL];
}

@end

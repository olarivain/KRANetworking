//
//  KRAHTTPSeralizer.m
//  KRANetworking
//
//  Created by Olivier Larivain on 11/16/13.
//  Copyright (c) 2013 kra. All rights reserved.
//

#import "KRAHTTPSeralizer.h"

@implementation KRAHTTPSeralizer

-(id) init
{
	self = [super init];
	if(self)
	{
		self.timeoutDelay = 60;
	}
	
	return self;
}

#pragma mark - getters/setters
-(void) setTimeoutDelay:(NSTimeInterval)timeoutDelay
{
	NSAssert(timeoutDelay >= 0, @"KRAHTTPSerializer timeoutDelay must be bigger than 0.");
	_timeoutDelay = timeoutDelay;
}

#pragma mark - Request building
-(NSURLRequest *) URLRequest:(NSURL *)url
					  method:(NSString *)method
					 headers:(NSDictionary *)headers
				  parameters:(NSDictionary *)parameters
{
	NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
														   cachePolicy:NSURLCacheStorageAllowedInMemoryOnly
													   timeoutInterval:self.timeoutDelay];
	[request setHTTPMethod: method];
	[request setAllHTTPHeaderFields: headers];
	
	//TODO add parameters
	
	return request;
}

@end

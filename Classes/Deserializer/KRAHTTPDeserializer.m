//
//  KRAHTTPDeserializer.m
//  KRANetworking
//
//  Created by Olivier Larivain on 11/16/13.
//  Copyright (c) 2013 kra. All rights reserved.
//

#import "KRAHTTPDeserializer.h"

@implementation KRAHTTPDeserializer

-(id) parseResponse:(NSHTTPURLResponse *)response data:(NSData *)data
{
	NSString *contentType = [response.allHeaderFields objectForKey:@"Content-Type"];
	
	if ([self isJSON:contentType])
	{
		return [self parseJSON:data];
	}
	
	return data;
}

#pragma mark
-(BOOL)isJSON:(NSString *)contentType
{
	return [contentType rangeOfString: @"application/json"].location != NSNotFound
	|| [contentType rangeOfString: @"application/javascript"].location != NSNotFound
	|| [contentType rangeOfString: @"application/ecmascript"].location != NSNotFound
	|| [contentType rangeOfString: @"text/javascript"].location != NSNotFound;
}

-(id)parseJSON:(NSData *)data
{
	// NSJSONSerialization is not nil safe, so bail out if there is no data in
	if(data == nil)
	{
		return nil;
	}
	
	NSError *error = nil;
	id json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
	
	if(error != nil)
	{
		NSLog(@"Ran into error will parsing json: %@", error.localizedDescription);
	}
	
	return json;
}

@end

//
//  KRAHTTPSerializer.h
//  KRANetworking
//
//  Created by Olivier Larivain on 11/16/13.
//  Copyright (c) 2013 kra. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol KRARequestSerializer <NSObject>

-(NSURLRequest *) URLRequest:(NSURL *)url
					  method:(NSString *)method
					 headers:(NSDictionary *)headers
				  parameters:(NSDictionary *)parameters;

@end

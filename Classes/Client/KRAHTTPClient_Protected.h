//
//  KRANetworkingClient_Protected.h
//  KRANetworking
//
//  Created by Olivier Larivain on 11/16/13.
//  Copyright (c) 2013 kra. All rights reserved.
//

#import "KRAHTTPClient.h"

@interface KRAHTTPClient ()

@property (nonatomic) NSURL *baseURL;
@property (nonatomic) NSURLSession *session;

@end

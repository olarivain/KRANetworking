//
//  KRAClient.h
//  KRANetworking
//
//  Created by Olivier Larivain on 11/16/13.
//  Copyright (c) 2013 kra. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "KRARequestSerializer.h"

@interface KRAHTTPClient : NSObject

@property (nonatomic) NSDictionary *defaultHeaders;
@property (nonatomic) id<KRARequestSerializer> requestSerializer;

@end

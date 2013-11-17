//
//  KRANetworking.h
//  KRANetworking
//
//  Created by Olivier Larivain on 11/16/13.
//  Copyright (c) 2013 kra. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^KRARequestSuccessBlock)(NSURLSessionTask *task);
typedef void(^KRARequestErrorBlock)(NSURLSessionTask *task, NSError *error);
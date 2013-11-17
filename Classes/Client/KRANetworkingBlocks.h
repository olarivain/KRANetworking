//
//  KRANetworking.h
//  KRANetworking
//
//  Created by Olivier Larivain on 11/16/13.
//  Copyright (c) 2013 kra. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^KRARequestSuccessBlock)(NSURLResponse *task, id data);
typedef void(^KRARequestErrorBlock)(NSURLResponse *task, id data, NSError *error);

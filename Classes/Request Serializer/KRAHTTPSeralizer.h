//
//  KRAHTTPSeralizer.h
//  KRANetworking
//
//  Created by Olivier Larivain on 11/16/13.
//  Copyright (c) 2013 kra. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "KRARequestSerializer.h"

@interface KRAHTTPSeralizer : NSObject<KRARequestSerializer>

@property (nonatomic) NSTimeInterval timeoutDelay;

@end

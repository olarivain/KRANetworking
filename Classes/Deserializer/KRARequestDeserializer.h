//
//  KRARequestDeserializer.h
//  KRANetworking
//
//  Created by Olivier Larivain on 11/16/13.
//  Copyright (c) 2013 kra. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol KRARequestDeserializer <NSObject>

-(id) parseResponse:(NSHTTPURLResponse *)response data:(NSData *)data;

@end

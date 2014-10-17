//
//  DataCenter.h
//  iPottApp
//
//  Created by Manuela Schrenk on 17/10/14.
//  Copyright (c) 2014 bitroyal. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DataCenterDelegateProtocol <NSObject>

- (void) successfullyFetchedArticles: (NSArray *) articles;

@end


@interface DataCenter : NSObject

extern NSString * const kReadArticles;
extern NSString * const kFavArticles;

+ (DataCenter *)defaultCenter;

- (void) setup;
- (void) getAllArticlesWithCallback: (id<DataCenterDelegateProtocol>) callback;

@end

//
//  DataCenter.m
//  iPottApp
//
//  Created by Manuela Schrenk on 17/10/14.
//  Copyright (c) 2014 bitroyal. All rights reserved.
//

#import "DataCenter.h"
#import <Parse/Parse.h>


NSString * const kReadArticles = @"kReadArticles";
NSString* const kFavArticles = @"kFavArticles";
static DataCenter *sharedInstance = nil;




@interface DataCenter ()
@property (nonatomic, strong) NSArray *articles;
@end



@implementation DataCenter

#pragma mark - Lifecycle

+ (DataCenter *)defaultCenter
{
    if (!sharedInstance) {
        sharedInstance = [[DataCenter alloc] init];
    }
    
    return sharedInstance;
}

- (void) setup
{
    self.articles = [NSArray array];
}

- (void) getAllArticlesWithCallback: (id<DataCenterDelegateProtocol>) callback
{
    __weak DataCenter* weakSelf = self;
    
    PFQuery *query = [PFQuery queryWithClassName:@"Article"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            weakSelf.articles = objects;
            
            if ([callback conformsToProtocol:@protocol(DataCenterDelegateProtocol)]) {
                [callback successfullyFetchedArticles:objects];
            }
        }
    }];
    
}

@end

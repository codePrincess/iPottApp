//
//  NewsOverviewCellTableViewCell.m
//  iPottApp
//
//  Created by Manuela Schrenk on 16/10/14.
//  Copyright (c) 2014 bitroyal. All rights reserved.
//

#import "NewsOverviewCellTableViewCell.h"
#import "DataCenter.h"


@interface NewsOverviewCellTableViewCell ()

@property (weak, nonatomic) IBOutlet UIButton *favButton;

@end

@implementation NewsOverviewCellTableViewCell

- (void) setupCell
{
    NSArray *myFavs = [[NSUserDefaults standardUserDefaults] arrayForKey: kFavArticles];
    for (NSString *fav in myFavs) {
        if ([self.article.objectId isEqualToString:fav]) {
            [self.favButton setImage:[UIImage imageNamed:@"fav"] forState:UIControlStateNormal];
            [self.favButton setImage:[UIImage imageNamed:@"fav"] forState:UIControlStateHighlighted];
        }
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)favButtonTapped:(id)sender {
    self.favButton.selected = !self.favButton.selected;
    
    NSMutableArray *favArticles = [[NSUserDefaults standardUserDefaults] arrayForKey:kFavArticles].mutableCopy;
    
    if (!favArticles) {
        favArticles = [NSMutableArray array];
    }
    
    if (self.favButton.selected) {
        if (![favArticles containsObject:self.article.objectId]) {
            [favArticles addObject:self.article.objectId];
            [[NSUserDefaults standardUserDefaults] setObject:favArticles forKey:kFavArticles];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }

        [self.favButton setImage:[UIImage imageNamed:@"fav"] forState:UIControlStateNormal];
        [self.favButton setImage:[UIImage imageNamed:@"fav"] forState:UIControlStateHighlighted];
    }
    else {
        [favArticles removeObject:self.article.objectId];
        [[NSUserDefaults standardUserDefaults] setObject:favArticles forKey:kFavArticles];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        [self.favButton setImage:[UIImage imageNamed:@"unfav"] forState:UIControlStateNormal];
        [self.favButton setImage:[UIImage imageNamed:@"unfav"] forState:UIControlStateHighlighted];
    }
}

@end

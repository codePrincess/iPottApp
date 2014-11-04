//
//  NewsOverviewCellTableViewCell.h
//  iPottApp
//
//  Created by Manuela Schrenk on 16/10/14.
//  Copyright (c) 2014 bitroyal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface NewsOverviewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *cellTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *cellSubtitleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *cellImage;

@property (strong, nonatomic) PFObject *article;

- (void) setupCell;

@end

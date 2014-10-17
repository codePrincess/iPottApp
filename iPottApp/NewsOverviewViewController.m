//
//  FirstViewController.m
//  iPottApp
//
//  Created by Manuela Schrenk on 16/10/14.
//  Copyright (c) 2014 bitroyal. All rights reserved.
//

#import "NewsOverviewViewController.h"
#import "NewsArticleViewController.h"
#import "NewsOverviewCellTableViewCell.h"
#import <Parse/Parse.h>
#import "DataCenter.h"


@interface NewsOverviewViewController () <UITableViewDataSource, UITableViewDelegate, DataCenterDelegateProtocol>

@property (weak, nonatomic) IBOutlet UITableView *newsTableView;
@property (strong, nonatomic) NSArray *articles;
@property (strong, nonatomic) NSIndexPath *selectedIndexPath;

@end

@implementation NewsOverviewViewController

#pragma mark - view handling

- (void)viewDidLoad {
    [super viewDidLoad];
    self.newsTableView.contentInset = UIEdgeInsetsMake(20, 0, 0, 0);
    
    [self fetchArticles];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self fetchArticles];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - BE communication
- (void) fetchArticles
{
    [[DataCenter defaultCenter] getAllArticlesWithCallback:self];
}


#pragma mark  - custom segue behaviour

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"ShowNewsArticleSegue"]) {
        NewsArticleViewController *articleViewController = (NewsArticleViewController *)segue.destinationViewController;
        PFObject *article = self.articles[self.selectedIndexPath.row];
        articleViewController.url = article[@"url"];
    }
}

#pragma mark - table view handling

-(NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.selectedIndexPath = indexPath;
    return indexPath;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSMutableArray *readArticleIDs = [[NSUserDefaults standardUserDefaults] arrayForKey:kReadArticles].mutableCopy;
    if (!readArticleIDs) {
        readArticleIDs = [NSMutableArray array];
    }
    
    PFObject *article = self.articles[indexPath.row];
    
    if (![readArticleIDs containsObject:article.objectId]) {
        [readArticleIDs addObject:article.objectId];
        [[NSUserDefaults standardUserDefaults] setObject:readArticleIDs forKey:kReadArticles];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        NewsOverviewCellTableViewCell *cell = (NewsOverviewCellTableViewCell*) [tableView cellForRowAtIndexPath:indexPath];
        cell.cellImage.image = [UIImage imageNamed:@"news-icon"];
    }
}

#pragma mark - <UITableViewDelegate>

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.articles.count;
}

#pragma mark - <UITableViewDataSource>

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *myCellIdentifier = @"newsOverviewCell";
    NewsOverviewCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:myCellIdentifier];
    
    NSArray *readArticleIDs = [[NSUserDefaults standardUserDefaults] arrayForKey:kReadArticles];
    PFObject *article = self.articles[indexPath.row];
    
    if ([readArticleIDs containsObject:article.objectId]) {
        cell.cellImage.image = [UIImage imageNamed:@"news-icon"];
    }
    else {
        cell.cellImage.image = [UIImage imageNamed:@"news_unread-icon"];
    }
    
    cell.cellTitleLabel.text = article[@"title"];
    cell.cellSubtitleLabel.text = article[@"subtitle"];
    cell.article = article;
    
    [cell setupCell];
    
    return cell;
}

#pragma mark - <DataSourceDelegateProtocol>

- (void)successfullyFetchedArticles:(NSArray *)articles
{
    self.articles = articles;
    [self.newsTableView reloadData];
}

@end

//
//  SecondViewController.m
//  iPottApp
//
//  Created by Manuela Schrenk on 16/10/14.
//  Copyright (c) 2014 bitroyal. All rights reserved.
//

#import "FavOverviewViewController.h"
#import "NewsArticleViewController.h"
#import "NewsOverviewCell.h"
#import <Parse/Parse.h>
#import "DataCenter.h"

@interface FavOverviewViewController () <UITableViewDataSource, UITableViewDelegate, DataCenterDelegateProtocol>

@property (weak, nonatomic) IBOutlet UITableView *favTableView;
@property (strong, nonatomic) NSArray *articles;
@property (strong, nonatomic) NSIndexPath *selectedIndexPath;

@end

@implementation FavOverviewViewController

#pragma mark - view handling

- (void)viewDidLoad {
    [super viewDidLoad];
    self.favTableView.contentInset = UIEdgeInsetsMake(20, 0, 0, 0);
    
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


#pragma mark - <UITableViewDelegate>

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.articles.count;
}

#pragma mark - <UITableViewDataSource>

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *myCellIdentifier = @"favOverviewCell";
    NewsOverviewCell *cell = [tableView dequeueReusableCellWithIdentifier:myCellIdentifier];
    
    PFObject *article = self.articles[indexPath.row];
    
    cell.cellTitleLabel.text = article[@"title"];
    cell.cellSubtitleLabel.text = article[@"subtitle"];
    cell.article = article;
    
    return cell;
}

#pragma mark - <DataSourceDelegateProtocol>

- (void)successfullyFetchedArticles:(NSArray *)articles
{
    NSMutableArray *favArticles = [NSMutableArray array];
    
    NSArray *myFavs = [[NSUserDefaults standardUserDefaults] arrayForKey: kFavArticles];
    for (NSString *fav in myFavs) {
        for (PFObject *article in articles) {
            if ([article.objectId isEqualToString:fav]) {
                [favArticles addObject: article];
            }
        }
    }
    
    self.articles = favArticles;
    [self.favTableView reloadData];
}

@end

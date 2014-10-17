//
//  NewsArticleViewController.m
//  iPottApp
//
//  Created by Manuela Schrenk on 16/10/14.
//  Copyright (c) 2014 bitroyal. All rights reserved.
//

#import "NewsArticleViewController.h"





@interface NewsArticleViewController ()

@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation NewsArticleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.webView.scrollView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)closeView:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

//
//  WebViewController.m
//  FYPLirandak
//
//  Created by Liranda Krasniqi on 22/02/2016.
//  Copyright © 2016 Liranda Krasniqi. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()

  @property (nonatomic, retain) RecipeObject *recipeObject;

@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
    
    //[[RequestManager manager] downloadRecipeDetail
    

    NSString *url=@"http://www.yummly.com";
    //[[RecipeObject recipeObject] ViewRecipeInstruction ];
    NSLog(@"%@", url);
    
    
    
  [webview loadRequest: [NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
    
    
    webview.scalesPageToFit = YES;
    webview.autoresizesSubviews = YES;
    webview.frame=self.view.bounds;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

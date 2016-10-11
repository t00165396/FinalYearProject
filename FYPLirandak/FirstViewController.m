//
//  FirstViewController.m
//  FYPLirandak
//
//  Created by Liranda Krasniqi on 10/02/2016.
//  Copyright © 2016 Liranda Krasniqi. All rights reserved.
//

#import "FirstViewController.h"
#import "CreateUserFridgeDB.h"

@interface FirstViewController ()

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //load users data
    [[CreateUserFridgeDB getSharedInstance] createDB];
    _userName.text=[[CreateUserFridgeDB getSharedInstance] readUserDetails];
  
            @try {
    
   NSURLRequest *urlRequest =[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.yummly.com/browse/popular-now"]];
                [self.recommendedRecipes loadRequest:urlRequest];
    
   
    _recommendedRecipes.autoresizesSubviews = YES;
    _recommendedRecipes.frame=self.view.bounds;
                
                self.recommendedRecipes.scalesPageToFit = YES;
                self.recommendedRecipes.contentMode = UIViewContentModeScaleAspectFit;
                
                //http://stackoverflow.com/questions/10666484/html-content-fit-in-uiwebview-without-zooming-out
                CGSize contentSize = _recommendedRecipes.scrollView.contentSize;
                CGSize viewSize = _recommendedRecipes.bounds.size;
                float rw = viewSize.width / contentSize.width;
                _recommendedRecipes.scrollView.minimumZoomScale = rw;
                _recommendedRecipes.scrollView.maximumZoomScale = rw;
                _recommendedRecipes.scrollView.zoomScale = rw;
                
            }
    
    @catch ( NSException *e ) {
       NSLog(@"%@",e);
    }
    

    
    
}
- (void)webViewDidFinishLoad:(UIWebView *)theWebView
{
    CGSize contentSize = theWebView.scrollView.contentSize;
    CGSize viewSize = theWebView.bounds.size;
    
    float rw = viewSize.width / contentSize.width;
    
    theWebView.scrollView.minimumZoomScale = rw;
    theWebView.scrollView.maximumZoomScale = rw;
    theWebView.scrollView.zoomScale = rw;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

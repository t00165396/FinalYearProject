//
//  SearchByIngredient.m
//  FYPLirandak
//
//  Created by Liranda Krasniqi on 01/03/2016.
//  Copyright © 2016 Liranda Krasniqi. All rights reserved.
//

#import "SearchByIngredient.h"
#import "RecipeObject.h"

@implementation SearchByIngredient

- (void)searchForRecipe:(NSString *)keyword block:(void (^)(BOOL, NSArray *))callbackBlock {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        BOOL succeed = NO;
        NSArray *results = nil;
        
        // create url
        NSString *urlStr = [NSString stringWithFormat: @"http://api.yummly.com/v1/api/recipes?_app_id=39fd9427&_app_key=264eafb5fe4af135d19d0878c603c2a0&q=onion+soup&allowedIngredient[]=garlic&allowedIngredient[]=cognac"];
    
        NSLog(@"Url is %@", urlStr);
        
        
        NSURL *url = [NSURL URLWithString:urlStr];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
        [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        
        NSURLResponse *response;
        NSError *error;
        
        NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
        
        if(!error)
        {
            
            results = [self parseRecipeSearchResponse:responseData];
            if (results) {
                succeed = YES;
            }
        }
        
        
        dispatch_async( dispatch_get_main_queue(), ^{
            callbackBlock(succeed, results);
        });
    });
}


- (NSArray*)parseRecipeSearchResponse:(NSData*)response {
    NSMutableArray *results = nil;
    
    NSError *error;
    NSDictionary* resultAsJSON = [NSJSONSerialization JSONObjectWithData:response options:kNilOptions error:&error];
    if (!error) {
        //create array to store data from api
        NSArray *resultList = [resultAsJSON objectForKey:@"matches"];
        if (resultList) {
            results = [[NSMutableArray alloc] init];
            // create recipe objects from the dictionary and add it to the results array
            for (int i = 0; i < [resultList count]; i++) {
                NSDictionary *recipeAsDict = [resultList objectAtIndex:i];
                if (recipeAsDict)
                {
                    // get string in the dictionary according to their key
                    NSString *recipeId = [recipeAsDict objectForKey:@"id"];
                    NSString *title = [recipeAsDict objectForKey:@"recipeName"];
                    NSString *smallImage ;
                    NSString *largeImage;
                    
                    NSArray *urlArray = [recipeAsDict valueForKey:@"smallImageUrls"];
                    if (urlArray) {
                        if ([urlArray count] > 0) {
                            NSString *url = [urlArray objectAtIndex:0];
                            smallImage = url;
                        }
                    }
                    
                    NSArray *LargeImageArray = [recipeAsDict valueForKey:@"imageUrlsBySize"];
                    if (LargeImageArray) {
                        if ([LargeImageArray count] > 0) {
                            NSString *url = [urlArray objectAtIndex:0];
                            largeImage = url;
                        }
                    }
                    
                    
                    NSArray *ingredientsArray = [recipeAsDict valueForKey:@"ingredients"];
                    NSMutableString *str = [NSMutableString string];
                    
                    for (int i = 0; i < [ingredientsArray count]; i++) {
                        if (ingredientsArray[i] != 0) {
                            [str appendFormat:@"%@", ingredientsArray[i]];
                        }
                    }
                    //
                    //               for (int i = 0; i < [ingredientsArray count]; i++) {
                    //                                          NSString *ingredients = [ingredientsArray objectAtIndex:i];
                    //
                    //                    ing = ingredients;
                    //
                    //                            }
                    
                    
                    
                    //                     NSString *smallImage = [recipeAsDict objectForKey:@"smallImageUrls"];
                    //                    NSLog(@"%@",smallImage);
                    //                    NSString *largeImage = [recipeAsDict objectForKey:@"imageUrlsBySize"];
                    //                    NSLog(@"%@",largeImage);
                    
                    RecipeObject *recipe = [[RecipeObject alloc] initWithId:recipeId title:title thumbnailUrl:smallImage imageUrl:largeImage ingredients:str];
                    [results addObject:recipe];
                }
            }
        }
    }
    
    return results;
}


@end

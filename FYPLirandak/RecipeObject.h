//
//  RecipeObject.h
//  RecipeApp
//
//  Created by Liranda Krasniqi on 05/11/2015.
//  Copyright © 2015 fyp. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "RecipeInstructions.h"//;


@class RecipeObject; 
@protocol RecipeObjectDetailDelegate <NSObject>
@required
- (void)recipeObject:(RecipeObject*)receipeObject didReceiveDetail:(NSString*)detail;
@end

@protocol RecipeObjectImageDelegate <NSObject>
@required
- (void)recipeObject:(RecipeObject*)receipeObject didReceiveImage:(UIImage*)image;
@end

@protocol RecipeObjectThumbnailDelegate <NSObject>
@required
- (void)recipeObject:(RecipeObject*)recipeObject didReceiveThumbnail:(UIImage*)thumbnail;
@end

@interface RecipeObject : NSObject

+ (RecipeObject*)recipeObject;

@property (nonatomic, weak) id<RecipeObjectDetailDelegate> detailDelegate;
@property (nonatomic, weak) id<RecipeObjectImageDelegate> imageDelegate;
@property (nonatomic, weak) id<RecipeObjectThumbnailDelegate> thumbDelegate;

@property (nonatomic, strong) NSString *recipeId;
@property (nonatomic, strong) NSString *recipeName;
@property (nonatomic, strong) NSString *smallImageUrls;
@property (nonatomic, strong) NSString *largeImage;
@property (nonatomic, strong) NSString *ingredients;
@property (nonatomic, strong) NSNumber *totalTime;
@property (nonatomic, strong) NSString *recipeDetail;


@property (nonatomic, strong) UIImage *thumbnail;
@property (nonatomic, strong) UIImage *image;

- (id)initWithId:(NSString*)recipeId title:(NSString*)title thumbnailUrl:(NSString*)smallImageUrls imageUrl:(NSString*)imageUrl ingredients :(NSString*) ingredients;

- (void)downloadThumbnail;
- (void)downloadImage;
- (void)downloadRecipeDetail;
-(NSString *)ViewRecipeInstruction;


@end

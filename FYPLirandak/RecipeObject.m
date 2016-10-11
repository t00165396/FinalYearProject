//
//  RecipeObject.m
//  RecipeApp
//
//  Created by Liranda Krasniqi on 05/11/2015.
//  Copyright © 2015 fyp. All rights reserved.
//

#import "RecipeObject.h"
#import "RequestManager.h"
#import "RecipeInstructions.h"


typedef enum
{
    THUMBNAIL,
    IMAGE,
} eMEDIA_TYPE;

@interface RecipeObject()

@property (nonatomic, assign) BOOL isFetchingThumbnail;
@property (nonatomic, assign) BOOL isFetchingImage;
@property (nonatomic, assign) BOOL isFetchingDetail;
@property (nonatomic, strong) RecipeInstructions *recipeInstruction;


@end

@implementation RecipeObject

static RecipeObject* sharedInstance;

+(RecipeObject *)manager {
    if (!sharedInstance)
    {
        sharedInstance = [[RecipeObject alloc] init];
    }
    
    return sharedInstance;
}

- (id)initWithId:(NSString*)recipeId title:(NSString*)title thumbnailUrl:(NSString*)thumbnailUrl imageUrl:(NSString*)imageUrl ingredients :(NSString*)ingredinets
{
    self = [super init];
    if (self) {
        
        _isFetchingThumbnail = NO;
        _isFetchingImage = NO;
        _isFetchingDetail = NO;
        _smallImageUrls=thumbnailUrl;
        _largeImage=imageUrl;
        _recipeId = recipeId;
        _recipeName = title;
        _ingredients=ingredinets;
       
      
    }
    
    return self;
}

- (void)downloadThumbnail {
    if (!_isFetchingThumbnail)
    {
        _isFetchingThumbnail = YES;
        
        [self performSelectorInBackground:@selector(downloadMediaInBackgroundOfType:) withObject:[NSNumber numberWithInt:THUMBNAIL]];
    }
}

- (void)downloadImage {
    if (!_isFetchingImage) {
        _isFetchingImage = NO;
        [self performSelectorInBackground:@selector(downloadMediaInBackgroundOfType:) withObject:[NSNumber numberWithInt:IMAGE]];
    }
}

- (void)downloadMediaInBackgroundOfType:(NSNumber *)mediaTypeNumber {
    eMEDIA_TYPE mediaType = [mediaTypeNumber intValue];
    
    NSString *url = nil;
    switch (mediaType) {
        case IMAGE:
            url = _largeImage;
            break;
        case THUMBNAIL:
            url = _smallImageUrls;
            break;
    }
    
    UIImage *image;
    
    @try
    {
        
        image =[UIImage imageWithData: [NSData dataWithContentsOfURL:[NSURL URLWithString: url]]];
    }
    @catch (NSException *exception)
    {
        NSLog(@"%@ ",exception.name);
        NSLog(@"Reason: %@ ",exception.reason);
    }
    
    
    switch (mediaType) {
        case IMAGE:
            _image = image;
            // call the delegate in the UI thread
            [self performSelectorOnMainThread:@selector(informDelegateOfImageReception) withObject:nil waitUntilDone:NO];
            break;
        case THUMBNAIL:
            _thumbnail = image;
            [self performSelectorOnMainThread:@selector(informDelegateOfThumbnailReception) withObject:nil waitUntilDone:NO];
            _isFetchingThumbnail = NO;
        break;
    }
}

- (void)informDelegateOfImageReception {
    if (_imageDelegate) {
        [_imageDelegate recipeObject:self didReceiveImage:_image];
    }
}

- (void)informDelegateOfThumbnailReception {
    if (_thumbDelegate) {
        [_thumbDelegate recipeObject:self didReceiveThumbnail:_thumbnail];
    }
}

- (void)downloadRecipeDetail {
    if (!_isFetchingDetail) {
        _isFetchingDetail = YES;
        
        
        [[RequestManager manager] downloadRecipeDetail:_recipeId block:^(BOOL succeed, RecipeInstructions *recipeDetail) {
            _isFetchingDetail = NO;
            if (succeed)
                _recipeInstruction=recipeDetail;
            
        }
       ];
    }
}
-(NSString *)ViewRecipeInstruction{
    NSString *url;
    if (!_isFetchingDetail) {
        _isFetchingDetail = YES;
        
        
        [[RequestManager manager] downloadRecipeDetail:_recipeId block:^(BOOL succeed, RecipeInstructions *recipeDetail) {
            _isFetchingDetail = NO;
            if (succeed)
                _recipeInstruction=recipeDetail;
            recipeDetail.recipeURL=url;
        }
         ];
    }
    return url;
}


@end

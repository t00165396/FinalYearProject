//
//  User.h
//  FYPLirandak
//
//  Created by Liranda Krasniqi on 24/02/2016.
//  Copyright © 2016 Liranda Krasniqi. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface User : NSObject {
    NSString *name; 
    NSString *description;
    NSString *imageURL;
}

@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *description;
@property (nonatomic, retain) NSString *imageURL;

-(id)initWithName:(NSString *)name description:(NSString *)description url:(NSString *)image;

@end
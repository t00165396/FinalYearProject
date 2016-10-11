//
//  User.m
//  FYPLirandak
//
//  Created by Liranda Krasniqi on 24/02/2016.
//  Copyright © 2016 Liranda Krasniqi. All rights reserved.
//

#import "User.h"

@implementation User

@synthesize name, description, imageURL;

-(id)initWithName:(NSString *)n description:(NSString *)d url:(NSString *)u {
    self.name = n;
    self.description = d;
    self.imageURL = u;
    return self;
}

@end

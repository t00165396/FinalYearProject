//
//  ShoppingListItem.m
//
//  Created by Liranda Krasniqi on 05/11/2015.
//  Copyright © 2015 fyp. All rights reserved.
//

#import "ShoppingListItem.h"

@implementation ShoppingListItem

- (void) toggleChecked
{
    self.checked = !self.checked; 
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    // Retreive objects from the plist file
    if ((self = [super init])) {
        self.text = [aDecoder decodeObjectForKey:@"Text"];
        self.checked = [aDecoder decodeBoolForKey:@"Checked"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    // Store objects in plist file
    [aCoder encodeObject:self.text forKey:@"Text"];
    [aCoder encodeBool:self.checked forKey:@"Checked"];
}

@end

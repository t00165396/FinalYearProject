//
//  ShoppingListItem.h
//
//  Created by Liranda Krasniqi on 05/11/2015.
//  Copyright © 2015 fyp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShoppingListItem : NSObject<NSCoding>

@property (nonatomic, copy) NSString *text;
@property (nonatomic, assign) BOOL checked;

- (void)toggleChecked;

@end

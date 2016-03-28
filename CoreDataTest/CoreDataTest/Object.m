//
//  Object.m
//  CoreDataTest
//
//  Created by Nikolay Berlioz on 21.03.16.
//  Copyright © 2016 Nikolay Berlioz. All rights reserved.
//

#import "Object.h"

@implementation Object

// Insert code here to add functionality to your managed object subclass

- (BOOL) validateForDelete:(NSError * _Nullable __autoreleasing *)error
{
    NSLog(@"%@ validateForDelete", NSStringFromClass([self class]));
    
    return YES;
}

@end

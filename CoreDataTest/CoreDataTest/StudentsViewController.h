//
//  StudentsViewController.h
//  CoreDataTest
//
//  Created by Nikolay Berlioz on 27.03.16.
//  Copyright © 2016 Nikolay Berlioz. All rights reserved.
//

#import "CoreDataViewController.h"
#import "Course.h"

@interface StudentsViewController : CoreDataViewController

@property (strong, nonatomic) Course *course;

@end

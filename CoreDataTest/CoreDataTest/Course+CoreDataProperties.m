//
//  Course+CoreDataProperties.m
//  CoreDataTest
//
//  Created by Nikolay Berlioz on 21.03.16.
//  Copyright © 2016 Nikolay Berlioz. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Course+CoreDataProperties.h"

@implementation Course (CoreDataProperties)

@dynamic name;
@dynamic university;
@dynamic students;
@dynamic bestStudents;
@dynamic studentWithManyCourses;

@end

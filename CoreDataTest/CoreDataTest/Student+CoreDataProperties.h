//
//  Student+CoreDataProperties.h
//  CoreDataTest
//
//  Created by Nikolay Berlioz on 21.03.16.
//  Copyright © 2016 Nikolay Berlioz. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Student.h"

NS_ASSUME_NONNULL_BEGIN

@interface Student (CoreDataProperties)

@property (nullable, nonatomic, retain) NSDate *dateOfBirth;
@property (nullable, nonatomic, retain) NSString *firstName;
@property (nullable, nonatomic, retain) NSString *lastName;
@property (nullable, nonatomic, retain) NSNumber *score;
@property (nullable, nonatomic, retain) Car *car;
@property (nullable, nonatomic, retain) University *university;
@property (nullable, nonatomic, retain) NSSet<NSManagedObject *> *courses;

@end

@interface Student (CoreDataGeneratedAccessors)

- (void)addCoursesObject:(NSManagedObject *)value;
- (void)removeCoursesObject:(NSManagedObject *)value;
- (void)addCourses:(NSSet<NSManagedObject *> *)values;
- (void)removeCourses:(NSSet<NSManagedObject *> *)values;

@end

NS_ASSUME_NONNULL_END

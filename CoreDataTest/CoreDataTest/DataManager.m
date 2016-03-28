//
//  DataManager.m
//  CoreDataTest
//
//  Created by Nikolay Berlioz on 26.03.16.
//  Copyright © 2016 Nikolay Berlioz. All rights reserved.
//

#import "DataManager.h"
#import "Student.h"
#import "Car.h"
#import "University.h"
#import "Course.h"

static NSString* firstNames[] = {
    @"Tran", @"Lenore", @"Bud", @"Fredda", @"Katrice",
    @"Clyde", @"Hildegard", @"Vernell", @"Nellie", @"Rupert",
    @"Billie", @"Tamica", @"Crystle", @"Kandi", @"Caridad",
    @"Vanetta", @"Taylor", @"Pinkie", @"Ben", @"Rosanna",
    @"Eufemia", @"Britteny", @"Ramon", @"Jacque", @"Telma",
    @"Colton", @"Monte", @"Pam", @"Tracy", @"Tresa",
    @"Willard", @"Mireille", @"Roma", @"Elise", @"Trang",
    @"Ty", @"Pierre", @"Floyd", @"Savanna", @"Arvilla",
    @"Whitney", @"Denver", @"Norbert", @"Meghan", @"Tandra",
    @"Jenise", @"Brent", @"Elenor", @"Sha", @"Jessie"
};

static NSString* lastNames[] = {
    
    @"Farrah", @"Laviolette", @"Heal", @"Sechrest", @"Roots",
    @"Homan", @"Starns", @"Oldham", @"Yocum", @"Mancia",
    @"Prill", @"Lush", @"Piedra", @"Castenada", @"Warnock",
    @"Vanderlinden", @"Simms", @"Gilroy", @"Brann", @"Bodden",
    @"Lenz", @"Gildersleeve", @"Wimbish", @"Bello", @"Beachy",
    @"Jurado", @"William", @"Beaupre", @"Dyal", @"Doiron",
    @"Plourde", @"Bator", @"Krause", @"Odriscoll", @"Corby",
    @"Waltman", @"Michaud", @"Kobayashi", @"Sherrick", @"Woolfolk",
    @"Holladay", @"Hornback", @"Moler", @"Bowles", @"Libbey",
    @"Spano", @"Folson", @"Arguelles", @"Burke", @"Rook"
};

static NSString *carModelNames[] = {
    
    @"Dodge", @"Toyota", @"BMW", @"Lada", @"Volga"
};


@implementation DataManager

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

+ (DataManager*) sharedManager
{
    static DataManager *manager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[DataManager alloc] init];
    });
    
    return manager;
}

- (void) generateAndAddUniversity
{
    /*
     NSManagedObject *student = [NSEntityDescription insertNewObjectForEntityForName:@"Student"
     inManagedObjectContext:self.managedObjectContext];
     
     [student setValue:@"Alex" forKey:@"firstName"];
     [student setValue:@"Skutarenko" forKey:@"lastName"];
     [student setValue:[NSDate dateWithTimeIntervalSinceReferenceDate:0] forKey:@"dateOfBirth"];
     [student setValue:@4.1 forKey:@"score"];
     
     NSError *error = nil;
     
     if (![self.managedObjectContext save:&error])
     {
     NSLog(@"%@", [error localizedDescription]);
     }
     */
    
    
     NSError *error = nil;
     
     NSArray *courses = @[[self addCourseWithName:@"IOS"],
     [self addCourseWithName:@"Android"],
     [self addCourseWithName:@"PHP"],
     [self addCourseWithName:@"JavaScript"],
     [self addCourseWithName:@"HTML"]];
     
     
     University *university = [self addUniversity];
     
     [university addCourses:[NSSet setWithArray:courses]];
     
     for (int i = 0; i < 100; i++)
    {
        Student *student = [self randomStudent];
     
        if (arc4random_uniform(1000) < 500)
        {
            Car *car = [self randomCar];
            student.car = car;
        }
     
        student.university = university;
     
        NSInteger number = arc4random_uniform(5) + 1;
     
        while ([student.courses count] < number)
        {
            Course *course = [courses objectAtIndex:arc4random_uniform(5)];
     
            if (![student.courses containsObject:course])
            {
                [student addCoursesObject:course];
            }
        }
     
        //[university addStudentsObject:student];
    }
     
     
     if (![self.managedObjectContext save:&error])
     {
     NSLog(@"%@", [error localizedDescription]);
     }
    
    
    
    //[self deleteAllObject];
    
    //[self printAllObject];
    
    //    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    //
    //    NSEntityDescription *description = [NSEntityDescription entityForName:@"Course"
    //                                                   inManagedObjectContext:self.managedObjectContext];
    //
    //    [request setEntity:description];
    //[request setRelationshipKeyPathsForPrefetching:@[@"courses"]];
    /*
     //how load of necessity
     [request setFetchBatchSize:20];
     
     //with number begin load
     [request setFetchOffset:10];
     //how load total
     [request setFetchLimit:35];
     */
    /*
     NSSortDescriptor *firstNameDescriptor = [[NSSortDescriptor alloc] initWithKey:@"firstName" ascending:YES];
     NSSortDescriptor *lastNameDescriptor = [[NSSortDescriptor alloc] initWithKey:@"lastName" ascending:YES];
     
     [request setSortDescriptors:@[firstNameDescriptor, lastNameDescriptor]];
     */
    //NSArray *validNames = @[@"Ben", @"Taylor", @"Pam"];
    /*
     NSPredicate *predicate = [NSPredicate predicateWithFormat:
     @"score > %f && score <= %f && courses.@count >= %d && firstName IN %@", 3.0, 3.5, 3, validNames];
     */
    
    /*
     NSSortDescriptor *nameDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
     
     [request setSortDescriptors:@[nameDescriptor]];
     
     NSPredicate *predicate = [NSPredicate predicateWithFormat:@"@avg.students.score > %f", 2.9];
     
     [request setPredicate:predicate];
     */
    /*
     NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SUBQUERY(students, $student, $student.car.model == %@).@count >= %d", @"BMW", 5];
     
     [request setPredicate:predicate];
     */
    //[self printArray:resultArray];
    
//    NSFetchRequest *request = [[NSFetchRequest alloc] init];
//    NSEntityDescription *description = [NSEntityDescription entityForName:@"University" inManagedObjectContext:self.managedObjectContext];
//    [request setEntity:description];
//    
//    NSError *requestError = nil;
//    NSArray *resultArray = [self.managedObjectContext executeFetchRequest:request error:&requestError];
//    
//
//    
//    for (Course *course in resultArray)
//    {
//        NSLog(@"COURSE NAME: %@", course.name);
//        NSLog(@"BEST STUDENTS:");
//        [self printArray:course.bestStudents];
//        NSLog(@"BUZY STUDENTS:");
//        [self printArray:course.studentWithManyCourses];
//    }
}

- (void) deleteAllObject
{
    NSArray *allObjects = [self allObjects];
    
    for (id object in allObjects)
    {
        //ставим на удаление
        [self.managedObjectContext deleteObject:object];
    }
    //делаем сейв(удаляем окончательно)
    [self.managedObjectContext save:nil];
}

- (NSArray*) allObjects
{
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *description = [NSEntityDescription entityForName:@"Object"
                                                   inManagedObjectContext:self.managedObjectContext];
    
    [request setEntity:description];
    
    NSError *requestError = nil;
    NSArray *resultArray = [self.managedObjectContext executeFetchRequest:request error:&requestError];
    
    if (requestError)
    {
        NSLog(@"%@", [requestError localizedDescription]);
    }
    
    return resultArray;
}

- (void) printArray:(NSArray*)array
{
    for (id object in array)
    {
        if ([object isKindOfClass:[Car class]])
        {
            Car *car = (Car*) object;
            NSLog(@"Car: %@, OWNER: %@ %@", car.model, car.owner.firstName, car.owner.lastName);
        }
        else if ([object isKindOfClass:[Student class]])
        {
            Student *student = (Student*) object;
            NSLog(@"STUDENT: %@ %@, SCORE: %1.2f, COURSES: %lu", student.firstName, student.lastName,[student.score floatValue], [student.courses count]);
        }
        else if ([object isKindOfClass:[University class]])
        {
            University *university = (University*) object;
            NSLog(@"UNIVERSITY: %@ students: %lu", university.name, [university.students count]);
        }
        else if ([object isKindOfClass:[Course class]])
        {
            Course *course = (Course*) object;
            NSLog(@"COURSE: %@ students: %lu", course.name, [course.students count]);
        }
    }
    NSLog(@"COUNT: %lu", [array count]);
}

- (void) printAllObject
{
    NSArray *allObjects = [self allObjects];
    
    [self printArray:allObjects];
}

- (University*)addUniversity
{
    University *university = [NSEntityDescription insertNewObjectForEntityForName:@"University"
                                                           inManagedObjectContext:self.managedObjectContext];
    university.name = @"SPBGUSE";
    
    return university;
}

- (Course*)addCourseWithName:(NSString*)name
{
    Course *course = [NSEntityDescription insertNewObjectForEntityForName:@"Course"
                                                   inManagedObjectContext:self.managedObjectContext];
    course.name = name;
    
    return course;
}

- (Car*) randomCar
{
    Car *car = [NSEntityDescription insertNewObjectForEntityForName:@"Car"
                                             inManagedObjectContext:self.managedObjectContext];
    car.model = carModelNames[arc4random_uniform(5)];
    
    return car;
}

- (Student*) randomStudent
{
    Student *student = [NSEntityDescription insertNewObjectForEntityForName:@"Student"
                                                     inManagedObjectContext:self.managedObjectContext];
    student.score = @((float)arc4random_uniform(201) / 100 + 2);
    student.dateOfBirth = [NSDate dateWithTimeIntervalSince1970:60 * 60 * 24 * 365 * arc4random_uniform(31)];
    student.firstName = firstNames[arc4random_uniform(50)];
    student.lastName = lastNames[arc4random_uniform(50)];
    
    return student;
}

#pragma mark - Core Data stack


- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "Devil-Academy.CoreDataTest" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"CoreDataTest" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"CoreDataTest.sqlite"];
    NSError *error = nil;
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        
        [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil];
        [_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error];
    }
    
    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

@end

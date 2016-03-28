//
//  CoursesViewController.m
//  CoreDataTest
//
//  Created by Nikolay Berlioz on 26.03.16.
//  Copyright © 2016 Nikolay Berlioz. All rights reserved.
//

#import "CoursesViewController.h"
#import "University.h"
#import "CoreDataViewController.h"
#import "Course.h"
#import "StudentsViewController.h"

@interface CoursesViewController ()

@end

@implementation CoursesViewController

@synthesize fetchedResultsController = _fetchedResultsController;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSFetchedResultsController *)fetchedResultsController
{
    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *description = [NSEntityDescription entityForName:@"Course"
                                                   inManagedObjectContext:self.managedObjectContext];
    [request setEntity:description];
    
    //how load of necessity
    [request setFetchBatchSize:20];
    
    
    NSSortDescriptor *nameDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
    
    [request setSortDescriptors:@[nameDescriptor]];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"university == %@", self.university];

    [request setPredicate:predicate];
    
    // Edit the section name key path and cache name if appropriate.
    // nil for section name key path means "no sections".
    NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc]
                                                             initWithFetchRequest:request
                                                             managedObjectContext:self.managedObjectContext
                                                             sectionNameKeyPath:nil
                                                             cacheName:nil];
    aFetchedResultsController.delegate = self;
    self.fetchedResultsController = aFetchedResultsController;
    
    NSError *error = nil;
    if (![self.fetchedResultsController performFetch:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _fetchedResultsController;
}

#pragma mark - UITableViewDataSource

- (void)configureCell:(UITableViewCell *)cell withObject:(NSManagedObject *)object
{
    Course *course = (Course*)object;
    
    cell.textLabel.text = course.name;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%lu", [course.students count]];
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
}



#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Course *course = [[self fetchedResultsController] objectAtIndexPath:indexPath];
    
    StudentsViewController *vc = [[StudentsViewController alloc] init];
    
    vc.course = course;
    
    [self.navigationController pushViewController:vc animated:YES];
    
}






@end



















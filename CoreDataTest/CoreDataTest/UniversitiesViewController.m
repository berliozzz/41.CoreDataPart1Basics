//
//  UniversityViewController.m
//  CoreDataTest
//
//  Created by Nikolay Berlioz on 26.03.16.
//  Copyright © 2016 Nikolay Berlioz. All rights reserved.
//

#import "UniversitiesViewController.h"
#import "University.h"
#import "DataManager.h"
#import "CoursesViewController.h"

@interface UniversitiesViewController () <NSFetchedResultsControllerDelegate>

@end

@implementation UniversitiesViewController
@synthesize fetchedResultsController = _fetchedResultsController;


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"Universities";

//    DataManager *dm = [DataManager sharedManager];
//    
//    [dm generateAndAddUniversity];
}

- (NSFetchedResultsController *)fetchedResultsController
{
    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];

    NSEntityDescription *description = [NSEntityDescription entityForName:@"University"
                                                   inManagedObjectContext:self.managedObjectContext];
    [request setEntity:description];
    
     //how load of necessity
     [request setFetchBatchSize:20];


     NSSortDescriptor *nameDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
    
     [request setSortDescriptors:@[nameDescriptor]];

    
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
    University *university = (University*)object;
    
    cell.textLabel.text = university.name;
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
}



#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    University *university = [[self fetchedResultsController] objectAtIndexPath:indexPath];
    
    CoursesViewController *vc = [[CoursesViewController alloc] init];
    vc.university = university;
    
    [self.navigationController pushViewController:vc animated:YES];
}


@end

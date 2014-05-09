//
//  TAEntryListTableViewController.m
//  MyDiary
//
//  Created by Harish Upadhyayula on 5/7/14.
//  Copyright (c) 2014 tensor apps. All rights reserved.
//

#import "TAEntryListTableViewController.h"
#import "TADiaryEntry.h"
#import "TAEntryViewController.h"
#import "TAEntryCell.h"

@interface TAEntryListTableViewController () <NSFetchedResultsControllerDelegate>

@property (nonatomic,strong)NSFetchedResultsController *fetchResultsController;

@end

@implementation TAEntryListTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.fetchResultsController performFetch:nil];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return self.fetchResultsController.sections.count;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    id <NSFetchedResultsSectionInfo> sectionInfo = [self.fetchResultsController sections][section];
    
    return [sectionInfo name];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    id <NSFetchedResultsSectionInfo> sectionInfo = [self.fetchResultsController sections][section];
    
    // Return the number of rows in the section.
    return [sectionInfo numberOfObjects];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"Cell";
    TAEntryCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    TADiaryEntry *entry = [self.fetchResultsController objectAtIndexPath:indexPath];
    
    [cell cunfigureCellForEntry:entry];
    
    //cell.textLabel.text = entry.body;
    
    return cell;
}

-(UITableViewCellEditingStyle) tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return UITableViewCellEditingStyleDelete;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    TADiaryEntry *entry = [self.fetchResultsController objectAtIndexPath:indexPath];
    return [TAEntryCell heightForEntry:entry];
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    TADiaryEntry *entry = [self.fetchResultsController objectAtIndexPath:indexPath];
    
    TACoreDataStack *coreDataStack = [TACoreDataStack defaultStack];
    
    [[coreDataStack managedObjectContext] deleteObject:entry];
    
    [coreDataStack saveContext];
}

-(NSFetchRequest *)entryListFetchRequest {
    
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"TADiaryEntry"];
    
    fetchRequest.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"date" ascending:NO]];
    
    return fetchRequest;
}

-(NSFetchedResultsController *)fetchResultsController{
    
    if (_fetchResultsController != nil) {
        return _fetchResultsController;
    }else{
        
        TACoreDataStack *coreDataStack = [TACoreDataStack defaultStack];
        NSFetchRequest *fetchRequest = [self entryListFetchRequest];
        
        _fetchResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:coreDataStack.managedObjectContext sectionNameKeyPath:@"sectionName" cacheName:nil];
        
        _fetchResultsController.delegate = self;
        
    }
    return _fetchResultsController;
}

-(void)controllerWillChangeContent:(NSFetchedResultsController *)controller{
    
    [self.tableView beginUpdates];
}

-(void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath{
    switch (type) {
        case NSFetchedResultsChangeInsert:
            [self.tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            break;
        case NSFetchedResultsChangeUpdate:
            [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            break;
        default:
            break;
    }
}

-(void)controller:(NSFetchedResultsController *)controller didChangeSection:(id<NSFetchedResultsSectionInfo>)sectionInfo atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type{
    
    switch (type) {
        case NSFetchedResultsChangeInsert:
            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationAutomatic];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationAutomatic];
            break;
        default:
            break;
    }
    
}

-(void)controllerDidChangeContent:(NSFetchedResultsController *)controller{
    
    [self.tableView reloadData];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"edit"]) {
        UITableViewCell *cell = sender;
        NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
        
        UINavigationController *naivgationController = [segue destinationViewController];
        
        TAEntryViewController *entryViewController = (TAEntryViewController *)naivgationController.topViewController;
        
        entryViewController.entry = [self.fetchResultsController objectAtIndexPath:indexPath];
    }
}

@end

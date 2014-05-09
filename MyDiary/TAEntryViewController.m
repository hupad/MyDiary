//
//  TANewEntryViewController.m
//  MyDiary
//
//  Created by Harish Upadhyayula on 5/7/14.
//  Copyright (c) 2014 tensor apps. All rights reserved.
//

#import "TAEntryViewController.h"
#import "TACoreDataStack.h"
#import "TADiaryEntry.h"

@interface TAEntryViewController ()

@property (nonatomic,assign) enum TADiaryMood pickedMood;

@property (weak, nonatomic) IBOutlet UIButton *badButton;
@property (weak, nonatomic) IBOutlet UIButton *averageButton;
@property (weak, nonatomic) IBOutlet UIButton *goodButton;

@end

@implementation TAEntryViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if (self.entry != nil) {
        self.textFiled.text = self.entry.body;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//#pragma mark - Navigation
//
//// In a storyboard-based application, you will often want to do a little preparation before navigation
//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
//{
//    if (segue.identifier isEqualToString:@"edit") {
//        UITableViewCell *cell = sender;
//        NSIndexPath *indexpath = [self.tab]
//    }
//}


-(void)insertDiaryEntry{
    
    TACoreDataStack *coreData = [TACoreDataStack defaultStack];
    TADiaryEntry *entry = [NSEntityDescription insertNewObjectForEntityForName:@"TADiaryEntry" inManagedObjectContext:coreData.managedObjectContext];
    
    entry.body = self.textFiled.text;
    entry.date = [[NSDate date] timeIntervalSince1970];
    [coreData saveContext];
    
}

-(void)updateDiaryEntry{
    
    self.entry.body = self.textFiled.text;
    TACoreDataStack *coreDataStack = [TACoreDataStack defaultStack];
    
    [coreDataStack saveContext];
}

-(void)dismissSelf{
    
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)doneWasPressed:(id)sender {
    
    if (self.entry != nil) {
        [self updateDiaryEntry];
    }else{

        [self insertDiaryEntry];
    }
    [self dismissSelf];
}

- (IBAction)cancelWasPressed:(id)sender {
    [self dismissSelf];
}

- (IBAction)badWasPressed:(id)sender {
    
    self.pickedMood = TADiaryEntryMoodSad;
}


- (IBAction)averageWasPressed:(id)sender {
    
    self.pickedMood = TADiaryEntryMoodAverage;
}

- (IBAction)goodWasPressed:(id)sender {
    
    self.pickedMood = TADiaryEntryMoodGood;
}

@end

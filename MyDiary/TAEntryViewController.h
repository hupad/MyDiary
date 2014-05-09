//
//  TANewEntryViewController.h
//  MyDiary
//
//  Created by Harish Upadhyayula on 5/7/14.
//  Copyright (c) 2014 tensor apps. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TADiaryEntry;

@interface TAEntryViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *textFiled;

//@property (nonatomic,assign)TADiaryEntryMood pickedMood;

@property (nonatomic,strong)TADiaryEntry *entry;

- (IBAction)doneWasPressed:(id)sender;

- (IBAction)cancelWasPressed:(id)sender;

@end

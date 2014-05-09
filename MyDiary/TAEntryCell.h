//
//  TAEntryCell.h
//  MyDiary
//
//  Created by Harish Upadhyayula on 5/9/14.
//  Copyright (c) 2014 tensor apps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TADiaryEntry.h"

@interface TAEntryCell : UITableViewCell

+(CGFloat)heightForEntry:(TADiaryEntry *)entry;

-(void)cunfigureCellForEntry:(TADiaryEntry *)entry;

@end

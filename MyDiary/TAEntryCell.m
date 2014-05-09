//
//  TAEntryCell.m
//  MyDiary
//
//  Created by Harish Upadhyayula on 5/9/14.
//  Copyright (c) 2014 tensor apps. All rights reserved.
//

#import "TAEntryCell.h"

@interface TAEntryCell ()

@property (weak, nonatomic) IBOutlet UILabel *date;

@property (weak, nonatomic) IBOutlet UILabel *body;

@property (weak, nonatomic) IBOutlet UILabel *location;

@property (weak, nonatomic) IBOutlet UIImageView *mainImage;

@property (weak, nonatomic) IBOutlet UIImageView *mood;

@end

@implementation TAEntryCell

+(CGFloat)heightForEntry:(TADiaryEntry *)entry{
    
    const CGFloat topMargin = 35.0f;
    const CGFloat bottomMargin = 80.0f;
    const CGFloat minHeight = 85.0f;
    
    UIFont *font = [UIFont systemFontOfSize:[UIFont systemFontSize]];
    
    CGRect boundingBox = [entry.body boundingRectWithSize:CGSizeMake(202, CGFLOAT_MAX) options:(NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading) attributes:@{NSFontAttributeName: font} context:nil];
    
    return MAX(minHeight, CGRectGetHeight(boundingBox) + topMargin + bottomMargin);
}


-(void)cunfigureCellForEntry:(TADiaryEntry *)entry{
    
    self.body.text = entry.body;
    self.location.text = entry.location;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"EEEE, MMMM d yyyy"];
    
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:entry.date];
    
    self.date.text = [formatter stringFromDate:date];
    
    if (entry.image) {
        self.mainImage.image = [UIImage imageWithData:entry.image];
    }else{
        self.mainImage.image = [UIImage imageNamed:@"icn_noimage"];
    }
    
    if (entry.mood == TADiaryEntryMoodGood) {
        
        self.mood.image = [UIImage imageNamed:@"icn_happy"];
        
    }else if (entry.mood == TADiaryEntryMoodAverage){
        
        self.mood.image = [UIImage imageNamed:@"icn_average"];
        
    }else if (entry.mood == TADiaryEntryMoodSad){
        
        self.mood.image = [UIImage imageNamed:@"icn_sad"];
        
    }
}

@end

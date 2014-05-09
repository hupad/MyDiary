//
//  TADiaryEntry.m
//  MyDiary
//
//  Created by Harish Upadhyayula on 5/7/14.
//  Copyright (c) 2014 tensor apps. All rights reserved.
//

#import "TADiaryEntry.h"


@implementation TADiaryEntry

@dynamic date;
@dynamic body;
@dynamic image;
@dynamic mood;
@dynamic location;

-(NSString *)sectionName{
    
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:self.date];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:@"MMM yyyy"];
    
    return [dateFormatter stringFromDate:date];
}

@end

//
//  TADiaryEntry.h
//  MyDiary
//
//  Created by Harish Upadhyayula on 5/7/14.
//  Copyright (c) 2014 tensor apps. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


NS_ENUM(int16_t, TADiaryMood){
    TADiaryEntryMoodGood = 0,
    TADiaryEntryMoodAverage = 1,
    TADiaryEntryMoodSad = 2
};

@interface TADiaryEntry : NSManagedObject

@property (nonatomic) NSTimeInterval date;
@property (nonatomic, retain) NSString * body;
@property (nonatomic, retain) NSData * image;
@property (nonatomic) int16_t mood;
@property (nonatomic, retain) NSString * location;
@property (nonatomic,readonly)NSString *sectionName;

@end

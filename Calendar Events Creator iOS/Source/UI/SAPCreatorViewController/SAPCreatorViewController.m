//
//  SAPCreatorViewController.m
//  Calendar Events Creator iOS
//
//  Created by Andrey on 8/9/16.
//  Copyright © 2016 Andrey. All rights reserved.
//

#import "SAPCreatorViewController.h"

#import <EventKitUI/EventKitUI.h>

static NSUInteger kSAPeventsPerCalendarCount = 500;
static NSString * const kSAPEventTitle = @"Test Event";

@interface SAPCreatorViewController ()

- (IBAction)onCreateEventsButton:(id)sender;

@end

@implementation SAPCreatorViewController

#pragma mark -
#pragma mark Interface Handling

- (IBAction)onCreateEventsButton:(id)sender {
#warning TODO weakify self    
    EKEventStore *store = [[EKEventStore alloc] init];
    [store requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError * _Nullable error) {
        [self createCalendarsAndEventsInStore:store];
    }];
}

#pragma mark -
#pragma mark Private

- (void)createCalendarsAndEventsInStore:(EKEventStore *)store {
    NSArray<EKCalendar *> *calendars = [store calendarsForEntityType:EKEntityTypeEvent];
    
    NSString *title1 = @"Test Events 1";
    NSString *title2 = @"Test Events 2";
    NSArray<NSString *> *titles = @[title1, title2];
    NSMutableArray<NSString *> *titlesToCreate = [titles mutableCopy];
    
    for (EKCalendar *calendar in calendars) {
        if ([titles containsObject:calendar.title]) {
            [self eventsForCalendar:calendar eventStore:store withCount:kSAPeventsPerCalendarCount];
            [titlesToCreate removeObject:calendar.title];
        }
    }
    
    for (NSString *title in titlesToCreate) {
        EKCalendar *calendar = [self calendarWithTitle:title eventStore:store];
        NSError *error = nil;
        BOOL result = [store saveCalendar:calendar commit:YES error:&error];
        if (result) {
            NSLog(@"Saved calendar %@", calendar.title);
            
            [self eventsForCalendar:calendar eventStore:store withCount:kSAPeventsPerCalendarCount];
        } else {
            NSLog(@"Error saving calendar: %@.", error);
        }
    }
}

- (void)eventsForCalendar:(EKCalendar *)calendar eventStore:(EKEventStore *)store withCount:(NSUInteger)count {
    
    NSDate *startDate = [NSDate date];
    for (NSUInteger counter = 0; counter < count; counter++) {
        EKEvent *event = [EKEvent eventWithEventStore:store];
        event.title = kSAPEventTitle;
        event.calendar = calendar;
        event.startDate = startDate;
        
        NSCalendar *helpCalendar = [NSCalendar currentCalendar];
        NSDateComponents *dateComponents = [NSDateComponents new];
        dateComponents.hour = 1;
        
        event.endDate = [helpCalendar dateByAddingComponents:dateComponents toDate:startDate options:0];
        
        [store saveEvent:event span:EKSpanThisEvent commit:YES error:nil];
        NSLog(@"Saved event %@ for date %@", event.title, startDate);
        
        dateComponents = [NSDateComponents new];
        dateComponents.day = 1;
        startDate = [helpCalendar dateByAddingComponents:dateComponents toDate:startDate options:0];
    }
}

- (EKCalendar *)calendarWithTitle:(NSString *)title eventStore:(EKEventStore *)store {
    EKCalendar *calendar = [EKCalendar calendarForEntityType:EKEntityTypeEvent eventStore:store];
    calendar.title = title;
    
    EKSource *localSource = nil;
    for (EKSource *source in store.sources) {
        if (source.sourceType == EKSourceTypeLocal) {
            localSource = source;
            break;
        }
    }
    
    calendar.source = localSource;
    
    return calendar;
}


@end

//
//  Reminder.m
//  LocationReminders
//
//  Created by Benjamin Laddin on 9/7/15.
//  Copyright (c) 2015 Benjamin Laddin. All rights reserved.
//

#import "Reminder.h"


@interface Reminder()

@end

@implementation Reminder


@dynamic name;
@dynamic user;
@dynamic latCoordinate;
@dynamic longCoordinate;

+ (NSString *__nonnull)parseClassName {
  return @"Reminder";
}
@end

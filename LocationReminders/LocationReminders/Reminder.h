//
//  Reminder.h
//  LocationReminders
//
//  Created by Benjamin Laddin on 9/7/15.
//  Copyright (c) 2015 Benjamin Laddin. All rights reserved.
//

#import <Parse/Parse.h>

@interface Reminder : PFObject <PFSubclassing>

@property (strong,nonatomic) NSString *name;
@property (strong,nonatomic) PFUser *user;
@property (strong,nonatomic) NSString *latCoordinate;
@property (strong,nonatomic) NSString *longCoordinate;

@end

//
//  Person.h
//  MyDemo
//
//  Created by Benjamin Laddin on 8/31/15.
//  Copyright (c) 2015 Benjamin Laddin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject

//everything public goes in between here


@property (strong,nonatomic) NSString *name;


-(void)changeSSN;

- (void)changeName:(NSString *)newName andChangeSSN: (NSNumber *)newSSN andChangeAge:(NSNumber *)newAge;
- (instancetype)initWithName:(NSString *)name age:(NSNumber *)age SSN:(NSNumber *)SSN;

@end

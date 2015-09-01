//
//  Person.m
//  MyDemo
//
//  Created by Benjamin Laddin on 8/31/15.
//  Copyright (c) 2015 Benjamin Laddin. All rights reserved.
//

#import "Person.h"


@interface Person()

@property (strong, nonatomic)NSNumber *SSN;
@property (strong, nonatomic)NSNumber *age;
@property (strong, nonatomic)NSMutableArray *friends;


@end


@implementation Person

- (instancetype)initWithName:(NSString *)name age:(NSNumber *)age SSN:(NSNumber *)SSN {
  if (self = [super init]) {
    _name = name;
    _age = @30;
    _SSN = @4234345;
  }
  return self;
}

-(void)changeSSN{
  self.SSN = @123456; // using property  + dot syntax best way to call
  [self setSSN:@123446]; // using setter
  _SSN = @123456; // using ivar directly, violates style guide, only use the ivars directly inside the initilizer, mainly use the dot sytax
  
}

- (void)changeName:(NSString *)newName andChangeSSN: (NSNumber *)newSSN andChangeAge:(NSNumber *)newAge{
  self.name = newName;
  self.SSN = newSSN;
  self.age = newAge;
  
}

-(void)setAge:(NSNumber *)age{
  _age = age;
}
-(NSMutableArray *)friends{
  if (!_friends) {
    _friends = [[NSMutableArray alloc] init];
  }
  return _friends;
}

@end

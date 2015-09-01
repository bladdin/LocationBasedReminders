//
//  ViewController.m
//  MyDemo
//
//  Created by Benjamin Laddin on 8/31/15.
//  Copyright (c) 2015 Benjamin Laddin. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"

//always import .h's also everything nees to be imported like Java

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  NSString *myName = @"Ben";
  
  NSLog(@"my name is: %@ %@", myName, myName);
  
  
  //always use alloc and init
  UIView *redView = [[UIView alloc] init];
  
  //NEVER USE NEW LIKE BELOW
  UIView *dontDoThisView = [UIView new];
  
  [self.view addSubview:redView];
  
  Person *person = [[Person alloc]init];
  
  [person setName:@"Ben"]; // setter not the prefered way
  [person name]; // getter not the prefered way
  
  person.name = @"Ben"; //prefered way dot syntax, getter
  NSString *anotherName = person.name; // Setter dot syntax
  [person changeSSN];
  
  [person changeName:@"Chad" andChangeSSN:@1234345456 andChangeAge:@100];
  
  
  
  

}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}



@end

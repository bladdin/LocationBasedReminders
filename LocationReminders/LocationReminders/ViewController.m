//
//  ViewController.m
//  LocationReminders
//
//  Created by Benjamin Laddin on 8/31/15.
//  Copyright (c) 2015 Benjamin Laddin. All rights reserved.
//

#import "ViewController.h"
#import <MapKit/MapKit.h>

@interface ViewController ()
@property (weak, nonatomic) IBOutlet MKMapView *MKMapView;
@property (weak, nonatomic) IBOutlet UIButton *nyButton;
@property (weak, nonatomic) IBOutlet UIButton *seattleButton;
@property (weak, nonatomic) IBOutlet UIButton *tokyoButton;


@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
}


- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}


- (IBAction)newYorkButtonPressed:(id)sender {
  [self.MKMapView setRegion:MKCoordinateRegionMakeWithDistance(CLLocationCoordinate2DMake(40.7127, -74.0059), 100, 100) animated:true];
}
- (IBAction)seattleButtonPressed:(id)sender {
  [self.MKMapView setRegion:MKCoordinateRegionMakeWithDistance(CLLocationCoordinate2DMake(47.6097, -122.3331), 100, 100) animated:true];
}
- (IBAction)tokyoButtonPressed:(id)sender {
  [self.MKMapView setRegion:MKCoordinateRegionMakeWithDistance(CLLocationCoordinate2DMake(35.6833, 139.6833), 100, 100) animated:true];
}

@end

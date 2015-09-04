//
//  ViewController.m
//  LocationReminders
//
//  Created by Benjamin Laddin on 8/31/15.
//  Copyright (c) 2015 Benjamin Laddin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import <Parse/Parse.h>

@interface ViewController () <CLLocationManagerDelegate, MKMapViewDelegate>
@property (weak, nonatomic) IBOutlet MKMapView *MKMapView;
@property (weak, nonatomic) IBOutlet UIButton *nyButton;
@property (weak, nonatomic) IBOutlet UIButton *seattleButton;
@property (weak, nonatomic) IBOutlet UIButton *tokyoButton;

@property (copy, nonatomic) void(^myBlock)(NSString *);
@property (strong, nonatomic) CLLocationManager *locationManager;


@end

@implementation ViewController

- (void)viewDidLoad{
  [super viewDidLoad];
 // self.myBlock = ^void(NSString *name){
//}
  self.MKMapView.delegate = self;
  self.MKMapView.showsUserLocation = true;
  NSLog(@"%d", [CLLocationManager authorizationStatus]);
  self.locationManager = [[CLLocationManager alloc]init];
  self.locationManager.delegate = self;
  [self.locationManager requestWhenInUseAuthorization];
  
  [self.locationManager startUpdatingLocation];
  
  
  UILongPressGestureRecognizer *longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(mapLongPress:)];
  longPressGesture.minimumPressDuration = 1.5;
  [self.MKMapView addGestureRecognizer:longPressGesture];
  
  //[longPressGesture release];
  
}

- (void)mapLongPress:(UIGestureRecognizer *)gestureRecognizer{
  if (gestureRecognizer.state != UIGestureRecognizerStateBegan)
    return;
  CGPoint touchPoint = [gestureRecognizer locationInView: self.MKMapView];
  CLLocationCoordinate2D touchMapCoordinate = [self.MKMapView convertPoint:touchPoint toCoordinateFromView:self.MKMapView];
  NSLog(@"long Gesture");
  MKPointAnnotation *annot = [[MKPointAnnotation alloc] init];
  annot.coordinate = touchMapCoordinate;
  annot.title = @"Heres a Pin";
  [self.MKMapView addAnnotation:annot];
  }

//location magager delagate

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status{
  switch (status) {
    case kCLAuthorizationStatusAuthorizedWhenInUse:
      [self.locationManager startUpdatingLocation];
      break;
      
    default:
      break;
  }
  
}

//- (void)locationManager:(CLLocationManager *)manger didUpdateLocations:(NSArray *)locations{
//  CLLocation *Location = locations.lastObject;
//}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control{
  [self performSegueWithIdentifier:@"toAddReminderDetailViewController" sender:view];
}

//-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(MKAnnotationView *)sender{
//  if ([segue.identifier isEqualToString:@"DetailViewController"]) {
//    
//  }
//}

- (MKAnnotationView *) mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation{
  if([annotation isKindOfClass: [MKUserLocation class]]){
    NSLog(@"nil print");
    return nil;
  }
//- (MKAnnotationView *) mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation{
//
//  }
//  MKPinAnnotationView *pinView = (MKPinAnnotationView *)[MKMapView dequeueReusableAnnotationViewWithIdentifier:@"AnnotationView"];
  
  MKPinAnnotationView *pinView = (MKPinAnnotationView *) [mapView dequeueReusableAnnotationViewWithIdentifier:@"AnnotationView"];
  
  if (!pinView) {
    pinView = [[MKPinAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:@"AnnotationView"];
  }
  pinView.annotation = annotation;
  pinView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
  pinView.canShowCallout = YES;
  pinView.calloutOffset = CGPointMake(0, 0);
  pinView.animatesDrop = true;
  
  
  NSLog(@"Returned ok");
  return pinView;
}

- (IBAction)newYorkButtonPressed:(id)sender {
  [self.MKMapView setRegion:MKCoordinateRegionMakeWithDistance(CLLocationCoordinate2DMake(40.7127, -74.0059), 100, 100) animated:true];
  [UIView animateWithDuration:0.3 animations:^{
    //
  }];
}
- (IBAction)seattleButtonPressed:(id)sender {
  [self.MKMapView setRegion:MKCoordinateRegionMakeWithDistance(CLLocationCoordinate2DMake(47.6097, -122.3331), 100, 100) animated:true];
}
- (IBAction)tokyoButtonPressed:(id)sender {
  [self.MKMapView setRegion:MKCoordinateRegionMakeWithDistance(CLLocationCoordinate2DMake(35.6833, 139.6833), 100, 100) animated:true];
}

@end

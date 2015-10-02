//
//  ViewController.m
//  LocationReminders
//
//  Created by Benjamin Laddin on 8/31/15.
//  Copyright (c) 2015 Benjamin Laddin. All rights reserved.
//


#import "ViewController.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import <Parse/Parse.h>
#import <ParseUI/ParseUI.h>
#import "AddReminderDetailViewController.h"

@interface ViewController () <CLLocationManagerDelegate, MKMapViewDelegate, PFSignUpViewControllerDelegate, PFLogInViewControllerDelegate>
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
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addAnotiation:) name:(@"textNotification") object:nil];
   
  //sign up to receive notification for a given name
  
  
  
  
  self.MKMapView.delegate = self;
  self.MKMapView.showsUserLocation = true;
  NSLog(@"%d", [CLLocationManager authorizationStatus]);
  self.locationManager = [[CLLocationManager alloc]init];
  self.locationManager.delegate = self;
  [self.locationManager requestWhenInUseAuthorization];
  [self.locationManager startUpdatingLocation];
//  double latDouble = [latText doubleValue];
//  double longDouble = [longText doubleValue];
  
  
  UILongPressGestureRecognizer *longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(mapLongPress:)];
  longPressGesture.minimumPressDuration = 1.5;
  [self.MKMapView addGestureRecognizer:longPressGesture];
  
  //[longPressGesture release];
  
//  PFGeoPoint *geoPoint = [PFGeoPoint geoPointWithLatitude:latDouble longitude:longDouble];
//  PFObject *reminderPlaces = [[PFObject alloc] initWithClassName:@"reminderPlaces"];
//  reminderPlaces[@"location"] = geoPoint;
//  reminderPlaces[@"name"] = reminderText;
  
//  [reminderPlaces saveInBackground];
//  [reminderPlaces saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error){
//    if (error) {
//      
//    }else if (succeeded){
//     
//      
//    }
//  }];
  
  //PFQuery *query = [PFQuery queryWithClassName:@"reminderPlaces"];
  //[query whereKey:@"location" nearGeoPoint:geoPoint];
//  [query findObjectsInBackgroundWithBlock:^()NSArray *objects, NSError *error]{
//    NSLog(@)
//  }
  
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

-(void)addAnotiation: (NSNotification *)sender{
  
  
  NSNumber *lat = [sender.userInfo objectForKey:@"latTextField"];
  NSNumber *longi = [sender.userInfo objectForKey:@"longTextField"];
  
  NSLog(@"%@",lat);
  
  double latDou = [lat doubleValue];
  double longDou = [longi doubleValue];

  NSString *reminderTitle = [sender.userInfo objectForKey:@"reminderTextfield"];
  
  PFGeoPoint* geoPoint = [PFGeoPoint geoPointWithLatitude:latDou longitude:longDou];
  PFObject *place = [[PFObject alloc] initWithClassName:@"Place"];
  place[@"location"] = geoPoint;
  place[@"name"] = reminderTitle;
  
  [place saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
    if (error) {
      NSLog(@"There was an error");
    }else if (succeeded)
      [place saveInBackground];
  }];
  
  MKPointAnnotation *annot = [[MKPointAnnotation alloc]init];
  annot.coordinate = CLLocationCoordinate2DMake(latDou, longDou);
  annot.title = reminderTitle;
  [self.MKMapView addAnnotation:annot];
  [[NSNotificationCenter defaultCenter]removeObserver:self name:@"textNotification" object:nil];
}


//write method that fires when notification is received, this will upload the reminder to parse
//pull the userInfo dictionary out of the notification



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

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
  CLLocation *location = locations.lastObject;
}

- (void)locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region{
  NSLog(@"entered region");
  
  UILocalNotification *notification = [[UILocalNotification alloc]init];
  notification.alertTitle = @"Region Entered";
  notification.alertBody = @"You have entered your intended region";
}


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

-(MKOverlayRenderer *)mapView:(MKMapView *) MKMapView rendererForOverlay:(id<MKOverlay>)overlay {
  MKCircleRenderer *circleRenderer = [[MKCircleRenderer alloc] initWithOverlay:overlay];
  
  circleRenderer.fillColor = [UIColor redColor];
  circleRenderer.alpha = 0.5;
  
  return circleRenderer;
}


@end

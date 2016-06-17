//
//  ViewController.m
//  love
//
//  Created by Jordan White on 2/7/15.
//  Copyright (c) 2015 Two Beards and Fro. All rights reserved.
//

#import "ViewController.h"
#import "JPRequest.h"

//@interface ViewController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate>


@interface ViewController ()

@property (strong, nonatomic) CLLocationManager *manager;
@property (weak, nonatomic) IBOutlet UILabel *longLabel;
@property (weak, nonatomic) IBOutlet UILabel *latLabel;


@end

//test to push

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpLocation];
}


- (void) setUpLocation {
 
    self.manager = [CLLocationManager new];
    self.manager.delegate = self;
    [self.manager requestWhenInUseAuthorization];
    
    //change the desired specifity of the location
    self.manager.desiredAccuracy = kCLLocationAccuracyBest;
    //self.manager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
}


- (void)startLocation {
    [self.manager startUpdatingLocation];
}


- (IBAction)click:(UIButton *)sender {
    [self startLocation];
    
}


/*
 threee different methods
*/
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    
    NSLog(@"hit");
    [self.manager stopUpdatingLocation];
    
    CLLocation *newLocation = [locations objectAtIndex:locations.count - 1];
    NSLog(@"%@", newLocation);
    
    NSString *longitude = [[NSString alloc]initWithFormat:@"%f", newLocation.coordinate.longitude];
    NSString *latitude = [[NSString alloc] initWithFormat:@"%f", newLocation.coordinate.latitude];

  /* curl -d '{"location": { "lat": "-33.424994", "lon": "-70.619586" }}' "https://api.ezhing.com/1.0/data/thingId?type=shabit&apikey=pUMImlf11a7UiXfoQ0ytbFA0MzOSUmuF1xrq8t-D-PA"
    */
    
   //  NSString *postData =@"{\"location\":{\"lat\":\"-33.424994\",\"lon\":\"-70.619586\"}}";
    
    
     NSString *strPOST = [NSString stringWithFormat: @"{\"location\":{\"lat\":\"%@\",\"lon\":\"%@\"}}", latitude, longitude];
     NSString *urlPost =@"https://api.ezhing.com/1.0/data/shabit?type=person&apikey=pUMImlf11a7UiXfoQ0ytbFA0MzOSUmuF1xrq8t-D-PA";
    
    NSString *replyPOST = [JPRequest postRequestWithUrl:urlPost andPostData:strPOST];
    NSLog(@"%@ --- [%@]  ",replyPOST,strPOST);
    
    
    [self.longLabel setText:longitude];
    [self.latLabel setText:latitude];
    
}

- (void)locationManager:(CLLocationManager *)manager didUpdateHeading:(CLHeading *)newHeading {
    
    NSLog(@"hit2");
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

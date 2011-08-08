    //
//  SecondViewController.m
//  delicious memory
//
//  Created by LIN CHUN KU on 2011/7/12.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SecondViewController.h"
#import "addNewPlaceFromMap.h"
#import "AppAnnotation.h"

@implementation SecondViewController

@synthesize mapView;

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	locationManager	= [[CLLocationManager alloc] init];
	locationManager.delegate = self;
	locationManager.desiredAccuracy = kCLLocationAccuracyBest;
	locationManager.distanceFilter = 10;
	[locationManager startUpdatingLocation];
	
	
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[locationManager release];
    [super dealloc];
}

-(void)addNewPlace{
	NSLog(@"addNewPlace");
	addNewPlaceFromMap *newViewController = [[addNewPlaceFromMap alloc] init];
	UIBarButtonItem *backBar = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleDone target:nil action:nil];
	self.navigationItem.backBarButtonItem = backBar;
	[self.navigationController pushViewController:newViewController animated:YES];
	[newViewController release];
}

#pragma mark -
#pragma mark MKMapViewDelegate

- (MKAnnotationView *) mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>) annotation{
	NSLog(@"ViewForAnnotation!!!!!!!");
	//方法一：using default pin as a PlaceMarker to display on map
	if ([annotation isKindOfClass:[AppAnnotation class]] == YES) {
		NSLog(@"It is my AppANnotation");
		if ([[annotation RStatus] isEqualToString:@"NEW"]==YES) {
			NSLog(@"it is NEW");
			MKPinAnnotationView *newAnnotation = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"newAnnotation"];
			newAnnotation.pinColor = MKPinAnnotationColorGreen;
			newAnnotation.animatesDrop = YES; 
			newAnnotation.canShowCallout = YES;
			UIButton *detailButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
			[detailButton addTarget:self action:@selector(addNewPlace) forControlEvents:UIControlEventTouchUpInside];
			
			newAnnotation.rightCalloutAccessoryView = detailButton;
			return newAnnotation;
			
		}
	}
	return nil;
		
}
#pragma mark -
#pragma mark CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
	CLLocationCoordinate2D coord = newLocation.coordinate;
	NSLog(@"self in locationManager delegate = %@", self);
	
	
	/*
	self.displayLatitude.text = [NSString stringWithFormat:@"%f", coord.latitude];
	self.displayLongitude.text = [NSString stringWithFormat:@"%f", coord.longitude];
	 */
	[self initialMapView:coord];
	[locationManager stopUpdatingLocation];
}

#pragma mark -
#pragma mark instance Method

-(void)initialMapView:(CLLocationCoordinate2D)coord{
	NSLog(@"This is Second View Controller, latitude = %f, logitude = %f", coord.latitude, coord.longitude);
	//mapView.delegate = self;
	
	mapView = [[MKMapView alloc] initWithFrame:CGRectMake(0, 0, 320, 411)];
	mapView.showsUserLocation = YES;
	MKCoordinateRegion region;
	region.center = coord;
	MKCoordinateSpan span;
	span.latitudeDelta = 0.004;
	span.longitudeDelta = 0.004;
	region.span =span;
	[mapView setRegion:region];
	mapView.delegate = self;
	mapView.userInteractionEnabled = YES;
	 [self.view addSubview:mapView];
	UILongPressGestureRecognizer *lpgr = [[UILongPressGestureRecognizer alloc] 
										  initWithTarget:self action:@selector(handleLongPress:)];
	//lpgr.minimumPressDuration = 2.0; //user needs to press for 2 seconds; default is 0.4 seconds
	[self.mapView addGestureRecognizer:lpgr];
	[lpgr release];
	
}

#pragma mark -
#pragma mark longPress Gesture
- (void)handleLongPress:(UIGestureRecognizer *)gestureRecognizer
{   
    
	if (gestureRecognizer.state == UIGestureRecognizerStateEnded ){
		NSLog(@"UIGestureRecognizerStateEnded");
		//[self.mapView removeAnnotations:mapView.annotations];
		CGPoint touchPoint = [gestureRecognizer locationInView:self.mapView];   
		CLLocationCoordinate2D touchMapCoordinate = 
		[self.mapView convertPoint:touchPoint toCoordinateFromView:self.mapView];
	
		AppAnnotation *annot = [[AppAnnotation alloc] initAnnotation:0 andName:@"新增餐廳" andStatus:@"NEW" andLocation:touchMapCoordinate];
		[self.mapView addAnnotation:annot];
		[annot release];
	}
	
}

@end

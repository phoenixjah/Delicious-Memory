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
#import <sqlite3.h>

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

	//add new record in this  暫時放在這吧
	[self addNewDataInDB:@"HELLO WORLD"];
	//
	UIBarButtonItem *backBar = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleDone target:nil action:nil];
	self.navigationItem.backBarButtonItem = backBar;
	[self.navigationController pushViewController:newViewController animated:YES];
	[newViewController release];
}

-(void)addNewDataInDB:(NSString*)test_text{
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsPath = [paths objectAtIndex:0];
    NSString *dbPath = [documentsPath stringByAppendingPathComponent:@"place_list.db"];
	// check db exists
    BOOL firstUse = ![[NSFileManager defaultManager] fileExistsAtPath:dbPath];
	
	sqlite3 *db;
    char *err_report;
	//char *textInDB = [[NSString stringWithFormat:@"INSERT INTO list_table VALUES('%@');",test_text] UTF8String];
    
    if ( sqlite3_open( [dbPath UTF8String] , &db ) == SQLITE_OK ) {
        //NSLog( @"%s" , dbPath );
        if ( firstUse ) {
            if( sqlite3_exec( db , "CREATE TABLE IF NOT EXISTS list_table( filed1 char(20));" , NULL , NULL , &err_report ) != SQLITE_OK )
                NSLog( @"%s" , err_report );
		}
		NSString *command = [NSString stringWithFormat:@"INSERT INTO list_table VALUES('%@');",test_text];
				if( sqlite3_exec( db , [command cStringUsingEncoding:NSUTF8StringEncoding], NULL , NULL , &err_report ) != SQLITE_OK )
                NSLog( @"%s" , err_report );
        
    } else {
        NSLog( @"Cannot open databases: %s" , dbPath);
    }
    sqlite3_close( db );
	
}

#pragma mark -
#pragma mark MKMapViewDelegate

- (MKAnnotationView *) mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>) annotation{
	NSLog(@"ViewForAnnotation!!!!!!!");
	//方法一：using default pin as a PlaceMarker to display on map
	if ([annotation isKindOfClass:[AppAnnotation class]] == YES) {
		if ([[annotation getRStatus] isEqualToString:@"NEW"] == YES) {
			MKPinAnnotationView *newAnnotation = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"newAnnotation"];
			newAnnotation.pinColor = MKPinAnnotationColorGreen;
			newAnnotation.animatesDrop = YES; 
			newAnnotation.canShowCallout = YES;
			UIButton *detailButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
			//[detailButton addTarget:self action:@selector(addNewPlace) forControlEvents:UIControlEventTouchUpInside];
			
			newAnnotation.rightCalloutAccessoryView = detailButton;
			return newAnnotation;
			
		}
	}
	return nil;
		
}

- (void)mapView:(MKMapView *)theMapView didSelectAnnotationView:(MKAnnotationView *)view{
    if(view.annotation == theMapView.userLocation){
		
        theMapView.userLocation.title = @"新增餐廳";
        view.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];       
    }
}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control{
	[self addNewPlace];
}


#pragma mark -
#pragma mark CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
	CLLocationCoordinate2D coord = newLocation.coordinate;
	NSLog(@"self in locationManager delegate = %@", self);
	NSLog(@"Show locationManager.");
	
	
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
		NSLog(@"annotations = %@", mapView.annotations);
		id annotation = [mapView.annotations objectAtIndex:0];
		
		if ([annotation isKindOfClass:[AppAnnotation class]] == YES) {
			[self.mapView removeAnnotation:annotation];
		}

		CGPoint touchPoint = [gestureRecognizer locationInView:self.mapView];   
		CLLocationCoordinate2D touchMapCoordinate = 
		[self.mapView convertPoint:touchPoint toCoordinateFromView:self.mapView];
	
		AppAnnotation *annot = [[AppAnnotation alloc] initAnnotation:0 andName:@"新增餐廳" andStatus:@"NEW" andLocation:touchMapCoordinate];
		[self.mapView addAnnotation:annot];
		[annot release];
	}
	
}

@end

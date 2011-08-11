//
//  SecondViewController.h
//  delicious memory
//
//  Created by LIN CHUN KU on 2011/7/12.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>


@interface SecondViewController : UIViewController<CLLocationManagerDelegate, MKMapViewDelegate, UISearchBarDelegate>{
	CLLocationManager* locationManager;
	MKMapView *mapView;
	UISearchBar *searchBar;
}

@property (retain, nonatomic) MKMapView *mapView;
@property (retain, nonatomic) UISearchBar *searchBar;

-(void)initialMapView:(CLLocationCoordinate2D)coord;
-(void)addNewPlace;
-(void)addNewDataInDB:(NSString*)test_text;

@end

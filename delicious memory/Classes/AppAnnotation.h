//
//  AppAnnotation.h
//  delicious memory
//
//  Created by LIN CHUN KU on 2011/7/19.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>


@interface AppAnnotation : NSObject <MKAnnotation>{
	CLLocationCoordinate2D coordinate;
	NSString *title;
	NSString *RStatus;
	int number;
}


@property (nonatomic, assign, readwrite) CLLocationCoordinate2D coordinate;
@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSString *RStatus;
@property int number;

- (id)initAnnotation:(int)rid andName:(NSString*)name andStatus:(NSString*)status andLocation:(CLLocationCoordinate2D)coord;
- (NSString *)getRStatus;

@end

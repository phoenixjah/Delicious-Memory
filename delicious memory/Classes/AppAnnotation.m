//
//  AppAnnotation.m
//  delicious memory
//
//  Created by LIN CHUN KU on 2011/7/19.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AppAnnotation.h"


@implementation AppAnnotation

@synthesize title, RStatus;
@synthesize number;
@synthesize coordinate;

- (id)initAnnotation:(int)rid andName:(NSString*)name andStatus:(NSString*)status andLocation:(CLLocationCoordinate2D)coord{
	if(self = [super init]){
		self.coordinate = coord;
		self.title = name;
		self.number = rid;
		self.RStatus = status;
	}
	return self;
}

- (NSString *)title {
	return title;
}

- (NSString *)RStatus{
	return RStatus;
}

@end

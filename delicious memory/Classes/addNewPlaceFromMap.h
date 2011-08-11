//
//  addNewPlaceFromMap.h
//  delicious memory
//
//  Created by LIN CHUN KU on 2011/7/19.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface addNewPlaceFromMap : UIViewController {
	IBOutlet UILabel *text;
	NSMutableArray *dataSource;
}

@property (nonatomic, retain) IBOutlet UILabel *text;

@end

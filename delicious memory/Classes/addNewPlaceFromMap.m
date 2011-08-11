//
//  addNewPlaceFromMap.m
//  delicious memory
//
//  Created by LIN CHUN KU on 2011/7/19.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "addNewPlaceFromMap.h"
#import <sqlite3.h>

static int CallBackFetchRowHandling( void * context , int count , char **value, char **column ) {
	NSMutableArray *dataSource = (NSMutableArray*) context;
    for ( int i=0 ; i<count ; i++ ) {
        NSLog( @"%s" , value[i] );
		NSLog(@"column = %s", column[i]);
		NSLog(@"%d", count);
		NSLog(@"測試");
        //[dataSource addObject:[NSString stringWithUTF8String:value[i]]];
		NSString *test = [NSString stringWithUTF8String:value[i]];
        [dataSource addObject: [NSString stringWithFormat:@"%@", test]];
    }	
    return SQLITE_OK;
}

@implementation addNewPlaceFromMap
@synthesize text;


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


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	NSLog(@"addNewPlaceFromMap viewDidLoad");
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsPath = [paths objectAtIndex:0];
    NSString *dbPath = [documentsPath stringByAppendingPathComponent:@"place_list.db"];
	dataSource = [[NSMutableArray alloc] init];
	// check db exists
    sqlite3 *db;
    char *err_report;
	if ( sqlite3_open( [dbPath UTF8String] , &db ) == SQLITE_OK ) {
        NSLog(@"Here I am");
        if ( sqlite3_exec( db , "SELECT * FROM list_table" , CallBackFetchRowHandling, dataSource, &err_report ) != SQLITE_OK ) {
            NSLog( @"%s" , err_report );
			
        }
		NSLog(@"dataSource=%@", dataSource);
		text.text = [dataSource objectAtIndex:0];
    } else {
        NSLog( @"Cannot open databases: %s" , dbPath);
    }
    sqlite3_close( db );
	NSLog(@"dataSource count = %d", [dataSource count]);
	
	
    [super viewDidLoad];
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
    [super dealloc];
}


@end

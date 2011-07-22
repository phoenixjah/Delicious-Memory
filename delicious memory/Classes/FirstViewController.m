//
//  FirstViewController.m
//  delicious memory
//
//  Created by Chia Lin on 2011/7/2.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "FirstViewController.h"
#import "MyMenuTableViewController.h"

@implementation FirstViewController
@synthesize orderedMenu,unorderedMenu;
/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
	//self.navigationItem.prompt = NSLocalizedString(@"My Menu", @"FirstViewController");

	// segmented control as the custom title view
	NSArray *segmentTextContent = [NSArray arrayWithObjects:NSLocalizedString(@"吃過的", @""), NSLocalizedString(@"想去吃的", @""),nil];
	UISegmentedControl *segmentedControl = [[UISegmentedControl alloc] initWithItems:segmentTextContent];
	segmentedControl.selectedSegmentIndex = 0;
	segmentedControl.autoresizingMask = UIViewAutoresizingFlexibleWidth;
	segmentedControl.segmentedControlStyle = UISegmentedControlStyleBar;
	segmentedControl.frame = CGRectMake(0, 0, 180, 30);
	[segmentedControl addTarget:self action:@selector(segmentAction:) forControlEvents:UIControlEventValueChanged];
	
	//defaultTintColor = [segmentedControl.tintColor retain];	// keep track of this for later
    
	self.navigationItem.titleView = segmentedControl;
	[segmentedControl release];
    
    self.orderedMenu = [[MyMenuTableViewController alloc]initWithStyle:UITableViewStylePlain];
    self.unorderedMenu =[[MyMenuTableViewController alloc]initWithStyle:UITableViewStylePlain];
    [self.view addSubview:self.orderedMenu.view];

}


- (IBAction)segmentAction:(id)sender
{
	// The segmented control was clicked, handle it here 
	UISegmentedControl *segmentedControl = (UISegmentedControl *)sender;
    
    if (segmentedControl.selectedSegmentIndex == 0) {//ordered menu
        
        if ([self.unorderedMenu.view superview]) {
    
            [self.unorderedMenu.view removeFromSuperview];
            [self.view addSubview:self.orderedMenu.view];
        }
        
    } else {//unordered menu
        
        if([self.orderedMenu.view superview]){
            
            [self.orderedMenu.view removeFromSuperview];
            [self.view addSubview:self.unorderedMenu.view];
        }
        
    }
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload
{
    self.orderedMenu = nil;
    self.unorderedMenu = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
}


- (void)dealloc {

    [super dealloc];
    [orderedMenu dealloc];
    [unorderedMenu dealloc];
}

@end

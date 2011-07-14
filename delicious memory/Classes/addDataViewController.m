    //
//  addDataViewController.m
//  delicious memory
//
//  Created by Chia Lin on 2011/7/12.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "addDataViewController.h"


@implementation addDataViewController
@synthesize imagePickerController;
//@synthesize overlayViewController;
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

#pragma mark -
#pragma mark ViewController

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	
	self.imagePickerController = [[[UIImagePickerController alloc] init] autorelease];
	self.imagePickerController.delegate = self;
	/*
	self.overlayViewController = [[[OverlayViewController alloc]initWithNibName:@"OverlayViewController" bundle:nil ] autorelease];
	self.overlayViewController.delegate = self;
	
    //[super viewDidLoad];
*/
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
	[imagePickerController release];
    [super dealloc];
}

#pragma mark -
#pragma mark TakePicture


-(IBAction)cameraAction:(id)sender{
	
	if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
		self.imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
		
		[self presentModalViewController:self.imagePickerController animated:YES];
	}
}


#pragma mark -
#pragma mark UIImagePickerControllerDelegate

// this get called when an image has been chosen from the library or taken from the camera
//
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = [info valueForKey:UIImagePickerControllerOriginalImage];
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissModalViewControllerAnimated:YES];    // tell our delegate we are finished with the picker
}
@end

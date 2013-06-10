//
//  CISInformViewController.m
//  Hungry Hungry Hobos
//
//  Created by Jack Fletcher on 4/25/13.
//  Copyright (c) 2013 Cisco. All rights reserved.
//

#import "CISInformViewController.h"
#import <Twitter/Twitter.h>
#import <MessageUI/MessageUI.h>
#define letOSHandleLogin FALSE

@interface CISInformViewController ()
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *officeLabel;
@property (weak, nonatomic) IBOutlet UIButton *tweetButton;
@property (weak, nonatomic) IBOutlet UILabel *tweetLabel;
@property (weak, nonatomic) IBOutlet UIButton *phoneButton;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
@property (weak, nonatomic) IBOutlet UIButton *emailButton;
@property (weak, nonatomic) IBOutlet UILabel *emailLabel;

@property (nonatomic) BOOL *canTweet;

@end

@implementation CISInformViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if ([TWTweetComposeViewController canSendTweet]){
        _canTweet = YES;
        _tweetButton.enabled = YES;
    } else {
        _canTweet = NO;
        _tweetButton.enabled = NO;
    }
    
    _nameLabel.text = _representative;
    _officeLabel.text = _officeAddress; // PRoblem ere
    NSMutableString *mu = [NSMutableString stringWithString:_twitterHandle];
    [mu insertString:@"@" atIndex:0];
    _twitterHandle = mu;
    _tweetLabel.text = _twitterHandle;
    _phoneLabel.text = _phoneNumber;
    _emailLabel.text = @"MiHonda@congress.com";
    
    
    
    
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)backButton:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)twitterButtonAction:(id)sender {
    if(_canTweet){
        //Create the tweet sheet
        TWTweetComposeViewController *tweetSheet = [[TWTweetComposeViewController alloc] init];
        
        //Customize the tweet sheet here
        //Add a tweet message
        [tweetSheet setInitialText:[NSString stringWithFormat:@"%@ Hey, im seeing homeless in your district, lets do something about it!", _twitterHandle]];
        
        //Set a blocking handler for the tweet sheet
        tweetSheet.completionHandler = ^(TWTweetComposeViewControllerResult result){
            [self dismissModalViewControllerAnimated:YES];
        };
        
        //Show the tweet sheet!
        [self presentModalViewController:tweetSheet animated:YES];
    }
    
}
- (IBAction)phoneButtonAction:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@", _phoneNumber]]];
}
- (IBAction)emailButtonAction:(id)sender {
    
    MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
    picker.mailComposeDelegate = self;
    
    [picker setSubject:@"Lets do something about this!"];
    
    NSArray *recpients = [NSArray arrayWithObject:_emailLabel.text];
    
    [picker setToRecipients:recpients];
    
    NSString *emailBody =
    [NSString stringWithFormat:@"Hey!<br><br>There are homeless at:<br><br>%@<br><br>Lets do something about this!!", _address];
    
    [picker setMessageBody:emailBody isHTML:YES]; // depends. Mostly YES, unless you want to send it as plain text (boring)
    
    picker.navigationBar.barStyle = UIBarStyleBlack; // choose your style, unfortunately, Translucent colors behave quirky.
    
    [self presentModalViewController:picker animated:YES];
}

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
	switch (result)
	{
		case MFMailComposeResultCancelled:
			NSLog(@"Mail cancelled: you cancelled the operation and no email message was queued.");
			break;
		case MFMailComposeResultSaved:
			NSLog(@"Mail saved: you saved the email message in the drafts folder.");
			break;
		case MFMailComposeResultSent:
			NSLog(@"Mail send: the email message is queued in the outbox. It is ready to send.");
			break;
		case MFMailComposeResultFailed:
			NSLog(@"Mail failed: the email message was not saved or queued, possibly due to an error.");
			break;
		default:
			NSLog(@"Mail not sent.");
			break;
	}
    // Remove the mail view
	[self dismissModalViewControllerAnimated:YES];
}

@end

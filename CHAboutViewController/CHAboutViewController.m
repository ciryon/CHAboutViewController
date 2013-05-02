//
//  CHAboutViewController.m
//  CHAboutViewController
//
//  Created by Christian Hedin on 2013-04-29.
//  Copyright (c) 2013 Christian Hedin. All rights reserved.
//

#import "CHAboutViewController.h"
#import "CHAboutViewCell.h"
#import "CHAboutData.h"
#import <MessageUI/MFMailComposeViewController.h>
#import "TSMiniWebBrowser.h"

typedef enum {
    CHAboutViewRowCompany,
    CHAboutViewRowSupport,
    CHAboutViewRowContact,
} CHAboutViewRow;

#define kCHAboutViewCellIdentifier @"CHAboutViewCell"
#define kCHAboutViewNumberOfRows 3

@interface CHAboutViewController () <UITableViewDataSource, UITableViewDelegate, MFMailComposeViewControllerDelegate>

@property(strong, nonatomic) IBOutlet UIImageView *iconImageView;
@property (strong, nonatomic) IBOutlet UIImageView *bannerImageView;
@property(strong, nonatomic) IBOutlet UITableView *tableView;

@property(strong, nonatomic) CHAboutData *aboutData;

@end

@implementation CHAboutViewController


- (id)initWithAboutData:(CHAboutData *)aboutData;
{
    self = [super init];
    if (self) {
        self.aboutData = aboutData;
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.tableView registerNib:[UINib nibWithNibName:@"CHAboutViewCell" bundle:nil] forCellReuseIdentifier:kCHAboutViewCellIdentifier];

  [self loadTextStrings];
  [self loadImages];
  
  UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(didTapDoneButton:)];
    self.navigationItem.leftBarButtonItem = doneButton;
}

-(void)loadTextStrings;
{
    self.navigationItem.title = NSLocalizedStringFromTable(@"about_title", @"AboutViewController",nil);
    self.appNameLabel.text = self.aboutData.appName;
  self.appVersionsLabel.text = [NSString stringWithFormat:@"Version %@ (%@)", self.aboutData.appMarketingVersion, self.aboutData.appDetailedVersion];
}


-(void)loadImages;
{
  if (self.aboutData.appImage) {
    self.iconImageView.image = self.aboutData.appImage;

  }
  if (self.aboutData.bannerImage) {
    self.bannerImageView.image = self.aboutData.bannerImage;
    
  }
}

-(void)didTapDoneButton:(id)sender;
{
    [self dismissViewControllerAnimated:YES
                             completion:^{

                             }];
}
#pragma UITableViewDataSource methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return kCHAboutViewNumberOfRows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    CHAboutViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCHAboutViewCellIdentifier forIndexPath:indexPath];
    switch (indexPath.row) {
        case CHAboutViewRowCompany:
            cell.keyLabel.text = NSLocalizedStringFromTable(@"key_company", @"AboutViewController",nil);
            cell.valueLabel.text = self.aboutData.companyName;
            break;
        case CHAboutViewRowSupport:
            cell.keyLabel.text = NSLocalizedStringFromTable(@"key_support",@"AboutViewController", nil);
            cell.valueLabel.text = nil;
            break;
        case CHAboutViewRowContact:
            cell.keyLabel.text = NSLocalizedStringFromTable(@"key_feedback", @"AboutViewController",nil);
            cell.valueLabel.text = nil;
            break;
        default:
            break;
    }
    return cell;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.row) {
        case CHAboutViewRowCompany:
            if (self.aboutData.appInfoURL) {
              UIViewController *browser = [[TSMiniWebBrowser alloc] initWithUrl:self.aboutData.appInfoURL];
              [self.navigationController pushViewController:browser animated:YES];
            }
            break;
        case CHAboutViewRowSupport:
            if (self.aboutData.appSupportURL) {
              UIViewController *browser = [[TSMiniWebBrowser alloc] initWithUrl:self.aboutData.appSupportURL];
              [self.navigationController pushViewController:browser animated:YES];
            }
            break;
        case CHAboutViewRowContact:
            if (self.aboutData.contactMethod == CHAboutDataContactMethodEmail) {
                [self sendFeedBackMail];
            }
            else if (self.aboutData.contactMethod == CHAboutDataContactMethodWebPage) {
              // TODO: Implement feedback via web
            }
            break;
    }
}

- (void)sendFeedBackMail;
{
    if ([MFMailComposeViewController canSendMail]) {
        MFMailComposeViewController *mail = [[MFMailComposeViewController alloc] init];

        mail.mailComposeDelegate = self;
        [mail setSubject:[NSString stringWithFormat:@"%@ %@ (%@)", self.aboutData.appName, self.aboutData.appMarketingVersion, self.aboutData.appDetailedVersion]];

        NSArray *recipient = [NSArray arrayWithObjects:self.aboutData.contactMethodValue, nil];
        [mail setToRecipients:recipient];

        NSString *body = @"";
        [mail setMessageBody:body isHTML:NO];

        [self presentViewController:mail animated:YES completion:^{

        }];
    }
}

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    [self dismissViewControllerAnimated:YES
                             completion:^{

                             }];
}


/*- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section;
{
    return @"Footer footer footer";
}
*/

@end

//
//  LoginVC.m
//  SurGift
//
//  Created by Star on 10/8/15.
//  Copyright © 2015 Star. All rights reserved.
//

#import "NewFeeds.h"
#import "NewsFeedCell.h"
#import "FBFeed.h"
#import "DateUtil.h"
#import "NewsFeedDetailVC.h"

#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <FBSDKShareKit/FBSDKShareKit.h>

typedef void(^FBRespondBlock) (NSError * error);

@interface NewFeeds ()

@property (nonatomic, strong) NSMutableArray * feeds;

@end

@implementation NewFeeds

#pragma mark - 
#pragma mark - UIView Lifecycle

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    _feeds = nil;
    _feeds = [[NSMutableArray alloc] init];
    _tblFeeds.tableFooterView = [[UIView alloc] init];
    
    [self requestFacebook:^(NSError *error) {
        
        if (error) {
            
            NSLog(@"Facebook Error:%@", error.description);
            return;
        }
        
        [self fetchNewsFeeds];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:YES];
    
    self.navigationController.navigationBarHidden = NO;
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([[segue identifier] isEqualToString:@"SG_FEED_DETAIL"]) {

        NewsFeedDetailVC *vc = [segue destinationViewController];
        vc.feed = [_feeds objectAtIndex:((UIView*)sender).tag];
    }
}

#pragma mark - 
#pragma mark - UITableView DataSource and Delegate

- (NSIndexPath*)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    self.view.tag = indexPath.row;
    [self performSegueWithIdentifier:@"SG_FEED_DETAIL" sender:self.view];
    return indexPath;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return 50;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _feeds.count;
}

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NewsFeedCell * cell = [tableView dequeueReusableCellWithIdentifier:@"feedcell"];
    return cell;
}

- (void)tableView:(UITableView*)tableView willDisplayCell:(NewsFeedCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    FBFeed * feed = _feeds[indexPath.row];
    cell.lblCreatedDate.text = [DateUtil getMMMDDYYYY:feed.createdTime];
    
    if (feed.story == nil || [feed.story isEqualToString:@""]) {
        cell.lblStory.text = feed.name;
    } else {
        cell.lblStory.text = feed.story;
    }
}

#pragma mark -
#pragma mark - Facebook

- (void)fetchNewsFeeds {
    
    FBSDKGraphRequest *request = [[FBSDKGraphRequest alloc]
                                  initWithGraphPath:@"/me/feed"
                                  parameters:@{ @"fields": @"created_time,id,name,story,type,attachments",}
                                  HTTPMethod:@"GET"];
    [request startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
        
        if (result) {
            
            NSLog(@"grant user's news feeds info from facebook suceeded");
            NSLog(@"me/feed result=%@",result);
            
            for (id newsFeed in [result objectForKey:@"data"]) {
                
                FBFeed * feed = [[FBFeed alloc] init];
                [feed setFeedFrom:newsFeed];
                
                if (![feed.name isEqualToString:@""] || ![feed.story isEqualToString:@""]) {
                    [_feeds addObject:feed];
                }
            }
            
            [_tblFeeds reloadData];
        }
        else {
            
            NSLog(@"failed to grant user info from facebook : %@", error);
        }
    }];
}

- (void) requestFacebook:(FBRespondBlock)respondBlock {

    FBSDKLoginManager * fblogin = [[FBSDKLoginManager alloc] init];

    [fblogin logInWithReadPermissions:@[@"public_profile", @"email", @"user_posts"] handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {

        if (error) {

            NSLog(@"facebook login failed : %@", error);
            respondBlock(error);
        }
        else if (result.isCancelled) {

            NSLog(@"facebook login cancelled");
            respondBlock([NSError errorWithDomain:@"com.idragonit.surgift" code:-1 userInfo:@{@"message" : @"facebook login cancelled"}]);
        }
        else {

            if ([result.grantedPermissions containsObject:@"public_profile"] &&
                [result.grantedPermissions containsObject:@"email"] && [FBSDKAccessToken currentAccessToken]) {

                NSLog(@"facebook login succeded. grant user info from facebook");

                FBSDKGraphRequest * requestMe = [[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:@{@"fields" : @"id, email, name, birthday, picture.type(normal)"}];

                [requestMe startWithCompletionHandler:^(FBSDKGraphRequestConnection * connection, id result, NSError * error) {

                    if (result) {

                        NSLog(@"grant user info from facebook suceeded");
                        NSLog(@"grant user result:%@", result);

                        respondBlock(nil);
                    }
                    else {

                        NSLog(@"failed to grant user info from facebook : %@", error);
                        respondBlock([NSError errorWithDomain:@"com.idragonit.fbnewsfeed" code:-1 userInfo:@{@"message" : @"facebook grant user info failed"}]);
                    }
                }];
            }
            else {

                NSLog(@"failed to grant user info from facebook : %@", error);
                respondBlock([NSError errorWithDomain:@"com.idragonit.fbnewsfeed" code:-1 userInfo:@{@"message" : @"facebook grant permission failed"}]);
            }
        }
    }];
}

@end

#import "SkypeContactPhotoProvider.h"
#import <Foundation/Foundation.h>

@implementation SkypeContactPhotoProvider

- (DDNotificationContactPhotoPromiseOffer *)contactPhotoPromiseOfferForNotification:(DDUserNotification *)notification {
  NSString *conversationId = [notification.applicationUserInfo valueForKeyPath:@"serviceSpecificData.conversationId"];
  NSArray *items = [conversationId componentsSeparatedByString:@":"];
  NSString *username;
  if([[items objectAtIndex:1] isEqualToString:@"live"]) {
    username = [NSString stringWithFormat:@"%@:%@", [items objectAtIndex:1], [items objectAtIndex:2]];
  } else {
    username = [items objectAtIndex:1];
  }
  if (!username) return nil;
  NSString *photoURLStr = [NSString stringWithFormat: @"https://api.skype.com/users/%@/profile/avatar", username];
  NSURL *photoURL = [NSURL URLWithString:photoURLStr];
  if (!photoURL) return nil;
  return [NSClassFromString(@"DDNotificationContactPhotoPromiseOffer") offerDownloadingPromiseWithPhotoIdentifier:photoURLStr fromURL:photoURL];
}

@end

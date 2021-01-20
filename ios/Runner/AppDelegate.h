#import <Flutter/Flutter.h>
#import <UIKit/UIKit.h>
#include "AppDelegate.h"
#include "GeneratedPluginRegistrant.h"
#import "GoogleMaps/GoogleMaps.h"

@interface AppDelegate : FlutterAppDelegate
@implementation AppDelegate

- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
 
  [GMSServices provideAPIKey:@"AIzaSyDt0ryPYrPXcOzs3Re689m2gCCXkAGKtbM"];
  [GeneratedPluginRegistrant registerWithRegistry:self];
  return [super application:application didFinishLaunchingWithOptions:launchOptions];
}
@end

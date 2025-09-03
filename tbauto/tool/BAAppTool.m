#import "BAAppTool.h"
#import <objc/message.h>
#import <objc/runtime.h>

@implementation BAAppTool

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
+ (void)openApp:(NSString *)bundleId {
  NSObject *Workspace = [objc_getClass("LSApplicationWorkspace")
      performSelector:@selector(defaultWorkspace)];
  [Workspace performSelector:@selector(openApplicationWithBundleID:)
                  withObject:bundleId];
}

+ (void)openUrl:(NSString *)url {
  NSObject *Workspace = [objc_getClass("LSApplicationWorkspace")
      performSelector:@selector(defaultWorkspace)];
  [Workspace performSelector:@selector(openURL:)
                  withObject:[NSURL URLWithString:url]];
}
#pragma clang diagnostic pop

+ (NSDictionary *)isInstallAppWithName:(NSString *)appName {
  NSArray *userApps = [BAAppTool initAppList];
  NSDictionary *appDict = nil;
  for (NSDictionary *dict in userApps) {
    if ([dict[@"appName"] isEqualToString:appName]) {
      appDict = dict.copy;
      break;
    } else if ([dict[@"appBundleID"] isEqualToString:appName]) {
      appDict = dict.copy;
      break;
    }
  }
  // NSLog(@"isInstallAppWithName:%@ ret:%zi ", appName, isInstalled);
  return appDict;
}

+ (NSMutableArray *)initAppList {
  Class LSApplicationWorkspace_class =
      NSClassFromString(@"LSApplicationWorkspace");
  id workspace = [LSApplicationWorkspace_class
      performSelector:@selector(defaultWorkspace)];
  NSArray *apps = [workspace performSelector:@selector(allApplications)];
  Class LSApplicationProxy_class = NSClassFromString(@"LSApplicationProxy");
  NSMutableArray *userApps = [NSMutableArray new];
  for (int i = 0; i < apps.count; i++) {
    id app = apps[i];
    if ([app isKindOfClass:LSApplicationProxy_class]) {
      NSString *appName = [app performSelector:@selector(localizedName)];
      NSString *appBundleID =
          [app performSelector:@selector(applicationIdentifier)];
      NSString *type = [app performSelector:@selector(applicationType)];
      NSURL *bundleURL = [app performSelector:@selector(bundleURL)];
      NSString *bundleDataPath = [bundleURL path];
      NSURL *containerURL = [app performSelector:@selector(containerURL)];
      NSString *containerDataPath = [containerURL path];
      if ([type isEqualToString:@"User"]) {
        NSDictionary *dict = @{
          @"appName" : appName,
          @"appBundleID" : appBundleID,
          @"containerDataPath" : containerDataPath,
          @"bundlePath" : bundleDataPath,
        };
        [userApps addObject:dict];
        // NSLog(@"app:%@", dict);
      }
    }
  }
  return userApps;
}

+ (NSString *)URLEncodedString:(NSString *)string {
  return [string
      stringByAddingPercentEncodingWithAllowedCharacters:
          [[NSCharacterSet
              characterSetWithCharactersInString:@" \"!*'(){}|;:@&<>=+$,/?%#[]"]
              invertedSet]];
}

static CFStringRef const kSBAppKillNotification =
    CFSTR("com.yourcompany.springboardhook.killapp");
CFNotificationCenterRef CFNotificationCenterGetDistributedCenter();

+ (void)killApp:(NSString *)bundleId {
  CFNotificationCenterPostNotification(
      CFNotificationCenterGetDistributedCenter(),
      (CFStringRef)kSBAppKillNotification, (CFStringRef)bundleId, nil, YES);
}
@end

#include <CoreFoundation/CFNotificationCenter.h>
#include <CoreFoundation/CoreFoundation.h>

#import <Foundation/Foundation.h>
#import <SpringBoard/SpringBoard.h>


static CFStringRef const kGetAppKillNotification = CFSTR("com.yourcompany.springboardhook.killapp");
CFTypeRef SBWorkspaceKillApplication(SBApplication* app, int a2, CFStringRef a3, int a4);
static void ChangeCallBack(struct __CFNotificationCenter *center, void *observer, const struct __CFString *name, const void *object, const struct __CFDictionary *userInfo) {
	NSLog(@"[springboard]killapp:%@, %@, %@", (__bridge NSString *)name, (__bridge NSString *)object, userInfo);
	SBApplication* app = [[%c(SBApplicationController) performSelector:@selector(sharedInstance)] performSelector:@selector(applicationWithBundleIdentifier:) withObject:(__bridge NSString *)object];
	SBWorkspaceKillApplication(app,1,CFSTR("killed from app switcher"),0);

}

	CFNotificationCenterRef CFNotificationCenterGetDistributedCenter();

%ctor {
	NSLog(@"[springboard]injected!");
	
	CFNotificationCenterAddObserver(CFNotificationCenterGetDistributedCenter(),
								NULL,
								(CFNotificationCallback)ChangeCallBack,
								(CFStringRef)kGetAppKillNotification,
								NULL,
								CFNotificationSuspensionBehaviorDeliverImmediately);

}

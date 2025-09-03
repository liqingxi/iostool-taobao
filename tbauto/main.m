#import <Foundation/Foundation.h>
#include <stddef.h>
#import <objc/message.h>
#import <objc/runtime.h>
#include <roothide.h>

#import "tool/BAAppTool.h"

static NSString *kTbUrlSearch = @"taobao://go/item_search?q=%@";

void mSleep(double time) {
    [NSThread sleepForTimeInterval:time / 1000.0];
}



void openTb(NSString *keyword) {
	NSString *url = [NSString stringWithFormat:kTbUrlSearch, [BAAppTool URLEncodedString:keyword]];
	NSLog(@"url:%@", url);
	[BAAppTool openUrl:url];
}


int main(int argc, char *argv[], char *envp[]) {
	@autoreleasepool {

        NSString *bundleID = @"com.taobao.taobao4iphone";
        // NSString *bundleID = @"com.tencent.xin";

		NSLog(@"init taobao auto search!\n");

		[BAAppTool killApp:bundleID];
		mSleep(5000);

		NSDictionary *appDict = [BAAppTool isInstallAppWithName:bundleID];
		NSString *app_tmp_dir = [appDict[@"containerDataPath"] stringByAppendingPathComponent:@"tmp"];
		NSLog(@"app_tmp dir:%@", app_tmp_dir);

		NSString *objc_path = jbroot(@"/tmp/taobao_keyword.txt");
		NSLog(@"objc_path:%@", objc_path);
		
		NSString *fileContent = [NSString stringWithContentsOfFile:objc_path 
                                                encoding:NSUTF8StringEncoding 
                                                   error:nil];

		NSArray *lines = [fileContent componentsSeparatedByCharactersInSet:
                 [NSCharacterSet newlineCharacterSet]];

		size_t i = 0;
		for (NSString *line in lines) {
			NSLog(@"index: %zu,line: %@", ++i, line);
			if (i<=176) {
				NSLog(@"skip task..");
				continue;
			}

			openTb(line);
			mSleep(10000);

			if ( i % 20 == 0 ) {
				[BAAppTool killApp:bundleID];
				NSLog(@"尝试重启淘宝APP...");

				mSleep(10000);
			}
		}
		// openTb(@"手机");

		return 0;
	}
}

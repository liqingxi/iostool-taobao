#ifndef BAAppTool_h
#define BAAppTool_h
#import <Foundation/Foundation.h>

@interface BAAppTool : NSObject

+ (void)openApp:(NSString*)bundleId;
+ (void)openUrl:(NSString*)url;
+ (NSString *)URLEncodedString:(NSString *)string;
+ (NSDictionary *)isInstallAppWithName:(NSString *)appName;
+ (NSMutableArray *)initAppList;
+ (void)killApp:(NSString *)bundleId;
@end

#endif
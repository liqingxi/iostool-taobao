#import "Tweak.h"
#include <substrate.h>

#import <Foundation/Foundation.h>

%config(generator=MobileSubstrate);

#define TMP_DIR(n) ([NSTemporaryDirectory() stringByAppendingPathComponent:n])

// %hook NetworkDemote
// - (BOOL)isDemoteSPDY {
//   return YES;
// }
// %end //end hook NetworkDemote

%hook TBSDKConnection
- (id)initWithURL:(id)arg1{
    NSLog(@"arg1 class,arg1:%@,%@",[arg1 class],arg1);
    // https://guide-acs.m.taobao.com/gw/mtop.alibaba.ucc.oauthlogin/1.0
    if ([[[self url] absoluteString] containsString:@"hmtop.alibaba.ucc.oauthlogin"]){
        return nil;
    }
    if ([[[self url] absoluteString] containsString:@"mtop.alibaba.ucc.taobao.apply.usertoken"]){
        return nil;
    }
    return %orig;
}

- (void) startAsynchronous{
    if ([[[self url] absoluteString] containsString:@"hmtop.alibaba.ucc.oauthlogin"]){
        return;
    }
    if ([[[self url] absoluteString] containsString:@"mtop.alibaba.ucc.taobao.apply.usertoken"]){
        return;
    }
    return %orig;
}

// - (id)response{
//     if ([[[self url] absoluteString] containsString:@"https://guide-acs.m.taobao.com/gw/mtop.relationrecommend.mtoprecommend.recommend/1.0"]){
//         // NSMutableArray *postData = [self postData];
//         // HBLogDebug(@"postData:%@",postData);
//         id r = %orig; 
//         NSLog(@"[taobao]response = %@", r); 
//         // return r;
//         // NSMutableDictionary *requestHeaders = [self requestHeaders];
//         // NSMutableArray *requestCookies = [self requestCookies];
//         // HBLogDebug(@"requestCookies:%@",requestCookies);

//         // for (NSHTTPCookie *cookie in requestCookies)
//         // {
//         //     NSString *name = [cookie name];
//         //     NSString *value = [cookie value];
//         //     HBLogDebug(@"%@:%@",name,value);
//         // }
//     }
//     return %orig;
// }

- (id)responseData{

    NSDictionary *ApiKeys = @{
        /// 搜索
        @"mtop.relationrecommend.mtoprecommend.recommend.json": @"https://guide-acs.m.taobao.com/gw/mtop.relationrecommend.mtoprecommend.recommend/1.0",
        @"mtop.taobao.detail.data.get.json": @"https://trade-acs.m.taobao.com/gw/mtop.taobao.detail.data.get/1.0",
        @"mtop.taobao.detail.getdetail.json": @"https://trade-acs.m.taobao.com/gw/mtop.taobao.detail.getdetail/6.0",
        /// 逛逛主页
        @"mtop.taobao.maserati.guangguang.getpersonalheader.json": @"https://guide-acs.m.taobao.com/gw/mtop.taobao.maserati.guangguang.getpersonalheader/1.0",
        // 直播间页面
        @"mtop.tblive.live.detail.query.json": @"https://guide-acs.m.taobao.com/gw/mtop.tblive.live.detail.query/4.0",
        /// 直播宝贝口袋
        @"mtop.tblive.live.item.getvideodetailitemlistwithpagination.json": @"https://guide-acs.m.taobao.com/gw/mtop.tblive.live.item.getvideodetailitemlistwithpagination/1.0",
        //https://guide-acs.m.taobao.com/gw/mtop.tblive.live.item.searchliveitem/1.0
        // @"mtop.alibaba.ucc.taobao.apply.usertoken": @"mtop.alibaba.ucc.taobao.apply.usertoken",
        // @"hmtop.alibaba.ucc.oauthlogin": @"hmtop.alibaba.ucc.oauthlogin",

    };

    for (NSString *apiKey in ApiKeys) {
        if ([[[self url] absoluteString] containsString:[ApiKeys objectForKey:apiKey]]){
            id r = %orig; 
            if (r){
                // 搜索任务要单独处理，不能覆盖
                if ([@"mtop.relationrecommend.mtoprecommend.recommend.json" isEqualToString:apiKey]) {
                    NSString *save_path = [NSString stringWithFormat:@"mtop.relationrecommend.mtoprecommend.recommend_%ld.json", time(NULL)];
                    [r writeToFile:TMP_DIR(save_path) atomically:YES];
                } else if ([@"mtop.tblive.live.item.getvideodetailitemlistwithpagination.json" isEqualToString:apiKey]) {
                    NSString *save_path = [NSString stringWithFormat:@"mtop.tblive.live.item.getvideodetailitemlistwithpagination_%ld.json", time(NULL)];
                    [r writeToFile:TMP_DIR(save_path) atomically:YES];
                } else {
                    [r writeToFile:TMP_DIR(apiKey) atomically:YES];
                }
            }
            return r;
        }
    }

    return %orig;
}
%end

// %hookf(int, MSFIN, const char *path, const char *mode) {
// 	puts("Hey, we're hooking fopen to deny relative paths!");
// 	if (path[0] != '/') {
// 		return NULL;
// 	}
// 	return %orig; // Call the original implementation of this function
// }


%ctor {
	unsetenv("DYLD_INSERT_LIBRARIES");
	NSLog(@"[taobao]injected!");
    void* p = MSFindSymbol(NULL, "_TBMainEntry");
    NSLog(@"[taobao]TBMainEntry: %p", p);

    dispatch_after(
        dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)),
        dispatch_get_main_queue(), ^{
            %init;
        }
    );

}
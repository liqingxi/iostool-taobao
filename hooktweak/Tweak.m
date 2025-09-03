#line 1 "Tweak.x"
#import "Tweak.h"
#include <substrate.h>

#import <Foundation/Foundation.h>

;


static __attribute__((constructor)) void _logosLocalCtor_344ae32b(int __unused argc, char __unused **argv, char __unused **envp) {
	unsetenv("DYLD_INSERT_LIBRARIES");
	NSLog(@"[taobao]injected!");
    void* p = MSFindSymbol(NULL, "_TBMainEntry");
    NSLog(@"[taobao]TBMainEntry: %p", p);

}

#define TMP_DIR(n) ([NSTemporaryDirectory() stringByAppendingPathComponent:n])








#include <substrate.h>
#if defined(__clang__)
#if __has_feature(objc_arc)
#define _LOGOS_SELF_TYPE_NORMAL __unsafe_unretained
#define _LOGOS_SELF_TYPE_INIT __attribute__((ns_consumed))
#define _LOGOS_SELF_CONST const
#define _LOGOS_RETURN_RETAINED __attribute__((ns_returns_retained))
#else
#define _LOGOS_SELF_TYPE_NORMAL
#define _LOGOS_SELF_TYPE_INIT
#define _LOGOS_SELF_CONST
#define _LOGOS_RETURN_RETAINED
#endif
#else
#define _LOGOS_SELF_TYPE_NORMAL
#define _LOGOS_SELF_TYPE_INIT
#define _LOGOS_SELF_CONST
#define _LOGOS_RETURN_RETAINED
#endif

__asm__(".linker_option \"-framework\", \"CydiaSubstrate\"");

@class TBSDKConnection; 
static TBSDKConnection* (*_logos_orig$_ungrouped$TBSDKConnection$initWithURL$)(_LOGOS_SELF_TYPE_INIT TBSDKConnection*, SEL, id) _LOGOS_RETURN_RETAINED; static TBSDKConnection* _logos_method$_ungrouped$TBSDKConnection$initWithURL$(_LOGOS_SELF_TYPE_INIT TBSDKConnection*, SEL, id) _LOGOS_RETURN_RETAINED; static id (*_logos_orig$_ungrouped$TBSDKConnection$responseData)(_LOGOS_SELF_TYPE_NORMAL TBSDKConnection* _LOGOS_SELF_CONST, SEL); static id _logos_method$_ungrouped$TBSDKConnection$responseData(_LOGOS_SELF_TYPE_NORMAL TBSDKConnection* _LOGOS_SELF_CONST, SEL); 

#line 25 "Tweak.x"

static TBSDKConnection* _logos_method$_ungrouped$TBSDKConnection$initWithURL$(_LOGOS_SELF_TYPE_INIT TBSDKConnection* __unused self, SEL __unused _cmd, id arg1) _LOGOS_RETURN_RETAINED{
    NSLog(@"arg1 class,arg1:%@,%@",[arg1 class],arg1);
    
    
    
    
    
    
    
    return _logos_orig$_ungrouped$TBSDKConnection$initWithURL$(self, _cmd, arg1);
}
































static id _logos_method$_ungrouped$TBSDKConnection$responseData(_LOGOS_SELF_TYPE_NORMAL TBSDKConnection* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd){

    NSDictionary *ApiKeys = @{
        
        @"mtop.relationrecommend.mtoprecommend.recommend.json": @"https://guide-acs.m.taobao.com/gw/mtop.relationrecommend.mtoprecommend.recommend/1.0",
        @"mtop.taobao.detail.data.get.json": @"https://trade-acs.m.taobao.com/gw/mtop.taobao.detail.data.get/1.0",
        @"mtop.taobao.detail.getdetail.json": @"https://trade-acs.m.taobao.com/gw/mtop.taobao.detail.getdetail/6.0",
        
        @"mtop.taobao.maserati.guangguang.getpersonalheader.json": @"https://guide-acs.m.taobao.com/gw/mtop.taobao.maserati.guangguang.getpersonalheader/1.0",
        
        @"mtop.tblive.live.detail.query.json": @"https://guide-acs.m.taobao.com/gw/mtop.tblive.live.detail.query/4.0",
        
        @"mtop.tblive.live.item.getvideodetailitemlistwithpagination.json": @"https://guide-acs.m.taobao.com/gw/mtop.tblive.live.item.getvideodetailitemlistwithpagination/1.0",
        
        
        

    };

    for (NSString *apiKey in ApiKeys) {
        if ([[[self url] absoluteString] containsString:[ApiKeys objectForKey:apiKey]]){
            id r = _logos_orig$_ungrouped$TBSDKConnection$responseData(self, _cmd); 
            if (r){
                
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

    return _logos_orig$_ungrouped$TBSDKConnection$responseData(self, _cmd);
}









static __attribute__((constructor)) void _logosLocalInit() {
  {

    dispatch_after(
        dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)),
        dispatch_get_main_queue(), ^{
          Class _logos_class$_ungrouped$TBSDKConnection =
              objc_getClass("TBSDKConnection");
          {
            MSHookMessageEx(
                _logos_class$_ungrouped$TBSDKConnection,
                @selector(initWithURL:),
                (IMP)&_logos_method$_ungrouped$TBSDKConnection$initWithURL$,
                (IMP *)&_logos_orig$_ungrouped$TBSDKConnection$initWithURL$);
          }
          {
            MSHookMessageEx(
                _logos_class$_ungrouped$TBSDKConnection,
                @selector(responseData),
                (IMP)&_logos_method$_ungrouped$TBSDKConnection$responseData,
                (IMP *)&_logos_orig$_ungrouped$TBSDKConnection$responseData);
          }
        });
  }
}
#line 118 "Tweak.x"

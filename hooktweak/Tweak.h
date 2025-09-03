#ifndef TWEAK_H
#define TWEAK_H
#import <Foundation/Foundation.h>

@interface TBSDKConnection : NSObject
{
    NSURL *_url;
    NSMutableArray *_postData;
    NSMutableDictionary *_requestHeaders;
    NSMutableArray *_requestCookies;
}
@property(retain, nonatomic) NSURL *url; // @synthesize url=_url;
@property(retain, nonatomic) NSMutableArray *postData; // @synthesize postData=_postData;
@property(retain, nonatomic) NSMutableDictionary *requestHeaders; // @synthesize requestHeaders=_requestHeaders;
@property(retain, nonatomic) NSMutableArray *requestCookies;
@end
#endif

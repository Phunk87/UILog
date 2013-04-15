//
//  UILog.h
//  EXFE
//
//  Created by 0day on 13-4-15.
//
//

#import <Foundation/Foundation.h>

#ifdef DEBUG
    #define UILogSetWindow(window)  [[UILog defaultLog] setWindow:(window)]
    #define UILogPush(message)      [[UILog defaultLog] pushMessage:(message)]
#else
    #define UILogSetWindow(window)
    #define UILogPush(message)
#endif

@interface UILog : NSObject

@property (nonatomic, retain) UIWindow *window;

+ (UILog *)defaultLog;
- (void)pushMessage:(NSString *)message;

@end

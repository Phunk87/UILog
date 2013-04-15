//
//  UILog.m
//  EXFE
//
//  Created by 0day on 13-4-15.
//
//

#import "UILog.h"

#define kFontHeigth             (16.0f)
#define kDebugWindowHeight      (kFontHeigth * 4)

@implementation UILog {
    UITextView *_logTextView;
    NSDateFormatter *_dateFormatter;
    UIWindow *_innerWindow;
}

+ (UILog *)defaultLog {
    static UILog *Log;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Log = [[self alloc] init];
    });
    
    return Log;
}

- (id)init {
    self = [super init];
    if (self) {
        CGRect screenBounds = [UIScreen mainScreen].bounds;
        _innerWindow = [[UIWindow alloc] initWithFrame:(CGRect){{0, CGRectGetHeight(screenBounds) - kDebugWindowHeight}, {CGRectGetWidth(screenBounds), kDebugWindowHeight}}];
        _innerWindow.userInteractionEnabled = NO;
        
        _logTextView = [[UITextView alloc] initWithFrame:_innerWindow.bounds];
        _logTextView.backgroundColor = [UIColor clearColor];
        _logTextView.textColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.8f];
        _logTextView.font = [UIFont fontWithName:@"HelveticaNeue" size:10];
        _logTextView.editable = NO;
        [_innerWindow addSubview:_logTextView];
        
        _dateFormatter = [[NSDateFormatter alloc] init];
        _dateFormatter.dateFormat = @"hh:mm:ss";
    }
    
    return self;
}

- (void)dealloc {
    self.window = nil;
    [_logTextView release];
    [_dateFormatter release];
    [super dealloc];
}

- (void)setWindow:(UIWindow *)window {
    if (_window == window)
        return;
    if (_window) {
        [_window release];
        _window = nil;
    }
    if (window) {
        _window = [window retain];
        [_innerWindow makeKeyAndVisible];
        [_window makeKeyWindow];
    }
}

- (void)pushMessage:(NSString *)message {
    dispatch_async(dispatch_get_main_queue(), ^{
        NSDate *now = [NSDate date];
        NSString *messageToPush = nil;
        if (!message || !message.length) {
            messageToPush = [NSString stringWithFormat:@"[%@] <Null>\n", [_dateFormatter stringFromDate:now]];
        } else {
            messageToPush = [NSString stringWithFormat:@"[%@] %@\n", [_dateFormatter stringFromDate:now], message];
        }
        
        NSString *oldString = _logTextView.text;
        messageToPush = [oldString stringByAppendingString:messageToPush];
        _logTextView.text = messageToPush;
        
        CGSize contentSize = _logTextView.contentSize;
        CGFloat offset = contentSize.height - (kDebugWindowHeight + kFontHeigth);
        if (offset > 0.0f) {
            [_logTextView setContentOffset:(CGPoint){0.0f, offset} animated:YES];
        }
    });
}

@end

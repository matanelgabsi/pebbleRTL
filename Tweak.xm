#include <unistd.h>
#include <wchar.h>

#import "bidi.h"
#import "BTServerHeaders.h"
#import "logging.h"

%ctor {
    log(@"Loaded!");
}

 %hook ANCBulletinAlert

 - (NSString*) title {
    %log;
    NSString *title = %orig;
    log(@"ANCBulletinAlert title called with original: %@, %@", title, @[title]);
    NSString *newTitle = bidi_lines(title);
    log(@"New title: %@", newTitle, @[newTitle]);
    return newTitle;
 }

  - (NSString*) message {
    %log;
    NSString *message = %orig;
    log(@"ANCBulletinAlert message called with original: %@, %@", message, @[message]);
    NSString *newMsg = bidi_lines(message);
    log(@"New message: %@, %@", newMsg, @[newMsg]);
    return newMsg;
 }

%end
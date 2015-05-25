#import "logging.h"

void append(NSString *msg) {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:@"peebleRTL.log"];
    // create if needed
    msg = [msg stringByAppendingString:@"\n"];
    if (![[NSFileManager defaultManager] fileExistsAtPath:path]){
        NSLog(@"Creating file at %s",[path UTF8String]);
        [[NSData data] writeToFile:path atomically:YES];
    } 
    // append
    NSFileHandle *handle = [NSFileHandle fileHandleForWritingAtPath:path];
    [handle truncateFileAtOffset:[handle seekToEndOfFile]];
    [handle writeData:[msg dataUsingEncoding:NSUTF8StringEncoding]];
    [handle closeFile];
}

void log(NSString* format, ...) {
    NSDateFormatter *formatter;
    NSString *dateString;
    va_list argList;
    va_start(argList, format);
    NSString* formattedMessage = [[[NSString alloc] initWithFormat: format arguments: argList] autorelease];
    va_end(argList);

    formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"[dd-MM-yyyy HH:mm] "];

    dateString = [formatter stringFromDate:[NSDate date]];
    formattedMessage = [dateString stringByAppendingString: formattedMessage];
    NSLog(@"%@", formattedMessage);
    append(formattedMessage);
}
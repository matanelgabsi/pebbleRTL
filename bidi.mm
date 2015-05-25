#import "bidi.h"

NSString *bidi(NSString *str) {
    void *bidi;
    unsigned long len = [str length];
    uint16_t *input;
    NSData * data = [str dataUsingEncoding:NSUTF16LittleEndianStringEncoding];
    if (len ==0) {
        return str;
    }
    input = (uint16_t*)data.bytes;
    UErrorCode err = U_ZERO_ERROR;
    UBiDiLevel level = UBIDI_DEFAULT_LTR;
    bidi=ubidi_open();
    
    ubidi_setReorderingMode(bidi, UBIDI_REORDER_DEFAULT);
    ubidi_setPara( bidi, input, (int)len, level, NULL, &err );
    uint16_t* output = (uint16_t*)malloc((len+1) * sizeof(uint16_t));
    ubidi_writeReordered( bidi, output, (int)len+1, 0 , &err );
    ubidi_close(bidi);
    NSString *newStr = [[NSString alloc] initWithBytes: (const void*)output
                                                length: len * sizeof(uint16_t)
                                              encoding: NSUTF16LittleEndianStringEncoding];
    free(output);
    return newStr;
}

BOOL isualnum(NSString *str) {
    NSCharacterSet *alnum = [NSCharacterSet alphanumericCharacterSet];
    return [str rangeOfCharacterFromSet: alnum].location != NSNotFound;
}

NSString *bidi_lines(NSString *str) {
    NSMutableString *text = [[str stringByReplacingOccurrencesOfString:@"\u202b" withString: @""] mutableCopy];
    NSMutableString *newStr = [NSMutableString new];
    NSMutableArray  *lines = [NSMutableArray new];
    CGSize textSize;
    NSRange redondancyRange;
    NSUInteger spaceLocation;
    while ([text length] > 0) {
        //move the first char from text to newStr
        [newStr appendString: [text substringWithRange:NSMakeRange(0, 1)]];
        [text deleteCharactersInRange:NSMakeRange(0, 1)];
        
        //Check new string size
        textSize = [newStr sizeWithAttributes:@{ NSFontAttributeName : [UIFont fontWithName:@"Helvetica-Light" size:9.0]}];
        if (textSize.width > 50) {
            //find the location of the last space in the line
            spaceLocation = [newStr rangeOfString: @" " options: NSBackwardsSearch].location;
            // Check that the last character in newStr and the first char in text are alpha numeric.
            // if so, we need to move the entire word to the prev line (or add - if no choise).
            // otherwise, (if special chars such as ~!@#$% etc we can just cut them..
            if ([text length] > 0 && [newStr length] > 0 && isualnum([newStr substringFromIndex:[newStr length] - 1]) && isualnum([text substringToIndex:1])) {
                if (spaceLocation != NSNotFound && spaceLocation > 3) {
                    redondancyRange = NSMakeRange(spaceLocation, [newStr length] - spaceLocation);
                    //Create new range to exlude space
                    [text insertString: [newStr substringWithRange: redondancyRange] atIndex: 0];
                    [newStr deleteCharactersInRange: redondancyRange];
                } else {
                    [newStr appendString: @"-"];
                }
            }
            [lines addObject: bidi(newStr)];
            [newStr setString: @""];
        }
    }
    if ([newStr length] > 0) {
        [lines addObject: bidi(newStr)];
    }
    return [lines componentsJoinedByString:@"\n"];
}
#import <Foundation/Foundation.h>

NSComparisonResult comp(id o1, id o2, void* x) {
    return [(NSString*)o1 localizedCompare:(NSString*)o2];
}

int main(void){

    @autoreleasepool {
        NSStringEncoding enc = NSUTF8StringEncoding;
        NSFileHandle *stdout = [NSFileHandle fileHandleWithStandardOutput];
        NSFileHandle *stdin = [NSFileHandle fileHandleWithStandardInput];

        NSData *indata = [stdin readDataToEndOfFile];
        NSMutableString *str = [NSMutableString alloc];
        [str initWithBytes:indata.bytes length:indata.length encoding:enc];

        NSArray *w = [[str componentsSeparatedByString:@"\n"] sortedArrayUsingFunction:comp context:NULL];

        for (NSUInteger j = 2; j < w.count; j++) {
            NSString *wd = (NSString*)[w objectAtIndex:j];
            [stdout writeData:[wd dataUsingEncoding:enc]];
            [stdout writeData:[@"----\n" dataUsingEncoding:enc]];
        }

        
    }
    
    return 0;
}

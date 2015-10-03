#import <Foundation/Foundation.h>

NSComparisonResult comp(id o1, id o2, void* context) {
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

        NSMutableArray *w = [NSMutableArray new];
        [w addObjectsFromArray:[[str componentsSeparatedByString:@"\n"] sortedArrayUsingFunction:comp context:NULL]];
        
        NSMutableString *cp = [NSMutableString new]; // 中央
        NSMutableString *rp = [NSMutableString new]; // 右側
        
        // 最後の単語に改行があるので空文字と単語数Ｎがソート後の先頭2個に来るので省く
        for (NSUInteger j = 2; j < w.count; j++) {
            NSString *wd = (NSString*)[w objectAtIndex:j];
            
            if (wd.length == 0) {
                continue;
            }
            
            // 単語反転処理
            NSMutableString *rd = [NSMutableString new];
            for (NSUInteger x = 0; x < wd.length; x++) {
                unichar ch = [wd characterAtIndex:(wd.length - x - 1)];
                [rd appendFormat:@"%c", ch];
            }
            
            NSRange range = NSMakeRange(j + 1, w.count - j - 1);
            NSUInteger k = [w indexOfObject:rd inRange:range];
            
            if (k != NSNotFound) {
                [stdout writeData:[wd dataUsingEncoding:enc]];
                [rp insertString:rd atIndex:0];
                [w replaceObjectAtIndex:k withObject:@""];
            } else {
                if ([wd localizedCompare:rd] == NSOrderedSame) {
                    if (cp.length == 0 || [cp localizedCompare:wd] == NSOrderedDescending) {
                        [cp setString:wd];
                    }
                }
            }
        }
        
        [rp insertString:cp atIndex:0];
        [stdout writeData:[rp dataUsingEncoding:enc]];
    }
    
    return 0;
}

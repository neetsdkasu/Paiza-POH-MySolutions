/* Try POH
 * author: Leonardone @ NEETSDKASU
 */
#import <Foundation/Foundation.h>

NSComparisonResult comp(NSNumber *a, NSNumber *b, void* c) {
    return [a compare:b];
}

int main(void){
    @autoreleasepool {
        /* 標準入出力の準備 */
        NSStringEncoding enc = NSUTF8StringEncoding;
        NSFileHandle *stdin = [NSFileHandle fileHandleWithStandardInput];
        NSFileHandle *stdout = [NSFileHandle fileHandleWithStandardOutput];
        
        /* 標準入力からのデータを全部読み込む */
        NSData *indata = [stdin readDataToEndOfFile];
        NSMutableString *str = [NSMutableString alloc];
        [str initWithBytes:indata.bytes length:indata.length encoding:enc];
        
        /* 改行文字で分割して行ごとのデータに */
        NSMutableArray *lines = [NSMutableArray new];
        [lines addObjectsFromArray:[str componentsSeparatedByString:@"\n"]];
        
        NSInteger n, m;
        NSMutableArray *q = [NSMutableArray new], *p = [NSMutableArray new];
        
        {
            NSScanner *scan = [NSScanner scannerWithString:[lines objectAtIndex:0]];
            
            NSString *temp = [NSString alloc];
            [scan scanUpToString:(@" ") intoString:&temp];
            n = temp.integerValue;
        }
        
        for (NSInteger i = 0; i < n; i++) {
            NSMutableArray *t = [NSMutableArray new];
            NSScanner *scan = [NSScanner scannerWithString:[lines objectAtIndex:(i + 1)]];
            for (NSInteger j = 0; j < n; j++) {
                NSString *temp = [NSString alloc];
                [scan scanUpToString:(@" ") intoString:&temp];
                [t addObject:temp];
            }
            [q addObject:t];
        }
        
        {
            NSScanner *scan = [NSScanner scannerWithString:[lines objectAtIndex:(n + 1)]];
            
            NSString *temp = [NSString alloc];
            [scan scanUpToString:(@" ") intoString:&temp];
            m = temp.integerValue;
        }
        
        for (NSInteger i = 0; i < m; i++) {
            NSMutableArray *t = [NSMutableArray new];
            NSScanner *scan = [NSScanner scannerWithString:[lines objectAtIndex:(i + n + 2)]];
            for (NSInteger j = 0; j < m; j++) {
                NSString *temp = [NSString alloc];
                [scan scanUpToString:(@" ") intoString:&temp];
                [t addObject:temp];
            }
            [p addObject:t];
        }
        
        for (NSInteger i = 0; i <= n - m; i++) {
            for (NSInteger j = 0; j <= n - m; j++) {
                BOOL flag = true;
                for (NSInteger y = 0; y < m; y++) {
                    for (NSInteger x = 0; x < m; x++) {
                        flag &= [[[q objectAtIndex:(i + y)] objectAtIndex:(j + x)] localizedCompare:[[p objectAtIndex:y] objectAtIndex:x]] == NSOrderedSame;
                    }
                }
                if (flag) {
                    [stdout writeData:[[NSNumber numberWithInteger:i].stringValue dataUsingEncoding:enc]];
                    [stdout writeData:[@" " dataUsingEncoding:enc]];
                    [stdout writeData:[[NSNumber numberWithInteger:j].stringValue dataUsingEncoding:enc]];
                    [stdout writeData:[@"\n" dataUsingEncoding:enc]];
                }
            }
        }
        
    }
    return 0;
}

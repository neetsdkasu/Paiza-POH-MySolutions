/* Try POH
 * author: Leonardone @ NEETSDKASU
 */
#import <Foundation/Foundation.h>

NSInteger getInteger(NSScanner *scan) {
    NSString *temp = [NSString alloc];
    [scan scanUpToString:(@" ") intoString:&temp];
    return temp.integerValue;
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
        
        n = getInteger([NSScanner scannerWithString:[lines objectAtIndex:0]]);
        
        for (NSInteger i = 0; i < n; i++) {
            [q addObject:[[lines objectAtIndex:(i + 1)] componentsSeparatedByString:@" "]];
        }
        
        m = getInteger([NSScanner scannerWithString:[lines objectAtIndex:(n + 1)]]);

        for (NSInteger i = 0; i < m; i++) {
            [p addObject:[[lines objectAtIndex:(n + 2 + i)] componentsSeparatedByString:@" "]];
        }
        
        for (NSInteger i = 0; i <= n - m; i++) {
            for (NSInteger j = 0; j <= n - m; j++) {
                BOOL flag = YES;
                for (NSInteger y = 0; y < m; y++) {
                    for (NSInteger x = 0; x < m; x++) {
                        id a = [[q objectAtIndex:(i + y)] objectAtIndex:(j + x)];
                        id b = [[p objectAtIndex:y] objectAtIndex:x];
                        flag &= [a localizedCompare:b] == NSOrderedSame;
                    }
                }
                if (flag != NO) {
                    NSMutableString *res = [NSMutableString stringWithCapacity:0];
                    [res appendFormat:@"%d %d\n", i, j];
                    [stdout writeData:[res dataUsingEncoding:enc]];
                }
            }
        }
    }
    return 0;
}

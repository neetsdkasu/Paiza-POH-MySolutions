/* Try POH
 * author: Leonardone @ NEETSDKASU
 */
#import <Foundation/Foundation.h>

NSInteger getInteger(NSScanner *scan) {
    NSString *temp = [NSString alloc]; /* ここでのallocは許されるのだろうか？ autoreleasepoolの仕組みをまだ理解してないから恐い */
    [scan scanUpToString:(@" ") intoString:&temp];
    return temp.integerValue;
}

NSComparisonResult comp(NSNumber *a, NSNumber *b, void* c) {
    return [a compare:b];
}

void addValue(NSMutableArray *a, NSInteger v) { /* ここら辺の関数追い出しは微妙かと */
    [a addObject:[NSNumber numberWithInteger:v]];
}

NSInteger getValue(NSArray *a, NSInteger idx) {
    return [[a objectAtIndex:idx] integerValue];
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
        
        NSInteger x, y, z, n;
        
        NSScanner *scan = [NSScanner scannerWithString:[lines objectAtIndex:0]];
        x = getInteger(scan);
        y = getInteger(scan);
        z = getInteger(scan);
        n = getInteger(scan);

        NSMutableArray *xs = [NSMutableArray new];
        NSMutableArray *ys = [NSMutableArray new];
        
        addValue(xs, 0);
        addValue(xs, x);
        addValue(ys, 0);
        addValue(ys, y);
        
        while (n--) {
            /* daを読スキャナの準備 */
            scan = [NSScanner scannerWithString:[lines objectAtIndex:(n + 1)]];
            
            NSInteger d = getInteger(scan);
            NSInteger a = getInteger(scan);

            if (d == 0) {
                addValue(xs, a);
            } else {
                addValue(ys, a);
            }
        }
        
        [xs sortUsingFunction:comp context:NULL];
        [ys sortUsingFunction:comp context:NULL];
        
        for (NSInteger i = 1; i < xs.count; i++) {
            NSInteger diff = getValue(xs, i) - getValue(xs, i - 1);
            if (diff < x) x = diff;
        }

        for (NSInteger i = 1; i < ys.count; i++) {
            NSInteger diff = getValue(ys, i) - getValue(ys, i - 1);
            if (diff < y) y = diff;
        }
        
        NSString *res = [NSString stringWithFormat:@"%d\n", (x * y * z)];
        
        /* 結果の出力 */
        [stdout writeData:[res dataUsingEncoding:enc]];
        
    }
    return 0;
}

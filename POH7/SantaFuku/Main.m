/* Try POH
 * author: Leonardone @ NEETSDKASU
 */
#import <Foundation/Foundation.h>

NSComparisonResult comp(id a, id b, void* c) {
    return [(NSNumber*)a compare:(NSNumber*)b];
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
        
        {
            /* xyznを読スキャナの準備 */
            NSScanner *scan = [NSScanner alloc];
            [scan initWithString:[lines objectAtIndex:0]];
            
            NSString *x_str = [NSString alloc];
            [scan scanUpToString:(@" ") intoString:&x_str];
            x = x_str.integerValue; /* マクロ使ってもいいんだけどさ、それよりももっとマシなやり方とかないなの？ */
            
            NSString *y_str = [NSString alloc];
            [scan scanUpToString:(@" ") intoString:&y_str];
            y = y_str.integerValue;
            
            NSString *z_str = [NSString alloc];
            [scan scanUpToString:(@" ") intoString:&z_str];
            z = z_str.integerValue;
            
            NSString *n_str = [NSString alloc];
            [scan scanUpToString:(@" ") intoString:&n_str];
            n = n_str.integerValue;
        }
        
        NSMutableArray *xs = [NSMutableArray new];
        NSMutableArray *ys = [NSMutableArray new];
        
        [xs addObject:[NSNumber numberWithInteger:0]];
        [xs addObject:[NSNumber numberWithInteger:x]];
        [ys addObject:[NSNumber numberWithInteger:0]];
        [ys addObject:[NSNumber numberWithInteger:y]];
        
        while (n--) {
            /* daを読スキャナの準備 */
            NSScanner *scan = [NSScanner alloc];
            [scan initWithString:[lines objectAtIndex:(n + 1)]];

            NSString *d_str = [NSString alloc];
            [scan scanUpToString:(@" ") intoString:&d_str];
            NSInteger d = d_str.integerValue;
            
            NSString *a_str = [NSString alloc];
            [scan scanUpToString:(@" ") intoString:&a_str];
            NSInteger a = a_str.integerValue;
            
            if (d == 0) {
                [xs addObject:[NSNumber numberWithInteger:a]];
            } else {
                [ys addObject:[NSNumber numberWithInteger:a]];
            }
        }
        
        [xs sortUsingFunction:comp context:NULL];
        [ys sortUsingFunction:comp context:NULL];
        
        for (NSInteger i = 1; i < xs.count; i++) {
            NSInteger diff = [(NSNumber*)[xs objectAtIndex:i] integerValue] - [(NSNumber*)[xs objectAtIndex:(i-1)] integerValue];
            if (diff < x) x = diff;
        }

        for (NSInteger i = 1; i < ys.count; i++) {
            NSInteger diff = [(NSNumber*)[ys objectAtIndex:i] integerValue] - [(NSNumber*)[ys objectAtIndex:(i-1)] integerValue];
            if (diff < y) y = diff;
        }
        
        NSNumber *res = [NSNumber numberWithInteger:(x * y * z)];
        
        /* 結果の出力 */
        [stdout writeData:[res.stringValue dataUsingEncoding:enc]];
        
    }
    return 0;
}

/*
 * 結果 https://paiza.jp/poh/joshibato/kirishima/result/5a30f12a
 */
#import <Foundation/Foundation.h>


int main(void){

    @autoreleasepool {
    
        NSStringEncoding enc = NSUTF8StringEncoding;
        NSFileHandle *stdin = [NSFileHandle fileHandleWithStandardInput];
        NSFileHandle *stdout = [NSFileHandle fileHandleWithStandardOutput];
        
        NSData *indata = [stdin readDataToEndOfFile];
        NSMutableString *str = [NSMutableString alloc];
        [str initWithBytes:indata.bytes length:indata.length encoding:enc];

        NSMutableArray *lines = [NSMutableArray new];
        [lines addObjectsFromArray:[str componentsSeparatedByString:@"\n"]];
        
        NSInteger n = [[lines objectAtIndex:0] integerValue];
        
        NSScanner *scan = [NSScanner alloc];
        [scan initWithString:[lines objectAtIndex:1]];

        NSMutableString *res = [NSMutableString new];

        NSMutableArray *t = [NSMutableArray new];
        
        for (NSInteger i = n; i > 0; i--) {
            NSString *temp = [NSString alloc];
            [scan scanUpToString:(@" ") intoString:&temp];
            [t addObject:temp];
        }
        
        NSInteger m = [[lines objectAtIndex:2] integerValue];
        
        for (NSInteger i = 0; i < m; i++) {
            NSInteger d = [[lines objectAtIndex:(i + 3)] integerValue];
            NSString *r = @"No";
            NSMutableArray *f = [NSMutableArray new];
            for (NSInteger j = 0; j < n; j++) {
                [f addObject:@"0"];
            }
            for (;;) {
                if (d < 1 || d >= n) break;
                if (d == n - 1) {
                    r = @"Yes";
                    break;
                }
                if (0 == [[t objectAtIndex:d] integerValue]) break;
                if (0 != [[f objectAtIndex:d] integerValue]) break;
                [f replaceObjectAtIndex:d withObject:@"1"];
                d += [[t objectAtIndex:d] integerValue];
            }
            [res appendString:r];
            [res appendString:@"\n"];
        }
        
        [stdout writeData:[res dataUsingEncoding:enc]];
    }
    
    return 0;
}

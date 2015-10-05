/*
 * 結果 https://paiza.jp/poh/joshibato/tsubame/result/fbd2a1d1
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
        
        NSScanner *scan = [NSScanner alloc];
        [scan initWithString:str];
        
        NSString *n_str = [NSString alloc];
        [scan scanUpToString:@"\n" intoString:&n_str];
        NSInteger n = [n_str integerValue];
        
        NSInteger n1 = [[n_str substringFromIndex:1] substringToIndex:1].integerValue;
        
        NSInteger n10 = [n_str substringWithRange:NSMakeRange(0,1)].integerValue;
        
        NSInteger r = n + n1 + n10;
        
        NSMutableString *r_str = [NSMutableString new];
        
        [r_str appendFormat:@"%d", r];
        
        [stdout writeData:[r_str dataUsingEncoding:enc]];
    }
    
    return 0;
}

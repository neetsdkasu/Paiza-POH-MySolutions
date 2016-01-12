/* Try POH
 * author: Leonardone @ NEETSDKASU
 */
#import <Foundation/Foundation.h>

long long solve(long long n) {
    long long r = 1, c = 0, x, md = 1000000000;
    while (n > 1) {
        x = n--;
        while (x % 5 == 0) {
            x /= 5; c--;
        }
        while (x % 2 == 0) {
            x /= 2; c++;
        }
        r = (r * x) % md;
    }
    while (c--)
        r = (r * 2) % md;
    return r;
}

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
        
        
        NSNumber *res = [NSNumber numberWithLongLong:solve(n_str.longLongValue)];
        
        [stdout writeData:[res.stringValue dataUsingEncoding:enc]];
        
    }
    return 0;
}

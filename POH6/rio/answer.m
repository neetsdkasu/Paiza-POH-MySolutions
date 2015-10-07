/*
 * 結果 https://paiza.jp/poh/joshibato/rio/result/2f8cced3
 */
#import <Foundation/Foundation.h>

typedef struct Bunsu {
    NSInteger a;
    NSInteger b;
} BS;

typedef const BS CBS;

BS toBS(NSInteger v) {
    BS bs;
    bs.a = v;
    bs.b = 1;
    return bs;
}

BS makeBS(NSInteger a, NSInteger b) {
    BS bs;
    bs.a = a;
    bs.b = b;
    return bs;
}

NSInteger GCD(NSInteger x, NSInteger y) {
    if (x == 0) {
        return y;
    }
    if (y == 0) {
        return x;
    }
    if (x > y) {
      return GCD(x % y, y);
    } else {
      return GCD(y % x, x);
    }
}

BS gcd(BS x) {
    NSInteger d = GCD(x.a, x.b);
    x.a /= d;
    x.b /= d;
    return x;
}

BS addBS(CBS x, CBS y) {
    BS z;
    if (x.b == y.b) {
        z.a = x.a + y.a;
        z.b = x.b;
    } else {
        z.a = x.a * y.b + y.a * x.b;
        z.b = x.b * y.b;
    }
    return gcd(z);
}

BS subBS(CBS x, CBS y) {
    BS z;
    if (x.b == y.b) {
        z.a = x.a - y.a;
        z.b = x.b;
    } else {
        z.a = x.a * y.b - y.a * x.b;
        z.b = x.b * y.b;
    }
    return gcd(z);
}

BS mulBS(CBS x, CBS y) {
    BS z;
    z.a = x.a * y.a;
    z.b = x.b * y.b;
    return gcd(z);
}

BS divBS(CBS x, CBS y) {
    BS z;
    z.a = x.a * y.b;
    z.b = x.b * y.a;
    return gcd(z);
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
        NSInteger n = n_str.integerValue;
        
        BS w = toBS(0);
        BS c = toBS(0);
        
        for (NSInteger i = 0; i < n; i++) {
            NSString *t_str = [NSString alloc];
            NSString *s_str = [NSString alloc];
            [scan scanUpToString:@" " intoString:&t_str];
            [scan scanUpToString:@"\n" intoString:&s_str];
            
            NSInteger t = t_str.integerValue;
            BS s = toBS(s_str.integerValue);
            
            switch (t) {
            case 1:
                w = addBS(w, s);
                break;
            case 2:
                c = addBS(c, s);
                break;
            case 3:
                {
                    BS wc = addBS(w, c);
                    w = divBS(subBS(mulBS(w,wc),mulBS(s,w)),wc);
                    c = divBS(subBS(mulBS(c,wc),mulBS(s,c)),wc);
                }
                break;
            }
        }
        
        BS ans = divBS(mulBS(toBS(100),c),addBS(w,c));
        
        NSMutableString *res = [NSMutableString new];
        
        [res appendFormat:@"%u", (NSInteger)(ans.a/ans.b)];
        
        [stdout writeData:[res dataUsingEncoding:enc]];
    }
    
    return 0;
}

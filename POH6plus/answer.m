#import <Foundation/Foundation.h>

int main(void){

    @autoreleasepool {
        NSStringEncoding enc = NSUTF8StringEncoding;
        NSFileHandle *stdout = [NSFileHandle fileHandleWithStandardOutput];
        NSFileHandle *stdin = [NSFileHandle fileHandleWithStandardInput];

        NSData *indata = [stdin readDataToEndOfFile];
        NSMutableString *str = [NSMutableString alloc];
        [str initWithBytes:indata.bytes length:indata.length encoding:enc];

        NSScanner *scan = [NSScanner alloc];
        [scan initWithString:str];
        
        NSString *nstr = [NSString alloc];
        [scan scanUpToString:@"\n" intoString:&nstr];
        NSInteger n = nstr.integerValue;
        
        NSMutableArray *w = [NSMutableArray new];
        
        for (NSInteger i = 0; i < n; i++) {
            NSString *tstr = [NSString alloc];
            [scan scanUpToString:@"\n" intoString:&tstr];
            [w addObject:tstr];
        }
        
        for (NSString *wd in w) {
            [stdout writeData:[wd dataUsingEncoding:enc]];
            [stdout writeData:[@"----\n" dataUsingEncoding:enc]];
        }

        
    }
    
    return 0;
}

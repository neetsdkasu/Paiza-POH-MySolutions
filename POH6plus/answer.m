#import <Foundation/Foundation.h>

int main(void){

    @autoreleasepool {
        NSStringEncoding enc = NSUTF8StringEncoding;
        NSFileHandle *stdout = [NSFileHandle fileHandleWithStandardOutput];
        NSFileHandle *stdin = [NSFileHandle fileHandleWithStandardInput];

        NSData *indata = [stdin readDataToEndOfFile];
        NSMutableString *str = [NSMutableString alloc];
        [str initWithBytes:[indata bytes] length:[indata length] encoding:NSUTF8StringEncoding];

        NSScanner *scan = [NSScanner alloc];
        [scan initWithString:str];
        
        NSString *n = [NSString alloc];
        [scan scanUpToString:@"\n" intoString:&n];
        
        while ([scan isAtEnd] == NO) {
            NSString *tstr = [NSString alloc];
            [scan scanUpToString:@"\n" intoString:&tstr];
            [stdout writeData:[tstr dataUsingEncoding:NSUTF8StringEncoding]];
            [stdout writeData:[@"----\n" dataUsingEncoding:NSUTF8StringEncoding]];
        }
        

        
    }
    
    return 0;
}

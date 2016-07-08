/* Try POH
 * author: Leonardone @ NEETSDKASU
 */
// ==================================================================================
#import <Foundation/Foundation.h>
// ==================================================================================
NSInteger ti(NSString *s) { return [s integerValue]; }
NSArray* Iv2(NSArray *a, NSInteger *v1, NSInteger *v2) {
    *v1 = ti([a objectAtIndex:0]); *v2 = ti([a objectAtIndex:1]); return [a subarrayWithRange:NSMakeRange(2, [a count] - 2)]; }
NSArray* Iv3(NSArray *a, NSInteger *v1, NSInteger *v2, NSInteger *v3) {
    *v1 = ti([a objectAtIndex:0]); *v2 = ti([a objectAtIndex:1]); *v3 = ti([a objectAtIndex:2]); return [a subarrayWithRange:NSMakeRange(3, [a count] - 3)]; }
NSArray* Iv4(NSArray *a, NSInteger *v1, NSInteger *v2, NSInteger *v3, NSInteger *v4) {
    *v1 = ti([a objectAtIndex:0]); *v2 = ti([a objectAtIndex:1]); *v3 = ti([a objectAtIndex:2]); *v4 = ti([a objectAtIndex:3]); return [a subarrayWithRange:NSMakeRange(4, [a count] - 4)]; }
@interface MyIO : NSObject
{   NSArray *lines; NSInteger cur; NSFileHandle *stdOut; NSStringEncoding enc; NSArray *scn; NSInteger idx; }
- (NSString *)gs; - (NSInteger)gi; - (NSArray *)gss; - (NSArray *)gis;
- (NSArray *)ngs: (NSInteger)n; - (NSArray *)ngi: (NSInteger)n; - (NSArray *)ngss: (NSInteger)n; - (NSArray *)ngis: (NSInteger)n;
- (NSString *)scns; - (NSInteger)scni;
- (void)write:(NSString *)str;
- (void)writeln:(NSString *)str;
- (void)writei:(NSInteger)val;
- (void)writeiln:(NSInteger)val;
@end
@interface MyIO ()
- (NSArray *)ngt:(NSInteger)n f:(id (^)(void))f;
@end
@implementation MyIO
{   NSArray *lines; NSInteger cur; NSFileHandle *stdOut; NSStringEncoding enc; NSArray *scn; NSInteger idx; }
- (id)init { self = [super init]; if (self) {
    stdOut = [NSFileHandle fileHandleWithStandardOutput]; idx = 0; enc = NSUTF8StringEncoding;
    NSData *data = [[NSFileHandle fileHandleWithStandardInput] readDataToEndOfFile];
    NSString *str = [[NSString alloc] initWithBytes:[data bytes] length:[data length] encoding:enc];
    lines = [str componentsSeparatedByString:@"\n"]; cur = 0; } return self; }
- (NSString *)gs { return [lines objectAtIndex:cur++]; }
- (NSInteger)gi { return [[self gs] integerValue]; }
- (NSArray *)gss { return [[self gs] componentsSeparatedByString:@" "]; }
- (NSArray *)gis { NSMutableArray *a = [NSMutableArray new]; for (id v in [self gss]) { [a addObject:[NSNumber numberWithInteger:[v integerValue]]]; } return a; }
- (NSArray *)ngt:(NSInteger)n f:(id (^)(void))f { NSMutableArray *a = [NSMutableArray new]; for (NSInteger i = 0; i < n; i++) { [a addObject:f()]; } return a; }
- (NSArray *)ngs: (NSInteger)n { return [self ngt:n f:^{ return [self gs]; }]; }
- (NSArray *)ngi: (NSInteger)n { return [self ngt:n f:^{ return [NSNumber numberWithInteger:[self gi]]; }]; }
- (NSArray *)ngss: (NSInteger)n { return [self ngt:n f:^{ return [self gss]; }]; }
- (NSArray *)ngis: (NSInteger)n { return [self ngt:n f:^{ return [self gis]; }]; }
- (NSString *)scns { while ([scn count] == idx) { idx = 0; scn = [self gss]; } return [scn objectAtIndex:idx++]; }
- (NSInteger)scni { return [[self scns] integerValue]; }
- (void)write: (NSString *)str { [stdOut writeData:[str dataUsingEncoding:enc]]; }
- (void)writeln: (NSString *)str { [self write: str]; [self write: @"\n"]; }
- (void)writei: (NSInteger)val { [self write:[[NSNumber numberWithInteger:val] stringValue]]; }
- (void)writeiln: (NSInteger)val { [self writei: val]; [self write: @"\n"]; }
@end
void solve(MyIO *io); int main(void){ @autoreleasepool { solve([MyIO new]); } return 0; }
// ==================================================================================

void solve(MyIO *io) {
        
        
        NSInteger
            n = [io gi],
            m = [io gi],
            answer = (m / (2 * n)) + (m % (2 * n) ? 1 : 0);
        
        [io writeiln: answer];
        
}

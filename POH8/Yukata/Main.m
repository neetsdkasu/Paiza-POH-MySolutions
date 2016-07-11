/* Try POH
 * author: Leonardone @ NEETSDKASU
 */
// ==================================================================================
#import <Foundation/Foundation.h>
// ==================================================================================
NSNumber* wrap(NSInteger val) { return [NSNumber numberWithInteger: val]; }
NSInteger ti(NSString *s) { return [s integerValue]; }
NSUInteger tu(NSString *s) { return [s integerValue]; }
NSArray* subArr(NSArray *a, NSUInteger f, NSUInteger e) { return [a subarrayWithRange: NSMakeRange(f, e)]; }
id getArr(NSArray *a, NSUInteger i) { return [a objectAtIndex: i]; }
NSArray* Uv2(NSArray *a, NSUInteger *v1, NSUInteger *v2) {
    *v1 = tu(getArr(a, 0)); *v2 = tu(getArr(a, 1)); return subArr(a, 2, [a count] - 2); }
NSArray* Iv2(NSArray *a, NSInteger *v1, NSInteger *v2) {
    *v1 = ti(getArr(a, 0)); *v2 = ti(getArr(a, 1)); return subArr(a, 2, [a count] - 2); }
NSArray* Iv3(NSArray *a, NSInteger *v1, NSInteger *v2, NSInteger *v3) {
    *v1 = ti(getArr(a, 0)); *v2 = ti(getArr(a, 1)); *v3 = ti(getArr(a, 2)); return subArr(a, 3, [a count] - 3); }
NSArray* Iv4(NSArray *a, NSInteger *v1, NSInteger *v2, NSInteger *v3, NSInteger *v4) {
    *v1 = ti(getArr(a, 0)); *v2 = ti(getArr(a, 1)); *v3 = ti(getArr(a, 2)); *v4 = ti(getArr(a, 3)); return subArr(a, 4, [a count] - 4); }
NSArray* sorted(NSArray *a) { return [a sortedArrayUsingSelector: @selector(compare:)]; }
NSMutableArray* makeArr(NSUInteger size, id initval) {
    NSMutableArray *a = [NSMutableArray new]; while (size-- > 0) { [a addObject: initval]; } return a; }
@interface MyIO : NSObject
{   NSArray *lines; NSInteger cur; NSFileHandle *stdOut; NSStringEncoding enc; NSArray *scn; NSInteger idx; }
- (NSString *)gs; - (NSInteger)gi; - (NSArray *)gss; - (NSArray *)gis;
- (NSArray *)ngs: (NSInteger)n; - (NSArray *)ngi: (NSInteger)n; - (NSArray *)ngss: (NSInteger)n; - (NSArray *)ngis: (NSInteger)n;
- (NSString *)scns; - (NSInteger)scni;
- (void)write:(NSString *)str; - (void)writeln:(NSString *)str;
- (void)writed:(id)dat;        - (void)writedln:(id)dat;
- (void)writei:(NSInteger)val; - (void)writeiln:(NSInteger)val;
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
- (NSArray *)gis { NSMutableArray *a = [NSMutableArray new]; for (id v in [self gss]) { [a addObject:wrap([v integerValue])]; } return a; }
- (NSArray *)ngt:(NSInteger)n f:(id (^)(void))f { NSMutableArray *a = [NSMutableArray new]; for (NSUInteger i = 0; i < n; i++) { [a addObject:f()]; } return a; }
- (NSArray *)ngs: (NSInteger)n { return [self ngt:n f:^{ return [self gs]; }]; }
- (NSArray *)ngi: (NSInteger)n { return [self ngt:n f:^{ return wrap([self gi]); }]; }
- (NSArray *)ngss: (NSInteger)n { return [self ngt:n f:^{ return [self gss]; }]; }
- (NSArray *)ngis: (NSInteger)n { return [self ngt:n f:^{ return [self gis]; }]; }
- (NSString *)scns { while ([scn count] == idx) { idx = 0; scn = [self gss]; } return [scn objectAtIndex:idx++]; }
- (NSInteger)scni { return [[self scns] integerValue]; }
- (void)write: (NSString *)str { [stdOut writeData:[str dataUsingEncoding:enc]]; }
- (void)writeln: (NSString *)str { [self write: str]; [self write: @"\n"]; }
- (void)writed: (id)dat { [self write:[dat stringValue]]; }
- (void)writedln: (id)dat { [self writed: dat]; [self write: @"\n"]; }
- (void)writei: (NSInteger)val { [self writed: wrap(val)]; }
- (void)writeiln: (NSInteger)val { [self writei: val]; [self write: @"\n"]; }
@end
void solve(MyIO *io); int main(void){ @autoreleasepool { solve([MyIO new]); } return 0; }
// ==================================================================================

void solve(MyIO *io) {
    
    NSInteger n = [io gi];
    NSArray *tss = [io ngss: n];
    
    NSInteger
        hour = 0,
        temp = 0,
        cost = 24;
    
    for (NSArray *ts in tss) {
        NSInteger t = ti(getArr(ts, 0));
        NSString *s = getArr(ts, 1);
        
        if (temp > 0) {
            NSInteger diff = t - hour;
            if (diff < temp) {
                cost += diff;
                temp -= diff;
            } else {
                cost += temp;
                temp = 0;
            }
        }
        
        hour = t;
        
        temp += [s isEqual: @"out"] ? 3 : 5;
        
    }
    
    if (temp > 0) {
        NSInteger diff = 24 - hour;
        if (diff < temp) {
            cost += diff;
        } else {
            cost += temp;
        }
    }
    
    [io writeiln: cost];
}

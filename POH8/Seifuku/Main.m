/* Try POH
 * author: Leonardone @ NEETSDKASU
 */
// ==================================================================================
#import <Foundation/Foundation.h>
// ==================================================================================
NSNumber* wrap(NSInteger val) { return [NSNumber numberWithInteger: val]; }
NSInteger ti(NSString *s) { return [s integerValue]; }
NSArray* Iv2(NSArray *a, NSInteger *v1, NSInteger *v2) {
    *v1 = ti([a objectAtIndex:0]); *v2 = ti([a objectAtIndex:1]); return [a subarrayWithRange:NSMakeRange(2, [a count] - 2)]; }
NSArray* Iv3(NSArray *a, NSInteger *v1, NSInteger *v2, NSInteger *v3) {
    *v1 = ti([a objectAtIndex:0]); *v2 = ti([a objectAtIndex:1]); *v3 = ti([a objectAtIndex:2]); return [a subarrayWithRange:NSMakeRange(3, [a count] - 3)]; }
NSArray* Iv4(NSArray *a, NSInteger *v1, NSInteger *v2, NSInteger *v3, NSInteger *v4) {
    *v1 = ti([a objectAtIndex:0]); *v2 = ti([a objectAtIndex:1]); *v3 = ti([a objectAtIndex:2]); *v4 = ti([a objectAtIndex:3]); return [a subarrayWithRange:NSMakeRange(4, [a count] - 4)]; }
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
- (NSArray *)gis { NSMutableArray *a = [NSMutableArray new]; for (id v in [self gss]) { [a addObject:[NSNumber numberWithInteger:[v integerValue]]]; } return a; }
- (NSArray *)ngt:(NSInteger)n f:(id (^)(void))f { NSMutableArray *a = [NSMutableArray new]; for (NSUInteger i = 0; i < n; i++) { [a addObject:f()]; } return a; }
- (NSArray *)ngs: (NSInteger)n { return [self ngt:n f:^{ return [self gs]; }]; }
- (NSArray *)ngi: (NSInteger)n { return [self ngt:n f:^{ return [NSNumber numberWithInteger:[self gi]]; }]; }
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
    
    NSArray *c = [io gss];
    
    NSMutableArray
        *rnk = makeArr([c count], @0);
    
    NSInteger r = 1, v = 0, x = 0;
    NSUInteger p = [c count] + 1;
    
    while (r < 53) {
        for (NSUInteger i = 0; i < [c count]; i++) {
            if (i == p) {
                p = [c count] + 1;
                x = 0;
            }
            if ([@0 isEqual: [rnk objectAtIndex: i]]) {
                NSString *ci = [c objectAtIndex: i];
                if ([ci isEqual: @"J"]) {
                    v = 11;
                } else if ([ci isEqual: @"Q"]) {
                    v = 12;
                } else if ([ci isEqual: @"K"]) {
                    v = 13;
                } else if ([ci isEqual: @"A"]) {
                    v = 14;
                } else if ([ci isEqual: @"2"]) {
                    v = 15;
                } else {
                    v = ti(ci);
                }
                if (v > x) {
                    p = i;
                    x = v;
                    [rnk replaceObjectAtIndex: i withObject: wrap(r)];
                    r++;
                }
            }
        }
    }
    
    for (NSUInteger i = 0; i < [rnk count]; i++) {
        [io writedln: [rnk objectAtIndex: i]];
    }
}

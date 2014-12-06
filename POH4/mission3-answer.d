import std.stdio, std.conv, std.string, std.array;
void main(){
    string line = readln();
    int t, n, m, temp, maximum, i;
    int a[300000];
    t = parse!int(line);
    munch(line, " ");
    n = parse!int(line);
    while ((line = readln()) !is null) {
        m = parse!int(line);
        a[i] = m;
        if (i >= t) {
            temp += m - a[i - t];
        } else {
            temp += m;
        }
        if (temp > maximum) {
            maximum = temp;
        }
        i++;
    }
    writeln(maximum);
}

import std.stdio;
import std.string;

void main(){
    int n;
    
    readf("%d\n", &n);
    
    string[] words;
    
    words.length = n;
    
    for (int i = 0; i < n; i++) {
        words[i] = chomp(readln());
    }
    
    words.sort;
    
    string f = "", c = "", e = "";
    
    outer_loop:
    for (int i = 0; i < n; i++) {
        if (words[i] == "")
            continue;
        string rev = "";
        foreach (char ch ; words[i]) {
            rev = ch ~ rev;
        }
        for (int j = i + 1; j < n; j++) {
            if (words[j] != rev)
                continue;
            f ~= words[i];
            e = rev ~ e;
            words[j] = "";
            continue outer_loop;
        }
        if (words[i] != rev)
            continue;
        if (c == "" || rev < c)
            c = rev;
    }
    
    writeln(f ~ c ~ e);
}

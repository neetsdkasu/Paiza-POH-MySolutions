import std.stdio;
import std.string;
import std.bigint;

string reverse(string str) {
    string rev = "";
    for (int i = 0; i < str.length; i++) {
        rev = str[i] ~ rev;
    }
    return rev;
}

void main() {
    
    string n_str = chomp(stdin.readln());
    
    if (n_str == null) {
        return;
    }
    
    if (isNumeric(n_str) == false) {
        return;
    }
    
    BigInt n_bigint = n_str;
    
    int n = n_bigint.toInt();
    
    string[] words;
    
    words.length = n;
    
    for (auto i = 0; i < n; i++) {
        string word = chomp(stdin.readln());
        words[i] = word;
    }
    
    for (int i = 0; i < n - 1; i++) {
        for (int j = 1; j < n; j++) {
            string word1 = words[j - 1];
            string word2 = words[j];
            if (word2 < word1) {
                words[j - 1] = word2;
                words[j] = word1;
            }
        }
    }
    
    string front = "";
    string center = "";
    string end = "";
    
    outer_loop:
    for (int i = 0; i < n; i++) {
        if (words[i] == "") {
            continue;
        }
        string rev = reverse(words[i]);
        for (int j = i + 1; j < n; j++) {
            if (words[j] == rev) {
                front ~= words[i];
                end = rev ~ end;
                words[j] = "";
                continue outer_loop;
            }
        }
        if (words[i] == rev) {
            if (center == "" || words[i] < center) {
                center = words[i];
            }
        }
    }
    
    string result = front ~ center ~ end;
    
    writeln(result);
    
}

/////////////////////////////////////////////////////////////////////
// paiza Online Hackathon vol.6+ (POH!6+)
// https://paiza.jp/poh/joshibato/matsue-ruby
// output palindrome with maximum length and lowest lexical order
//   that is composed of all or part of list of words taken by stdin
// [ Detarame English ! ]
/////////////////////////////////////////////////////////////////////
#include <iostream>
#include <vector>
#include <string>
#include <algorithm>

int main(){
    
    using std::string;
    typedef std::vector<string> strvector;
    
    int n;
    
    std::cin >> n;
    
    strvector word_list;
    
    for (int i = 0; i < n; i++) {
        string word;
        std::cin >> word;
        word_list.push_back(word);
    }
    
    std::sort(word_list.begin(), word_list.end());
    std::reverse(word_list.begin(), word_list.end());
    
    string left_side, center, right_side;
    
    while (!word_list.empty()) {
        
        string word = word_list.back();
        word_list.pop_back();

        string reversed_word = word;
        std::reverse(reversed_word.begin(), reversed_word.end());
        
        strvector::iterator result = std::find(word_list.begin(), word_list.end(), reversed_word);
        
        if (result != word_list.end()) {
            word_list.erase(result);
            left_side += word;
            right_side = reversed_word + right_side;
        } else {
            if (word == reversed_word && (center.empty() || center.compare(word) > 0)) {
                center = word;
            }
        }
    }

    std::cout << left_side << center << right_side;
    
    return 0;
}

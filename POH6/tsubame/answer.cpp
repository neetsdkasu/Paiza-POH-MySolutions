/*
 * 結果 https://paiza.jp/poh/joshibato/tsubame/result/3beb9438
 *
 * 注意： c++11を使用
 */
#include <iostream>
#include <string>

int main(void){
    
    using namespace std;
    
    string n_str;
    
    cin >> n_str;
    
    int n = stoi(n_str);
    int n1 = stoi(n_str.substr(1,1));
    int n10 = stoi(n_str.substr(0,1));
    
    int r = n + n1 + n10;
    
    cout << r << endl;
    
    return 0;
}

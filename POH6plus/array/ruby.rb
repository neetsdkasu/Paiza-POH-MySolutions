#! ruby

n = gets.to_i

word_list = $<.read.split.sort

left_side_palindrome = ""
center_of_palindrome = ""
right_side_palindrome = ""

word_list.each_index do |i|
    
    word = word_list[i]
    
    next if word == ""
    
    word_list[i] = ""
    
    rev_word = word.reverse
    
    rev_index = word_list.index(rev_word)
    
    if rev_index.nil? || rev_index == i then
        
        if  word == rev_word && (center_of_palindrome == "" || word < center_of_palindrome) then
    
            center_of_palindrome = word
            
        end
    
    elsif rev_index > i then
        
        left_side_palindrome << word
        
        right_side_palindrome = rev_word + right_side_palindrome
        
        word_list[rev_index] = ""
    
    end
    
end

palindrome = left_side_palindrome + center_of_palindrome + right_side_palindrome

puts palindrome

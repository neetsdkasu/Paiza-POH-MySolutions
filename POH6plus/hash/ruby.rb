#! ruby

n = gets.to_i

word_count = Hash.new 0

while gets do

    $_.chomp!
    
    word_count[$_] += 1

end

left_side_palindrome = ""
center_of_palindrome = ""
right_side_palindrome = ""

word_count.keys.sort.each do |word|
   
    rev = word.reverse 

    if word > rev then
        
        next
        
    end

    count = [ word_count[word], word_count[rev] ].min
    
    if word == rev then
        
        if count.odd? then
            
            if center_of_palindrome == "" || word < center_of_palindrome then
               
                center_of_palindrome = word
                
            end
            
            count -= 1
            
        end
        
        count /= 2
        
    end
    
    left_side_palindrome += word * count
    right_side_palindrome = rev * count + right_side_palindrome
    
end

palindrome = left_side_palindrome + center_of_palindrome + right_side_palindrome

puts palindrome

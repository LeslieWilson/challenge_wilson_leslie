require 'json'

file = File.read('./file.json')
json = JSON.parse(file)

def recursive_search(data, desired_value, desired_key, hits = [])
  case data
  when Array
    data.each do |value|
      recursive_search(value, desired_value, desired_key, hits)
    end
  when Hash
    data.each do |key, val|
      if val == desired_value
        hits << val
      end
      if key == "classNames"
        val.each do |item|
          if item == desired_value
            hits << item
          end
        end
      end
      recursive_search(val,desired_value, desired_key, hits)
    end
  end
  return hits
end

def commandLineConvo(json,response)
  if response.include?(".")
     response = response[1..-1]
    result = recursive_search(json,response,"classNames")
  elsif
    response.include?("#")
    response = response[1..-1]
    result = recursive_search(json,response,"identifier")
  else
    result = recursive_search(json,response,"class")
  end
return result
end

puts "please enter a selector"
response = gets.chomp
result = commandLineConvo(json,response)
puts "Here is an array of the items you're looking for:"
print result
puts "\nYou found #{result.length} items!!"

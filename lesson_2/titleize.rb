# titleize

def titleize(input_string)
  new_string = input_string.split.map {|word| word.capitalize}
  new_string.join(" ")
end

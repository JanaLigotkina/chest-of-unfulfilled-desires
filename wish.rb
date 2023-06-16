require "rexml/document"
require "date"

wish_true = {}
wish_false = {} 
today = Date.today

current_path = File.dirname(__FILE__)
file_name = current_path + "/wish.xml"

file = File.new(file_name, "r:UTF-8")

doc = REXML::Document.new(file)

file.close

doc.elements.each("wishes/wish") do |item|
	date_item = Date.parse(item.attributes['date'])
	
	if date_item.year < today.year 
		wish_true[item.attributes['date']] = item.root.elements["wish"].text.strip

	elsif date_item.year == today.year 
		if date_item.month < today.month
			wish_true[item.attributes['date']] = item.root.elements["wish"].text.strip

		elsif date_item.month == today.month	 	
			if date_item.day < today.day
				wish_true[item.attributes['date']] = item.root.elements["wish"].text.strip
			else 	
				wish_false[item.attributes['date']] = item.root.elements["wish"].text.strip
			end	
		else 
			wish_false[item.attributes['date']] = item.root.elements["wish"].text.strip
		end 
	else wish_false[item.attributes['date']] = item.root.elements["wish"].text.strip		
	end	
end	

puts 'Эти желания должны уже были сбыться к сегодняшнему дню'
keys = wish_true.keys
keys.each do |item|
	puts "#{item}: #{wish_true[item]}"
end

puts wish_true



class Solution
	attr_accessor :filled_values
	attr_accessor :text

	def initialize(text)
		self.filled_values = Hash.new
		self.text = text
	end

	def fill_field(label, value)
		label, position = label.scan(/(.*) \((.*?)\)/).flatten

		self.filled_values[label.downcase] ||= Array.new
		self.filled_values[label.downcase][position.to_i] = value[:with]
	end

	def resolve
		resolved_text = self.text

		self.filled_values.each do |key, values|
			values.shift
			resolved_text = resolved_text.gsub!("{#{key}}").each_with_index { |value, index| values[index] }
		end

		resolved_text
	end
end
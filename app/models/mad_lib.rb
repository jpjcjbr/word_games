class MadLib
	attr_accessor :text
	attr_accessor :parts_of_speech
	attr_accessor :solutions

	def self.create(params)
		madLib = MadLib.new
		madLib.parts_of_speech = parse_parts_of_speech(params[:text])
		madLib.solutions = Solutions.new(params[:text])

		madLib
	end

	def has_field?(label)
		label, position = label.scan(/(.*) \((.*?)\)/).flatten
		parts_of_speech[label.downcase] >= position.to_i
	end

	def self.parse_parts_of_speech(text)
		groups = text.scan(/{(.*?)}/).flatten

		parts_of_speech = groups.inject(Hash.new(0)) do |hash, element|
			 hash[element] += 1
			 hash
		end
	end

end
class Solutions
	attr_accessor :text

	def initialize(text)
		self.text = text
	end

	def create
		Solution.new(text)
	end
end
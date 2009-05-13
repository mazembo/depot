class Product < ActiveRecord::Base
	validates_presence_of :title, :description, :image_url
	validates_numericality_of :price
	validates_uniqueness_of :title
		
	protected 
	def validate
		 errors.add( :price, "should be positive") unless price.nil? || price >= 0.01
	end
end

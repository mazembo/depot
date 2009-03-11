class StoreController < ApplicationController

  def index
  @products = Product.salable_items
  end
  
  def add_to_cart 
    product = Product.find(params[:id])
    @cart = find_cart
    @cart.add_product(product)
    redirect_to(:action => "display_cart")
    rescue 
    logger.error("Attempt to access invalid product #{params[:id]} )")
    redirect_to_index("invalid product")
  end
  def display_cart
    @cart = find_cart
    @items = @cart.items
    if @items.empty?
      redirect_to_index("Your cart is currently empty ")
    end
  end
  
   def empty_cart
    @cart = find_cart
    @cart.empty!
    redirect_to_index("Your cart is now empty ")
  end

   def empty!
   @items = []
   @total_price = 0.0
   end  
   
   private 
   def redirect_to_index (msg = nil)
     flash[:notice] = msg if msg
     redirect_to(:action => "index")
   end 
  
  private 
  def find_cart
    session[:cart] ||= Cart.new
  end
  end

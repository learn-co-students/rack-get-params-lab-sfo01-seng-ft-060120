require 'pry'
class Application

  @@items = ["Apples","Carrots","Pears"]
  @@cart = []
  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path.match(/items/)
      @@items.each do |item|
        resp.write "#{item}\n"
      end
    # revisit the HTTP Request lab for GET & params example
    elsif req.path.match(/search/)
      search_term = req.params["q"]
      resp.write handle_search(search_term)
    end
    if @@cart.empty?
      resp.write "Your cart is empty"
    elsif @@cart.each do |item|
      resp.write "#{item}\n"
    end
  end

  if req.path.match(/add/)
    add_item = req.params["item"]
    if @@items.include?(add_item)
       @@cart << add_item 
       resp.write "added #{add_item}"
    else
      resp.write "We don't have that item"
    end
  end
    resp.finish
  end

  def handle_search(search_term)
    if @@items.include?(search_term)
      return "#{search_term} is one of our items"
    else
      return "Couldn't find #{search_term}"
    end
  end
end

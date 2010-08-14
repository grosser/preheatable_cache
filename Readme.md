Speedup cache requests by preheating.

Makes Rails caches preheatable via read_multi, for keys that will later be used.
Clear the preheated cache after each request.


# Install
    script/plugin install http://github.com/grosser/preheatable_cache

# Usage

    # controller - multi_get to fetch all keys at once
    Rails.cache.preheat @products.map{|p| "views/product_#{p.id}" }

    # view - no requests to the cache server
    <% cache "product_#{product.id}" do %>
      ...
    <% end %>


Author
======
[Michael Grosser](http://pragmatig.wordpress.com)  
grosser.michael@gmail.com  
Hereby placed under public domain, do what you want, just do not hold me accountable...
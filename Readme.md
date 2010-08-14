Reduce cache requests by preheating via multi_get.

Makes Rails MemCacheStore preheatable via read_multi, for keys that will later be used.  
Clears the preheated cache after each request.

 - not threadsave
 - not altered when writing/incrementing/... underlying cache store

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
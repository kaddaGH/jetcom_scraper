require 'uri'
require './lib/headers'
pages << {
    page_type: 'products_listing',
    method: 'GET',
    url: "https://jet.com/search?category=15000017",
    ua_type: "gb2",
    vars: {
        'input_type' => 'taxonomy',
        'search_term' => '-',
        'page' => 1
    }


}
search_terms = [
    'Red Bull',
    'RedBull',
    'Energy Drink',
    'Energy Drinks',
]
search_terms.each do |search_term|

  pages << {
      page_type: 'products_listing',
      method: 'GET',
      url:'https://jet.com/search?term='+ URI.encode(search_term),
      ua_type: "gb2",
      vars: {
          'input_type' => 'search',
          'search_term' => search_term,
          'page' => 1
      }


  }

end
require 'uri'
require './lib/headers'
pages << {
    page_type: 'products_listing',
    method: 'GET',
    url: "https://jet.com/search?category=15000017&page=1",
    headers: ReqHeaders::REQ_HEADER,
    vars: {
        'input_type' => 'taxonomy',
        'search_term' => '-',
        'page' => 1,
        'products_urls'=>[]
    }


}
search_terms = [
    'Red Bull',
    'RedBull',
    'Energy Drink',
    'Energy Drinks',
]
search_terms.each do |search_term|
  break
  pages << {
      page_type: 'products_listing',
      method: 'GET',
      url:'https://jet.com/search?page=1&st=5&term='+ URI.encode(search_term),
      headers: ReqHeaders::REQ_HEADER,
      vars: {
          'input_type' => 'search',
          'search_term' => search_term,
          'page' => 1,
          'products_urls'=>[]
      }


  }

end
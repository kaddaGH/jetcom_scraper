require 'uri'
require './lib/headers'

body = Nokogiri.HTML(content)
json = body.css('script').find do |el|
  el.text =~ /__NEXT_DATA__/
end.to_s.scan(/__NEXT_DATA__ =[\n\s]*?(\{[\W\w]+?\})[\n\s]*?module=\{\}/).join

json = body.at('script:contains("__NEXT_DATA__")').text.scan(/__NEXT_DATA__ =[\n\s]*?(\{.+\})[\n\s]*?(module=\{\}|;)/).first.first if json.length < 1

data = JSON.parse(json) rescue nil
if data
  if page['vars']['page'] == 1
    total_pages = data['props']['initialState']['entities']['singles']['search']['value']['filterState']['totalPages']
    if total_pages.to_i > 1
      i = 2
      while i <= total_pages.to_i do
        url = page['url'] + "&page=#{i}"
        pages << {
            page_type: 'products_listing',
            method: 'GET',
            url: url,
            headers: ReqHeaders::REQ_HEADER,
            vars: {
                'input_type' => page['vars']['input_type'],
                'search_term' => page['vars']['search_term'],
                'page' => i
            }
        }
        i += 1
      end
    end
  end


  scrape_url_nbr_products = data['props']['initialState']['entities']['singles']['search']['value']['filterState']['total']
  options = {
      'input_type' => page['vars']['input_type'],
      'search_term' => page['vars']['search_term'],
      'SCRAPE_URL_NBR_PRODUCTS' => scrape_url_nbr_products,
      'rank' => 0,
      'page' => page['vars']['page'],
  }

  body.css('div.core__Box-avlav9-0.eZsrxv a').each do | product|
    break
    url = 'https://jet.com'+product.attr('href')
    options['rank'] =options['rank']+1
    pages << {
        page_type: 'product_details',
        method: 'GET',
        url: url+"&search_term="+options['search_term']+"&page=#{options['page']}",
        headers: ReqHeaders::REQ_HEADER,
        vars: options

    }

  end
  end




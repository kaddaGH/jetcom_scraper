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
        break
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


  urls = data['props']['initialState']['entities']['collections']['product']['entities'].map do |id, product|

    uri = URI::HTTPS.build(
        host: 'jet.com', path: "/product/#{product['title'].delete('-.,/%"®\\?()').gsub(/\s/, '-').gsub('&', 'and').gsub(/-{2,}/, '-')}/#{product['id']}",
        query: URI.encode_www_form([["beaconId", product['beaconId']], ["experienceId", product['experienceId']]])
    )

    uri.to_s
  end



  urls.each_with_index do |url, i|

    scrape_url_nbr_products = data['props']['initialState']['entities']['singles']['search']['value']['filterState']['total']
    options = {
        'input_type' => page['vars']['input_type'],
        'search_term' => page['vars']['search_term'],
        'SCRAPE_URL_NBR_PRODUCTS' => scrape_url_nbr_products,
        'rank' => i + 1,
        'page' => page['vars']['page'],
    }

    pages << {
        page_type: 'product_details',
        method: 'GET',
        url: url+"&search_term="+options['search_term']+"&page=#{options['page']}",
        headers: ReqHeaders::REQ_HEADER,
        vars: options

    }

  end


end

require 'uri'
require './lib/headers'

body = Nokogiri.HTML(content)
json = body.css('script').find do |el|
  el.text =~ /__NEXT_DATA__/
end.to_s.scan(/__NEXT_DATA__ =[\n\s]*?(\{[\W\w]+?\})[\n\s]*?module=\{\}/).join

json = body.at('script:contains("__NEXT_DATA__")').text.scan(/__NEXT_DATA__ =[\n\s]*?(\{.+\})[\n\s]*?(module=\{\}|;)/).first.first if json.length < 1

data = JSON.parse(json) rescue nil
if data
  total_pages = data['props']['initialState']['entities']['singles']['search']['value']['filterState']['totalPages']
  current_page = page['vars']['page']
  products_urls = page['vars']['products_urls']
  if current_page < total_pages
    # get the products
    rank=0
    body.css('div.core__Box-avlav9-0.eZsrxv a.BaseProductTile__ItemLink-mors47-0').each do | product|
      url = 'https://jet.com'+product.attr('href')
      rank=rank+1
      products_urls << {
          url: url+"&search_term="+page['vars']['search_term']+"&page=#{page['vars']['page']}",
          vars: {
              'rank' => rank,
              'page' => current_page,
          }
      }
    end

     # queue next page
    url = page['url'] + "&zipCode=10011&page=#{current_page+1}"
    pages << {
        page_type: 'products_listing',
        method: 'GET',
        url: url,
        headers: ReqHeaders::REQ_HEADER,
        vars: {
            'input_type' => page['vars']['input_type'],
            'search_term' => page['vars']['search_term'],
            'page' => current_page+1,
            'products_urls'=>products_urls
        }
    }
  end

  end

    # if it's last page proccess all scraped products urls

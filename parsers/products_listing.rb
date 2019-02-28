require 'uri'
require './lib/headers'

body = Nokogiri.HTML(content)

json =body.at('#__NEXT_DATA__').text

data = JSON.parse(json) rescue nil
if data
  total_pages = data['props']['initialState']['entities']['singles']['search']['value']['filterState']['totalPages']

  current_page = page['vars']['page']
  products_urls = page['vars']['products_urls']
  if current_page < total_pages
    # get the products
    rank = 0
    body.css('a.BaseProductTile__ItemLink-mors47-0').each do |product|
      url = 'https://jet.com' + product.attr('href')
      rank = rank + 1
      products_urls << {
          'url' => url + "&search_term=" + page['vars']['search_term'] + "&page=#{page['vars']['page']}&rank=#{rank}",
          'rank' => rank,
          'page' => current_page

      }
    end

    # queue next page
    url = page['url'].gsub(/page=\d+/, "page=#{current_page + 1}")
    pages << {
        page_type: 'products_listing',
        method: 'GET',
        url: url,
        headers: ReqHeaders::REQ_HEADER,
        vars: {
            'input_type' => page['vars']['input_type'],
            'search_term' => page['vars']['search_term'],
            'page' => current_page + 1,
            'products_urls' => products_urls
        }
    }

    # if it's last page proccess all scraped products urls
  elsif current_page >= total_pages
    # get the products
    rank = 0
    body.css('div.core__Box-avlav9-0.eZsrxv a.BaseProductTile__ItemLink-mors47-0').each do |product|
      url = 'https://jet.com' + product.attr('href')
      rank = rank + 1
      products_urls << {
          'url' => url + "&search_term=" + page['vars']['search_term'] + "&st=1&page=#{page['vars']['page']}&rank=#{rank}",
          'rank' => rank,
          'page' => current_page
      }
    end
    scrape_url_nbr_products = products_urls.length
    products_urls.each do |product|
      pages << {
          page_type: 'product_details',
          method: 'GET',
          url: product['url'],
          headers: ReqHeaders::REQ_HEADER,
          vars: {
              'input_type' => page['vars']['input_type'],
              'search_term' => page['vars']['search_term'],
              'SCRAPE_URL_NBR_PRODUCTS' => scrape_url_nbr_products,
              'rank' => product['rank'],
              'page' => product['page']
          }

      }


    end

  end


end

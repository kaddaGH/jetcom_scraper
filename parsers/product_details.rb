body = Nokogiri.HTML(content)

json =body.at('#tb-djs-NEXT_DATA').text
data = JSON.parse(json) rescue nil

products = data['props']['initialState']['entities']['collections']['product']['entities'] rescue nil
if data && products

  prices = data['props']['initialState']['entities']['collections']['productPrice']['entities']
  id = page['url'].split('/').last.split('#').first.gsub(/\?.+?\Z/,'')

  title = (products[id] || products.first[1])['title']
  [
      /(\d*[\.,]?\d+)[-\s]*?([Ff][Ll]\.?[-\s]*?[Oo][Zz])/,
      /(\d*[\.,]?\d+)[-\s]*?([Oo][Zz])/,
      /(\d*[\.,]?\d+)[-\s]*?([Ff][Oo])/,
      /(\d*[\.,]?\d+)[-\s]*?([Ee][Aa])/,
      /(\d*[\.,]?\d+)[-\s]*?([Ff][Zz])/,
      /(\d*[\.,]?\d+)[-\s]*?(Fluid Ounces?)/,
      /(\d*[\.,]?\d+)[-\s]*?([Oo]unce)/,
      /(\d*[\.,]?\d+)[-\s]*?([Pp]ounds)/,
      /(\d*[\.,]?\d+)[-\s]*?([Cc][Ll])/,
      /(\d*[\.,]?\d+)[-\s]*?([Mm][Ll])/,
      /(\d*[\.,]?\d+)[-\s]*?([Ll][Bb][Ss])/,
      /(\d*[\.,]?\d+)[-\s]*?([Ll][Bb])/,
      /(\d*[\.,]?\d+)[-\s]*?([Ll])/,
      /(\d*[\.,]?\d+)[-\s]*?([Gg])/,
      /(\d*[\.,]?\d+)[-\s]*?([Ll]itre)/,
      /(\d*[\.,]?\d+)[-\s]*?((Single\s)?[Ss]ervings?)/,
      /(\d*[\.,]?\d+)[-\s]*?([Pp]acket\(?s?\)?)/,
      /(\d*[\.,]?\d+)[-\s]*?([Cc]apsules)/,
      /(\d*[\.,]?\d+)[-\s]*?([Tt]ablets)/,
      /(\d*[\.,]?\d+)[-\s]*?([Tt]ubes)/,
      /(\d*[\.,]?\d+)[-\s]*?([Cc]hews)/
  ].find { |regexp| title =~ regexp }
  item_size = $1
  uom = $2

  match = [
      /(\d+)[-\s]*?[xX]/,
      /Pack of (\d+)/,
      /Box of (\d+)/,
      /Case of (\d+)/,
      /Count of (\d+)/,
      /(\d+)[-\s]*?[Cc]ount/,
      /(\d+)[-\s]*?[Cc][Tt]/,
      /(\d+)[\s-]?Pack($|[^e])/,
      /(\d+)[-\s]*?[Pp][Kk]/
  ].find { |regexp| title =~ regexp }
  in_pack = match ? $1 : '1'

  product_details = data['props']['initialState']['entities']['collections']['productDetails']['entities']

  description = [
      (product_details[id] || product_details.first[1])['description'],
      (product_details[id] || product_details.first[1])['bullets']
  ].join(' ').gsub(/<("[^"]*"|'[^']*'|[^'">])*>/, '').gsub(/[\n\s,]+/, ' ')

  if item_size.nil? && uom.nil?
    description.scan(/(\d{1,3})(ml) Bottle Size/)
    item_size = $1
    uom = $2
  end

  upc_code = body.to_s.match(/"upc":"(\d+)"/)[1] rescue ''

  product_image = (products[id] || products.first[1])['image']['raw']
  if product_image.length>1
    product_image = 'http://162.243.94.227/imagesproxy/proxy.php?url='+product_image
  end


  info = {
        RETAILER_ID: '0001',
        RETAILER_NAME: 'jet.com',
        GEOGRAPHY_NAME: 'US',
        SCRAPE_INPUT_TYPE: page['vars']['input_type'],
        SCRAPE_INPUT_SEARCH_TERM: page['vars']['search_term'],
        SCRAPE_INPUT_CATEGORY: page['vars']['input_type'] == 'taxonomy' ? 'Sports & Energy Drinks' : '-',
        SCRAPE_URL_NBR_PRODUCTS: page['vars']['SCRAPE_URL_NBR_PRODUCTS'],
        SCRAPE_URL_NBR_PROD_PG1: page['vars']['SCRAPE_URL_NBR_PRODUCTS'] < 24 ? page['vars']['SCRAPE_URL_NBR_PRODUCTS'] : 24,
        PRODUCT_BRAND: (products[id] || products.first[1])['brand'],
        PRODUCT_RANK: page['vars']['rank'],
        PRODUCT_PAGE: page['vars']['page'],
        PRODUCT_ID: id,
        PRODUCT_NAME: title,
        PRODUCT_DESCRIPTION: CGI.unescapeHTML(description),
        PRODUCT_MAIN_IMAGE_URL: product_image,
        PRODUCT_ITEM_SIZE: (item_size rescue ''),
        PRODUCT_ITEM_SIZE_UOM: (uom rescue ''),
        PRODUCT_ITEM_QTY_IN_PACK: (in_pack rescue ''),
        PRODUCT_STAR_RATING: (product_details[id] || product_details.first[1])['avgStarRating'],
        PRODUCT_NBR_OF_REVIEWS: (product_details[id] || product_details.first[1])['reviewCount'],
        SALES_PRICE: (prices[id] || prices.first[1])['price']['effective'],
        IS_AVAILABLE: (prices[id] || prices.first[1])['isAvailable'] ? '1' : '',
        PROMOTION_TEXT: 'Free Shipping over $35 and Free Returns',
        EXTRACTED_ON: Time.now.to_s,
        EAN: '',
        UPC: upc_code
    }


  info['_collection'] = "products"

  end
puts(info['_collection'])
outputs << info

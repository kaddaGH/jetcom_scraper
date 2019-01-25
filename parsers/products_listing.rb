require 'uri'
body = Nokogiri.HTML(content)
json = body.css('script').find do |el|
  el.text =~ /__NEXT_DATA__/
end.to_s.scan(/__NEXT_DATA__ =[\n\s]*?(\{[\W\w]+?\})[\n\s]*?module=\{\}/).join

json = body.at('script:contains("__NEXT_DATA__")').text.scan(/__NEXT_DATA__ =[\n\s]*?(\{.+\})[\n\s]*?(module=\{\}|;)/).first.first  if json.length<1

data = JSON.parse(json) rescue nil

if data
  if page['vars']['page'] == 1
    data['props']['initialState']['entities']['singles']['search']['value']['filterState']['totalPages'].times do |i|
      if i != 0
        url = page['url'] + "&page=#{i + 1}"
        pages << {
            page_type: 'products_listing',
            method: 'GET',
            url: url,
            ua_type: "gb2",
            vars: {
                'input_type' => page['vars']['input_type'],
                'search_term' => page['vars']['search_term'],
                'page' => page['vars']['page'] + 1
            }


        }

      end
      break
    end
  end



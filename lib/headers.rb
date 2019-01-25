module ReqHeaders
  REQ_HEADER = {
      'Host' => 'jet.com',
      'accept' => 'text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8',
      'accept-encoding' => 'gzip, deflate, br',
      'accept-language' => 'en-US;q=0.8,en;q=0.7,de-DE;q=0.6,de;q=0.5',
      'cache-control' => 'max-age=0',
      'upgrade-insecure-requests' => '1',
      'DNT' => '1',
      'Connection' => 'keep-alive',
      'TE' => 'Trailers',
      'Cookie' => 'zipCode=10011;',#jet.csrf=jRiduKG0vjJ7gXTn9UK-mYZI; jid=803bc296-6e25-4ac7-b77b-a545d4fe63f2; jet-referer=%2Fsearch%3Fcategory%3D15000017; jet-phaser=2%3B7830766fabc64b30a80a5855acd08b44%3B4IgL%3B4KDZ5z%3B4UlPv1%3B4doewj%3B4ec0fh%3B4mIg%3B4v2mch%3B92CBI%3B93DI%3B93XzL%3B93oFG%3B94Rq9%3B973R%3B98Cw0%3B98uMSm%3B996pFe%3B9A0LU8%3B9DMHI5%3B9ED4%3B9FMG%3B9G8b%3B9GJYTj%3B9GSao%3B9HLr%3B9J12T%3B9JJvH%3B9JQAG%3B9Jp4i%3B9KXn%3B9MAixN%3B9U9s%3B9Wtaoc%3B9ck0E%3B9dFqaH%3B9dNn7%3B9eOO%3B9jHb%3B9lTaR3%3B9nUQ9%3B9rWxt9%3B9rjURs%3B9rkG%3B9uJgwR%3B9vFW8X%3B9x1819%3B9xOqTs%3B9zfkN%3B1548442812; jet-id=4cbc3d88-81a2-49db-9277-194ef171ba09; ipZipcode=29007; jet-jetGeoIp=%7B%22postal_code%22%3A%2229007%22%2C%22subdivisions_code%22%3A%2229%22%2C%22city_name%22%3A%22Mascara%22%2C%22country_code%22%3A%22DZ%22%2C%22time_zone%22%3A%22Africa%2FAlgiers%22%7D; jet-clientTicket=eyJhbGciOiJodHRwOi8vd3d3LnczLm9yZy8yMDAxLzA0L3htbGRzaWctbW9yZSNobWFjLXNoYTI1NiIsInR5cCI6IkpXVCJ9.eyJjbGllbnRfaWQiOiI2YWM2YWMxZWJjODU0OGZkOGE5YTYwMGM4Nzg5ZWIyYSIsImlzcyI6ImpldC5jb20iLCJhdWQiOiJ3ZWJjbGllbnQifQ.ut77M4ePDjWVupoOHu5lon_WvsPjg4jZ1xrxtbYqXOU; X-Akamai-Chosen=jet_com_phased_prod_eastus2; ak_bmsc=E9EF816DEBB43474FB1C3EC6E713F3985DBA89E999540000BE5C4B5CD814701D~plMrPcLSxQ35vrgIDmXDDcaVOgjtSh6TAtD5/svw2FEKvm7h4gZGoQKVt+fpsj6nr/OgBciHY0GBOne/VlW111VaEu+DRR9XXFGjVgdYY3ZZA2D5e+zcer3yIo759mO8JXTVLAA2ZAgeeB/DUI8YBHFfrQ6e4sRudmvSOUhmuGi6lgRQ4xTLDARE4iijca8+03OX4oekle0QozmLrH22qEvmbS7K/l7AfoE1FN7KJqav+e0wKaZT6JiaT8QVG2RQhk; akacd_phased_release=3725895611~rv=51~id=8994dc5a5d7602973970ea2bd178fc9d; AMCV_A7EE579F557F617B7F000101%40AdobeOrg=-330454231%7CMCIDTS%7C17922%7CMCMID%7C28747046457090353632462126277962989488%7CMCAAMLH-1549048849%7C6%7CMCAAMB-1549048849%7CRKhpRz8krg2tLO6pguXWp5olkAcUniQYPHaMWWgdJ3xzPWQmdj0y%7CMCOPTOUT-1548450019s%7CNONE%7CMCAID%7CNONE%7CvVersion%7C3.1.2%7CMCCIDH%7C2035647840; _sdsat_adobe_mcid=28747046457090353632462126277962989488; AMCVS_A7EE579F557F617B7F000101%40AdobeOrg=1; bm_sv=0031F567AC523CC6E5831A58240BF456~8mCq24M/pAhfd0Ao7H/YEuPhdH2+/2v2uYCwV52vzLtsWCwusFAwF3tg/w8JOEphVPa4UkOwyeKbc+q3xDMwNZNA1InzWK5kbXsm7YMtxYnS3sRwz33Cv0+q4JwAX9P3OAVMfuK4kCOl3tgjNhucng==; _sdsat_cart_status=inactive; s_cc=true; _tq_id.TV-098163-1.3372=cca710a9ca6b68b7.1548442836.0.1548444051..; _scid=ea2615b1-c4ae-4235-8508-c5a873583933; _gcl_au=1.1.138653869.1548442841; pses={"id":"g82igvnma7f","start":1548442841562,"last":1548444051834}; __qca=P0-1232538869-1548442843503; _fbp=fb.1.1548442844198.1896147709; bounceClientVisit2614v=N4IgNgDiBcIBYBcEQM4FIDMBBNAmAYnvgFYCmCAdAMYD2AtkSqQIYBOVcm+CprDGAEQCiAO14BzAJ54AQgNYBLEQGsQAGhCsYIEAF8gA; _hjIncludedInSample=1; _hjDonePolls=227099; _sctr=1|1548370800000',
      'user-agent' => 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3578.98 Safari/537.36'

  }

end






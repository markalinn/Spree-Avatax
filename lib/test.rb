require 'rubygems'
require 'avalara'
require 'hashie'

Avalara.password = 'BCC2F677089DF46D'
Avalara.username = '1100090663'
Avalara.endpoint = 'https://development.avalara.net'

puts 'Geo Lookup-'
tax = Avalara.geographical_tax('47.627935','-122.51702',100)
puts tax.rate

puts 'Invoice Lookup-'

invoice_lines =[]
invoice_line = Avalara::Request::Line.new(
  :line_no => '1',
  :destination_code => '1',
  :origin_code => '1',
  :qty => '25',
  :amount => '70'
)
invoice_lines << invoice_line
invoice_line = Avalara::Request::Line.new(
  :line_no => '2',
  :destination_code => '1',
  :origin_code => '1',
  :qty => '2',
  :amount => '30'
)
invoice_lines << invoice_line

invoice_address = Avalara::Request::Address.new(
  :address_code => '1',
  :line_1 => "2081 Business Center Dr.",
  :postal_code => "92612"
)
invoice_addresses = []
invoice_addresses << invoice_address

invoice = Avalara::Request::Invoice.new(
  :customer_code => '1',
  :doc_date => Date.today
)

invoice.addresses = invoice_addresses
invoice.lines = invoice_lines

puts invoice

invoice_tax = Avalara.get_tax(invoice)
puts invoice_tax

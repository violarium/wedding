require 'nokogiri'
require 'date'

# Class to find date in content if it's present.
class DateFinder
  def initialize(content)
    @doc = Nokogiri::HTML(content)
  end

  def find(date_str)
    date = parse_date(date_str)

    @doc.css('#ZagsDayMM option').each do |option|
      range = parse_date_range(option.content)
      unless range.nil?
        if range[0] <= date && date <= range[1]
          return true
        end
      end
      false
    end
  end

  private

  def parse_date(date_str)
    date_array = date_str.split('.').map { |i| i.to_i }
    Date.new(date_array[2], date_array[1], date_array[0])
  end

  def parse_date_range(date_range_str)
    matches = /(\d{2}.\d{2}.\d{4}).*?(\d{2}.\d{2}.\d{4})/.match(date_range_str)
    if matches.nil?
      nil
    else
      [parse_date(matches[1]), parse_date(matches[2])]
    end
  end
end

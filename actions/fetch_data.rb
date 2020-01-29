# frozen_string_literal: true

require "date"

class DataFetcher

  HOST = "http://untroubled.org/spam"

  def fetch
    current_year_range.each do |url|
      fetch_file(url)
    end

    previous_years.each do |url|
      fetch_file(url)
    end
  end

  private

  def current_year_range
    current_month = Date.today.month
    current_year = Date.today.year
    (1..current_month).to_a.map do |month|
      url_for(current_year, month)
    end
  end

  def previous_years
    to_year = Date.today.year - 1
    (2018..to_year).to_a.map do |year|
      url_for(year)
    end
  end

  def fetch_file(url)
    unless File.file?("data/#{File.basename(url)}")
      puts "- Downloading #{url}..."
      system(`wget url -O data/#{File.basename(url)} #{url}`)
    end
  end

  def url_for(year, month = nil)
    "#{HOST}/#{[year, month].compact.join('-')}.7z"
  end
end

DataFetcher.new.fetch

#! /usr/bin/env ruby
require 'fileutils'
require 'pathname'
require 'json'
require 'nokogiri'
require 'open-uri'

class Catalog
  attr_accessor :content

  def load
    self.content = if File.exists?(file_path)
      JSON.load file_path
    else
      FileUtils.mkdir_p File.dirname(file_path)
      {}
    end
  end

  def save
    File.write(file_path , JSON.pretty_generate(content))
  end

  def export_product_table
    File.write(product_table_path , JSON.pretty_generate(products.values))
  end

  def base_folder
    @base_folder ||= Pathname.new(File.dirname(__FILE__)).join('skin', 'cache')
  end

  def product_table_path
    @product_table_path ||= base_folder.join('product_table.json')
  end

  def file_path
    @file_path ||= base_folder.join('catalog.json')
  end

  def image_folder
    @image_folder ||= begin
      path = base_folder.join('images')
      FileUtils.mkdir_p(path) unless File.exists?(path)
      path
    end
  end

  def image_path(filename, original_path)
    extension = original_path.split('.').last
    image_folder.join([filename, extension].join('.'))
  end

  def product_metadata
    content['product_metadata']
  end

  def product_metadata=(value)
    content['product_metadata'] = value
  end

  def products
    content['products'] ||= {}
  end
end

class Scraper
  BACKOFF_SECONDS = 1
  BASE_URL = 'http://www.trumpeter-china.com'.freeze
  INDEX_URL = '/index.php?l=en'.freeze
  CATEGORY_NAMES = %w[Armor Buildings Car Plane Ship].freeze

  def catalog
    @catalog ||= begin
      result = Catalog.new
      result.load
      result
    end
  end

  def save
    catalog.save
    catalog.export_product_table
  end

  def load_product_metadata
    unless catalog.product_metadata
      catalog.product_metadata = product_metadata
    end
    STDERR.puts "[Load Product Pages][#{Time.now}] loaded"
  end

  def load_product_category(category_name)
    category_metadata = catalog.product_metadata[category_name]
    category_url = category_metadata['url']
    category_metadata['pages'].times.each do |i|
      page = i + 1
      page_url = page == 1 ? category_url : "#{category_url}&p=#{page}"
      page_doc = get_page(page_url, message: "#{category_name} Page #{page}")

      page_doc.css('ul#products dl').each do |product|
        product_data = {}
        product_data['category'] = category_name
        product_data['url'] = product.css('a').first.attr('href')
        product_data['image_url'] = product.css('img').first.attr('src')
        product_data['code'] = product.css('dd')[0].css('a').first.text
        product_data['name'] = product.css('dd')[1].css('a').first.text
        if product_data['code'].empty?
          product_data['code'] = product_data['name'].split(' ').last
        end
        product_data['name'] = product_data['name'].gsub(" #{product_data['code']}", '').strip
        product_data['scale'] = product.css('dd')[2].css('a').first.text.gsub('/', ':')
        STDERR.puts "[Load #{category_name} Products][#{Time.now}] #{product_data['code']} #{product_data['scale']} #{product_data['name']}"
        catalog.products[product_data['code']] = product_data
      end
    end
    STDERR.puts "[Load #{category_name} Products][#{Time.now}] loaded"
  end

  def load_products
    if catalog.products.empty?
      CATEGORY_NAMES.each do |category_name|
        load_product_category(category_name)
      end
    end
     STDERR.puts "[Load Products][#{Time.now}] loaded"
  end

  def load_product_images
    catalog.products.keys.each do |code|
      product_data = catalog.products[code]
      image_url = product_data['image_url']
      filename = catalog.image_path(code, image_url)
      STDERR.puts "[Load Product Image][#{Time.now}] loading #{filename} with a #{BACKOFF_SECONDS} second grace period delay"

      unless File.exists?(filename)
        open(filename, 'wb') do |file|
          file << URI.open(URI.parse(BASE_URL + image_url)).read
        end
        sleep BACKOFF_SECONDS
      end
    end
  end

  def get_page(relative_url, message: nil)
    url = BASE_URL + relative_url
    STDERR.puts "[#{message}][#{Time.now}] loading #{url} with a #{BACKOFF_SECONDS} second grace period delay"
    html = URI.open(URI.parse(url))
    result = Nokogiri::HTML(html)
    sleep BACKOFF_SECONDS
    result
  end

  def product_metadata
    result = {}
    result['products_url'] = index_doc.css('.solidblockmenu').css('a').detect { |a| a.text == 'Product' }.attr('href')
    product_doc = get_page(result['products_url'], message: 'GET main product page')

    CATEGORY_NAMES.each do |category_name|
      url = product_doc.css('ul.menu h4').css('a').detect { |a| a.text == category_name }.attr('href')
      category_doc = get_page(url, message: "GET #{category_name} product page")
      last_page_url = category_doc.css('.pages a').last.attr('href') rescue nil
      pages = last_page_url ? last_page_url.split('p=').last.to_i : 1
      result[category_name] = {
        'url' => url,
        'last_page_url' => last_page_url,
        'pages' => pages
      }
    end
    result
  end

  def index_doc
    @index_doc ||= get_page(INDEX_URL, message: 'GET main page (en)')
  end
end

scraper = Scraper.new
scraper.load_product_metadata
scraper.load_products
scraper.load_product_images
scraper.save

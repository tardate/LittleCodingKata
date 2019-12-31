require 'sinatra'
require 'rss'
require 'id3tag'
require 'pathname'

set :bind, '0.0.0.0'
set :server, 'thin'
set :logging, true

helpers do
  def h(text)
    Rack::Utils.escape_html(text)
  end
  def u(text)
    URI.escape(text)
  end
end

set :pod_root, File.expand_path(ENV['POD_ROOT'] || './sample_data')

# Recurse through folders, returning the folders that contain mp3 files
def get_folders(folder, memo = [])
  if  Dir[folder.join('*.mp3')].size > 0
    memo << folder
  else
    folder.children.each do |sub_folder|
      get_folders(sub_folder, memo) if sub_folder.directory?
    end
  end
  memo
end

# Return an array of POD folders
def get_pod_folders
  get_folders(Pathname.new(settings.pod_root)).map do |folder|
    folder.to_s.gsub(settings.pod_root, '')
  end.sort
end

# Return enclosure content
# Note: this is scarily hackable - possible to download any file from any disk
get /\/content\/(.+)/ do
  file_partial = params['captures'].first
  source_file = File.join(settings.pod_root, file_partial)
  content_type 'audio/mpeg'
  File.read(source_file)
end

# Return the requested feed
get /\/feed\/(.+).xml/ do
  feed_path = params['captures'].first
  source_files = File.join(settings.pod_root, feed_path, "*.mp3")

  rss = RSS::Maker.make("rss2.0") do |maker|
    maker.channel.updated = Time.now.to_s
    maker.channel.link = request.base_url
    maker.channel.itunes_explicit = false

    Dir[source_files].each do |filename|
      mp3_file = File.open(filename, 'rb')
      file_tags = ID3Tag.read(mp3_file)

      unless maker.channel.title
        maker.channel.title = "PPF: #{file_tags.album || feed_path}"
        maker.channel.itunes_author = file_tags.artist || "Unknown Author"
        maker.channel.description = file_tags.album || "Unknown Description"
      end

      maker.items.new_item do |item|
        item.link = request.base_url
        item.title = file_tags.title

        item.updated = mp3_file.mtime

        item.guid.isPermaLink = "false"
        item.guid.content = URI.escape "#{file_tags.title}-#{mp3_file.ctime.to_i}"

        item.enclosure.url = URI.escape(request.base_url + '/content' + mp3_file.path.gsub(settings.pod_root, ''))
        item.enclosure.length = mp3_file.size
        item.enclosure.type = 'audio/mpeg'
      end
    end
  end
  content_type 'application/rss+xml'
  rss.to_s
end

# the main page lists the available Pod feeds
get '/*' do
  @feeds = get_pod_folders
  erb :index
end

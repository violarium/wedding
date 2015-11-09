require 'timeout'
require 'logger'
require_relative 'parse_config'
require_relative 'data_getter'
require_relative 'date_finder'

logger = Logger.new(File.expand_path('../work.log', File.dirname(__FILE__)), 'monthly')

begin

  content = Timeout::timeout(60) do
    data_getter = DataGetter.new(CONFIG_DATA['username'], CONFIG_DATA['password'])
    #data_getter = DataGetter::Dummy.new(File.expand_path('../fixtures/content.html', File.dirname(__FILE__)))
    data_getter.get_data
  end

  date_finder = DateFinder.new(content)
  found = date_finder.find(CONFIG_DATA['date'])

  if found
    puts "Дата #{CONFIG_DATA['date']} доступна!"
  end

  logger.info(found.to_s)

rescue => err
  logger.fatal(err)
  raise err
end

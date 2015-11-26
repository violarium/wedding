require_relative 'setup_capybara'

# Class to get data.
class DataGetter
  URL = 'http://www.gosuslugi71.ru/?OnlineService=9041&Order'

  def initialize(username, password)
    @username = username
    @password = password
  end

  def get_data
    browser = Capybara.current_session
    browser.visit URL

    browser.fill_in 'mobileOrEmail', with: CONFIG_DATA['username']
    browser.fill_in 'password', with: CONFIG_DATA['password']
    browser.click_on 'Войти'

    browser.click_on 'Далее'

    while browser.all('#ZagsList option').length == 0
      sleep 1
    end

    browser.select 'комитет записи актов гражданского состояния администрации города Тулы', from: 'ZagsList'

    while browser.all('#ZagsDayMM option').length == 0
      sleep 1
    end

    browser.body
  end


  # Dummy class to get data (for testing and development).
  class Dummy
    def initialize(file)
      @file = file
    end

    def get_data
      File.read(@file)
    end
  end
end

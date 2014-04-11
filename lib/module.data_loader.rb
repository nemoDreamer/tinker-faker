module DataLoader
  class << self

      DATA_PATH = File.dirname(__FILE__) + '/data/'
      DATA_EXT = '.txt'

    def get_data file_name, sep=/\s+/
      read_data(file_name).split(sep)
    end

    def get_data_lines file_name
      File.readlines(DATA_PATH + file_name + DATA_EXT).compact.map { |item| item.strip }
    end

    def read_data file_name
      File.read(DATA_PATH + file_name + DATA_EXT).strip
    end

  end
end

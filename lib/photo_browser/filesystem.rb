module PhotoBrowser
  class Filesystem
    BASE_PATH = 'public/photos'

    def self.years
      @years ||= Dir["#{BASE_PATH}/*"].select {|f| File.directory?(f) && File.basename(f) =~ /\A\d+\Z/ }.map {|f| File.basename f }
    end


    def self.months(year)
      raise InvalidYearError, "#{year} is invalid" unless File.directory? "#{BASE_PATH}/#{year}"
        
      Dir["#{BASE_PATH}/#{year}/*"].select {|f| File.directory?(f) }.map {|f| File.basename f }
    end

    def self.photos(year, month)
      raise InvalidYearError, "#{year} is invalid" unless File.directory? "#{BASE_PATH}/#{year}"
      raise InvalidMonthError, "#{month} is invalid" unless File.directory? "#{BASE_PATH}/#{year}/#{month}"

      Dir["#{BASE_PATH}/#{year}/#{month}/*"].select {|f| File.file? f }.map {|f| File.basename f }
    end

    def self.photo(year, month, photo)
      raise InvalidYearError, "#{year} is invalid" unless File.directory? "#{BASE_PATH}/#{year}"
      raise InvalidMonthError, "#{month} is invalid" unless File.directory? "#{BASE_PATH}/#{year}/#{month}"
      raise InvalidPhotoError, "#{photo} is invalid" unless File.file? "#{BASE_PATH}/#{year}/#{month}/#{photo}"

      photo
    end

  end

  class InvalidYearError < Exception ; end
  class InvalidMonthError < Exception ; end
  class InvalidPhotoError < Exception ; end
end

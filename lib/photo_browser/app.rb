module PhotoBrowser

  class App < Sinatra::Base

    set :views, File.expand_path('../../../views', __FILE__)
    set :public, File.expand_path('../../../public', __FILE__)

    set :logging, true
    set :dump_errors, false
    set :show_exceptions, false
    set :raise_errors, false
  
    error do
      erb :error
    end

    get '/' do
      @years = PhotoBrowser::Filesystem.years
      erb :years
    end

    get '/:year' do
      @year = params[:year]
      @months = PhotoBrowser::Filesystem.months params[:year]
      erb :months
    end

    get '/:year/:month' do
      @year = params[:year]
      @month = params[:month]
      @photos = PhotoBrowser::Filesystem.photos params[:year], params[:month]
      erb :photos
    end

    get '/:year/:month/:photo' do
      @year = params[:year]
      @month = params[:month]
      @photo = PhotoBrowser::Filesystem.photo params[:year], params[:month], params[:photo]
      @photo_path = "/photos/#{@year}/#{@month}/#{@photo}"
      erb :photo
    end

  end

end

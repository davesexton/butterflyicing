class ApplicationController < ActionController::Base
  before_filter :authorize
  protect_from_forgery

  protected

  def authorize
    unless User.find_by_id(session[:user_id])
      session[:original_target] = request.url # unless request.url =~ /admin/

      if User.count.zero?
        user = User.create(:name => params[:name],
                            :password => params[:password],
                            :password_confirmation => params[:password])
      end
      redirect_to login_url, notice: 'Please log in'
    end
  end

  private

  def get_gallery_categories
    path = './app/assets/images/gallery/**'
    Hash[*Dir[path].sort.collect do |d|
      x = d.match('\w+$')[0]
      [x.capitalize, "/gallery/#{x}"]
    end.flatten]
  end

  def make_thumb path
    require 'RMagick'
    thumb = path.sub('gallery', 'gallery_thumbnail')
    img = Magick::Image::read(path).first
    img = img.crop_resized!(75, 75, Magick::NorthGravity)
    #img = img.thumbnail(0.36)
    img.write(thumb)
  end

end

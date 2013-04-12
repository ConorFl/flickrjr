enable :sessions

require 'carrierwave'
require 'mini_magick'

get '/' do
  # Look in app/views/index.erb
  erb :index
end

get '/register' do
  erb :register
end

post '/register' do
  @user = User.create(name: params[:name], email: params[:email], password: params[:password])
  erb :login
end

get '/login' do
  erb :login
end

post '/login' do
  @user = User.find_by_email(params[:email])
  if @user && @user.password == params[:password]
    session[:current_user_id] = @user.id
    redirect '/'
  else
    @message = "Invalid login."
    erb :login
  end
end

get '/logout' do
  session.clear
  redirect '/'
end

get '/gallery/new' do
  erb :new_gallery
end

post '/gallery/new' do
  @new_gallery = Gallery.create(name: params[:name])
  @gallery_id = @new_gallery.id
  User.find(session[:current_user_id]).galleries << @new_gallery
  erb :gallery_view
end

post '/upload' do
  @gallery_id = params[:gallery_id]
  photo = Photo.new(file: params[:myfile])
  photo.save
  Gallery.find(@gallery_id).photos << photo
  @photos = Photo.where('gallery_id = ?', @gallery_id)
  erb :gallery_view
end

get '/galleries/:id' do
  @gallery_id = params[:id]
  @photos = Photo.where("gallery_id = ?", @gallery_id)
  erb :gallery_view
end

get '/user/:user_id/galleries' do
  @user_id = params[:user_id]
  erb :user_page
end

get '/galleries/:gallery_id/:photo_id' do
  @photo_id = params[:photo_id]
  erb :photo
end

  # @original = 'uploads/originals/' + params['myfile'][:filename]
  # @short = "uploads/thumbnails/"+params['myfile'][:filename]
  # @photo = Photo.create(original_path: @original, thumbnail_path: @short)
 

  # image = MiniMagick::Image.open(@original)
  # image.resize "400x400"
  # image.write @short










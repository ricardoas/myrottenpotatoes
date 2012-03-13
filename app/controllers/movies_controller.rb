class MoviesController < ApplicationController

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    @all_ratings=Hash.new
    @checked=params[:ratings]
    Movie.all_ratings.each {|rating| @all_ratings[rating]=false }
    if ! @checked.nil?
      condition = ["rating IN (?)", @checked.keys]
      @all_ratings.merge!(@checked) {|key, oldval, newval| true}
    else
      condition = []
    end
    if params[:sort] == "title"
      @movies = Movie.all :order => "title ASC", :conditions => condition
      @hilitetitle=true
    elsif params[:sort] == "release_date"
      @movies = Movie.all :order => "release_date ASC", :conditions => condition
      @hilitetitle=false
    else
      @movies = Movie.all :conditions => condition
    end
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

end

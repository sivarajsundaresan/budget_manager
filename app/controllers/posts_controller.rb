class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]

 # GET /posts
  # GET /posts.json
  def index
    @posts = Post.all
   render :json => @posts
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    respond_to do |format|
      if @post.present?
        format.json { render json: @post }
      else
        msg = { :status => 'error', message: 'Records Not Found'}
        format.json { render json: msg }
      end
    end
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(post_params)

    respond_to do |format|
      if @post.save
        format.json { render :json => @post }
      else
        format.json { render json: @post.errors, status: 401 }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.json { render :json => @post }
      else
        format.json { render json: @post.errors, status: 401 }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      msg = { :status => 'ok', message: 'Deleted Successfully'}
      format.json { render json: msg }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find_by(id: params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.permit(:name, :description)
    end
end

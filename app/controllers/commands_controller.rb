class CommandsController < ApplicationController
  before_action :set_command, only: [:show, :edit, :update, :destroy]

  # GET /commands
  # GET /commands.json
  def index
    @commands = Command.all
    render :json => @commands
  end

  # GET /commands/1
  # GET /commands/1.json
  def show
    respond_to do |format|
      if @command.present?
        format.json { render json: @command }
      else
        msg = { :status => 'error', message: 'Records Not Found'}
        format.json { render json: msg }
      end
    end
  end

  # GET /commands/new
  def new
    @command = Command.new
  end

  # GET /commands/1/edit
  def edit
  end

  # POST /commands
  # POST /commands.json
  def create
    @command = Command.new(command_params)

    respond_to do |format|
      if @command.save
        format.json { render json: @command }
      else
        format.json { render json: @command.errors, status: 401 }
      end
    end
  end

  # PATCH/PUT /commands/1
  # PATCH/PUT /commands/1.json
  def update
    respond_to do |format|
      if @command.update(command_params)
        format.json { render :json => @command }
      else
        format.json { render json: @command.errors, status: 401 }
      end
    end
  end

  # DELETE /commands/1
  # DELETE /commands/1.json
  def destroy
    @command.destroy
    respond_to do |format|
      msg = { :status => 'ok', message: 'Deleted Successfully'}
      format.json { render json: msg }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_command
      @command = Command.find_by(id: params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def command_params
      params.permit(:command_name, :post_id)
    end
end

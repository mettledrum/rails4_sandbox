class DancersController < ApplicationController
  before_action :set_dancer, only: [:show, :edit, :update, :destroy]

  # GET /dancers
  # GET /dancers.json
  def index
    @dancers = Dancer.all
  end

  # GET /dancers/1
  # GET /dancers/1.json
  def show
  end

  # GET /dancers/new
  def new
    @dancer = Dancer.new
  end

  # GET /dancers/1/edit
  def edit
  end

  # POST /dancers
  # POST /dancers.json
  def create
    @dancer = Dancer.new(dancer_params)

    respond_to do |format|
      if @dancer.save
        format.html { redirect_to @dancer, notice: 'Dancer was successfully created.' }
        format.json { render action: 'show', status: :created, location: @dancer }
      else
        format.html { render action: 'new' }
        format.json { render json: @dancer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /dancers/1
  # PATCH/PUT /dancers/1.json
  def update
    respond_to do |format|
      if @dancer.update(dancer_params)
        format.html { redirect_to @dancer, notice: 'Dancer was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @dancer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /dancers/1
  # DELETE /dancers/1.json
  def destroy
    @dancer.destroy
    respond_to do |format|
      format.html { redirect_to dancers_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_dancer
      @dancer = Dancer.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def dancer_params
      params.require(:dancer).permit(:name)
    end
end

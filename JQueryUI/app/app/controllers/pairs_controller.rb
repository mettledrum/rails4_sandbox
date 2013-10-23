class PairsController < ApplicationController
  before_action :set_pair, only: [:show, :edit, :update, :destroy]

  # GET /pairs
  # GET /pairs.json
  def index
    @pairs = Pair.all
    # now we can look at dancers' info too
    @dancers = Dancer.all
  end

  # GET /pairs/1
  # GET /pairs/1.json
  def show
  end

  # GET /pairs/new
  def new
    @pair = Pair.new
  end

  # GET /pairs/1/edit
  def edit
  end

  # POST /pairs
  # POST /pairs.json
  def create
    @pair = Pair.new(pair_params)

    respond_to do |format|
      if @pair.save
        format.html { redirect_to @pair, notice: 'Pair was successfully created.' }
        format.json { render action: 'show', status: :created, location: @pair }
      else
        format.html { render action: 'new' }
        format.json { render json: @pair.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pairs/1
  # PATCH/PUT /pairs/1.json
  def update
    respond_to do |format|
      if @pair.update(pair_params)
        format.html { redirect_to @pair, notice: 'Pair was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @pair.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pairs/1
  # DELETE /pairs/1.json
  def destroy
    @pair.destroy
    respond_to do |format|
      format.html { redirect_to pairs_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pair
      @pair = Pair.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def pair_params
      params.require(:pair).permit(:dancer1_id, :dancer2_id)
    end
end

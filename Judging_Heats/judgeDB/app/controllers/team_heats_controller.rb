class TeamHeatsController < ApplicationController
  before_action :set_team_heat, only: [:show, :edit, :update, :destroy]

  # GET /team_heats
  # GET /team_heats.json
  def index
    # NOTE: for Team search given_number
    @teams = Team.all

    # ransack searching for team_heats
    @q = TeamHeat.search(params[:q])
    @team_heats = @q.result()
  end

  # GET /team_heats/1
  # GET /team_heats/1.json
  def show
  end

  # GET /team_heats/new
  def new
    @team_heat = TeamHeat.new
  end

  # GET /team_heats/1/edit
  def edit
  end

  # POST /team_heats
  # POST /team_heats.json
  def create
    @team_heat = TeamHeat.new(team_heat_params)

    respond_to do |format|
      if @team_heat.save
        format.html { redirect_to @team_heat, notice: 'Team heat was successfully created.' }
        format.json { render action: 'show', status: :created, location: @team_heat }
      else
        format.html { render action: 'new' }
        format.json { render json: @team_heat.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /team_heats/1
  # PATCH/PUT /team_heats/1.json
  def update
    respond_to do |format|
      if @team_heat.update(team_heat_params)
        format.html { redirect_to @team_heat, notice: 'Team heat was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @team_heat.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /team_heats/1
  # DELETE /team_heats/1.json
  def destroy
    @team_heat.destroy
    respond_to do |format|
      format.html { redirect_to team_heats_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_team_heat
      @team_heat = TeamHeat.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def team_heat_params
      params.require(:team_heat).permit(:team_id, :heat_id, :judge_id, :score)
    end
end

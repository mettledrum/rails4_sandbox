class DancerTeamsController < ApplicationController
  before_action :set_dancer_team, only: [:show, :edit, :update, :destroy]

  # GET /dancer_teams
  # GET /dancer_teams.json
  def index
    @dancer_teams = DancerTeam.all
  end

  # GET /dancer_teams/1
  # GET /dancer_teams/1.json
  def show
  end

  # GET /dancer_teams/new
  def new
    @dancer_team = DancerTeam.new
  end

  # GET /dancer_teams/1/edit
  def edit
  end

  # POST /dancer_teams
  # POST /dancer_teams.json
  def create
    @dancer_team = DancerTeam.new(dancer_team_params)

    respond_to do |format|
      if @dancer_team.save
        format.html { redirect_to @dancer_team, notice: 'Dancer team was successfully created.' }
        format.json { render action: 'show', status: :created, location: @dancer_team }
      else
        format.html { render action: 'new' }
        format.json { render json: @dancer_team.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /dancer_teams/1
  # PATCH/PUT /dancer_teams/1.json
  def update
    respond_to do |format|
      if @dancer_team.update(dancer_team_params)
        format.html { redirect_to @dancer_team, notice: 'Dancer team was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @dancer_team.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /dancer_teams/1
  # DELETE /dancer_teams/1.json
  def destroy
    @dancer_team.destroy
    respond_to do |format|
      format.html { redirect_to dancer_teams_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_dancer_team
      @dancer_team = DancerTeam.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def dancer_team_params
      params.require(:dancer_team).permit(:team_id, :dancer_id)
    end
end

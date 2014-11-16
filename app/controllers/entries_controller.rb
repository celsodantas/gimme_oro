class EntriesController < ApplicationController
  before_action :set_entry, only: [:show, :edit, :update, :destroy]
  before_action :set_date, only: [:index]

  # GET /entries
  # GET /entries.json
  def index
    @entries = current_user.entries.for_month(@date)
    @budgets = current_user.budgets
  end

  # GET /entries/1
  # GET /entries/1.json
  def show
  end

  # GET /entries/new
  def new
    @entry = current_user.entries.build
    @budgets = current_user.budgets
  end

  # GET /entries/1/edit
  def edit
    @budgets = current_user.budgets
  end

  # POST /entries
  # POST /entries.json
  def create
    @entry = current_user.entries.build(entry_params)

    respond_to do |format|
      if @entry.save
        format.html { redirect_to entries_path, notice: 'Entry was successfully created.' }
        format.json { render action: 'show', status: :created, location: @entry }
      else
        format.html { render action: 'new' }
        format.json { render json: @entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /entries/1
  # PATCH/PUT /entries/1.json
  def update
    respond_to do |format|
      if @entry.update(entry_params)
        format.html { redirect_to entries_path, notice: 'Entry was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /entries/1
  # DELETE /entries/1.json
  def destroy
    @entry.destroy
    respond_to do |format|
      format.html { redirect_to entries_url }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_entry
    @entry = current_user.entries.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def entry_params
    if params[:entry][:budgets_list]
      budgets_list = params[:entry][:budgets_list].split(",")
      budgets = Budget.where(description: budgets_list)
      params[:entry][:budget_ids] = budgets.map(&:id)

      params[:entry].delete(:budgets_list)
    end

    params.require(:entry).permit!
  end

  def set_date
    if params[:date]
      @date = Date.parse(params[:date])
    else
      @date = Date.today
    end
  end
end

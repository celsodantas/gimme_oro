class BudgetsController < ApplicationController
  before_action :set_budget, only: [:show, :edit, :update, :destroy]

  # GET /budgets
  # GET /budgets.json
  def index
    @budgets = current_user.budgets
  end

  # GET /budgets/1
  # GET /budgets/1.json
  def show
    @date = Date.parse(params[:date])
    @entries = @budget.entries.for_month(@date)
  end

  # GET /budgets/new
  def new
    @budget = current_user.budgets.build
  end

  # GET /budgets/1/edit
  def edit
  end

  # POST /budgets
  # POST /budgets.json
  def create
    @budget = current_user.budgets.build(budget_params)

    respond_to do |format|
      if @budget.save
        format.html { redirect_to budgets_path, notice: 'Budget was successfully created.' }
        format.json { render action: 'show', status: :created, location: @budget }
      else
        format.html { render action: 'new' }
        format.json { render json: @budget.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /budgets/1
  # PATCH/PUT /budgets/1.json
  def update
    respond_to do |format|
      if @budget.update(budget_params)
        format.html { redirect_to budgets_path, notice: 'Budget was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @budget.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /budgets/1
  # DELETE /budgets/1.json
  def destroy
    @budget.destroy
    respond_to do |format|
      format.html { redirect_to budgets_url }
      format.json { head :no_content }
    end
  end

  def autocomplete
    term = params[:term]
    list = Budget.all.map {|b| b.description }.select{|e| e.downcase.include? term.downcase}

    respond_to do |format|
      format.json { render json: list }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_budget
      @budget =  current_user.budgets.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def budget_params
      params.require(:budget).permit(:description, :amount)
    end
end

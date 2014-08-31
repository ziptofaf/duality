class SpecialAccountsController < ApplicationController
  before_action :set_special_account, only: [:show, :edit, :update, :destroy]
  before_action :admin_authorize
  # GET /special_accounts
  # GET /special_accounts.json
  def index
    @special_accounts = SpecialAccount.all
  end

  # GET /special_accounts/1
  # GET /special_accounts/1.json
  def show
  end

  # GET /special_accounts/new
  def new
    @special_account = SpecialAccount.new
  end

  # GET /special_accounts/1/edit
  def edit
  end

  # POST /special_accounts
  # POST /special_accounts.json
  def create
    @special_account = SpecialAccount.new(special_account_params)

    respond_to do |format|
      if @special_account.save
        format.html { redirect_to @special_account, notice: 'Special account was successfully created.' }
        format.json { render :show, status: :created, location: @special_account }
      else
        format.html { render :new }
        format.json { render json: @special_account.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /special_accounts/1
  # PATCH/PUT /special_accounts/1.json
  def update
    respond_to do |format|
      if @special_account.update(special_account_params)
        format.html { redirect_to @special_account, notice: 'Special account was successfully updated.' }
        format.json { render :show, status: :ok, location: @special_account }
      else
        format.html { render :edit }
        format.json { render json: @special_account.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /special_accounts/1
  # DELETE /special_accounts/1.json
  def destroy
    @special_account.destroy
    respond_to do |format|
      format.html { redirect_to special_accounts_url, notice: 'Special account was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_special_account
      @special_account = SpecialAccount.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def special_account_params
      params.require(:special_account).permit(:login, :password, :account_id, :device, :user_id)
    end
end

class ExternalSubscriptionsController < ApplicationController
  before_action :set_external_subscription, only: [:show, :edit, :update, :destroy]

  # GET /external_subscriptions
  # GET /external_subscriptions.json
  def index
    @external_subscriptions = ExternalSubscription.all
  end

  # GET /external_subscriptions/1
  # GET /external_subscriptions/1.json
  def show
  end

  # GET /external_subscriptions/new
  def new
    @external_subscription = ExternalSubscription.new
  end

  # GET /external_subscriptions/1/edit
  def edit
  end

  # POST /external_subscriptions
  # POST /external_subscriptions.json
  def create
    @external_subscription = ExternalSubscription.new(external_subscription_params)

    respond_to do |format|
      if @external_subscription.save
        format.html { redirect_to @external_subscription, notice: 'External subscription was successfully created.' }
        format.json { render :show, status: :created, location: @external_subscription }
      else
        format.html { render :new }
        format.json { render json: @external_subscription.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /external_subscriptions/1
  # PATCH/PUT /external_subscriptions/1.json
  def update
    respond_to do |format|
      if @external_subscription.update(external_subscription_params)
        format.html { redirect_to @external_subscription, notice: 'External subscription was successfully updated.' }
        format.json { render :show, status: :ok, location: @external_subscription }
      else
        format.html { render :edit }
        format.json { render json: @external_subscription.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /external_subscriptions/1
  # DELETE /external_subscriptions/1.json
  def destroy
    @external_subscription.destroy
    respond_to do |format|
      format.html { redirect_to external_subscriptions_url, notice: 'External subscription was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_external_subscription
      @external_subscription = ExternalSubscription.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def external_subscription_params
      params.require(:external_subscription).permit(:project_id, :investor_id)
    end
end

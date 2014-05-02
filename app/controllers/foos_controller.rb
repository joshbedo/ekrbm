class FoosController < ApplicationController
  before_action :set_foo, only: [:show, :edit, :destroy, :update]

  # GET /foos
  def index
    @foos = Foo.all
    render json: @foos
  end

  # GET /foos/1
  def show
    render json: @foo
  end

  # GET /foos/new
  def new
    @foo = Foo.new
  end

  # GET /foos/1/edit
  def edit
  end

  # POST /foos
  def create
    @foo = Foo.new(foo_params)
    @foo.save!
    render json: @foo
  end

  # PATCH/PUT /foos/1
  def update
    if @foo.update!(foo_params)
      render json: @foo
    end
  end

  # DELETE /foos/1
  def destroy
    @foo.destroy
    render json: {success: true}
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_foo
      @foo = Foo.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def foo_params
      params.require(:foo).permit(:bar, :id, :priority)
    end
end

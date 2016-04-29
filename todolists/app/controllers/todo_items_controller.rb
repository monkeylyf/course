class TodoItemsController < ApplicationController
  before_action :set_todo_item, only: [:show, :edit, :update, :destroy]
  before_action :set_todo_list, only: [:show, :new, :edit, :create, :update, :destroy]

  def show
  end

  def new
    @todo_item = @todo_list.todo_items.new
  end

  def edit
  end

  def create
    @todo_item = @todo_list.todo_items.new(todo_item_params)

    if @todo_list.save
      redirect_to @todo_list, notice: 'Todo item was successfully created.'
    else
      redirect_to @todo_list, alert: 'Failed to create Todo item.'
    end

    #respond_to do |format|
    #  if @todo_list.save
    #    format.html { redirect_to @todo_item, notice: 'Todo item was successfully created.' }
    #    format.json { render :show, status: :created, location: @todo_item }
    #  else
    #    format.html { render :new }
    #    format.json { render json: @todo_item.errors, status: :unprocessable_entity }
    #  end
    #end
  end

  def update
    if @todo_item.update(todo_item_params)
      redirect_to @todo_list, notice: 'Todo item was successfully updated.'
    else
      redirect_to @todo_list, alert: 'Failed to update Todo item!'
    end
    #respond_to do |format|
    #  if @todo_item.update(todo_item_params)
    #    format.html { redirect_to @todo_item, notice: 'Todo item was successfully updated.' }
    #    format.json { render :show, status: :ok, location: @todo_item }
    #  else
    #    format.html { render :edit }
    #    format.json { render json: @todo_item.errors, status: :unprocessable_entity }
    #  end
    #end
  end

  def destroy
    @todo_item.destroy

    redirect_to @todo_list, notice: 'Todo item was successfully destroyed.'
    #@todo_item.destroy
    #respond_to do |format|
    #  format.html { redirect_to todo_items_url, notice: 'Todo item was successfully destroyed.' }
    #  format.json { head :no_content }
    #end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_todo_item
      todo_list = TodoList.find(params[:todo_list_id])
      @todo_item = todo_list.todo_items.find(params[:id])
    end

    def set_todo_list
      @todo_list = TodoList.find(params[:todo_list_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def todo_item_params
      params.require(:todo_item).permit(:title, :due_date, :description, :completed)
    end
end


class Api::TodosController < ApplicationController

  def create
    @todo = Todo.new(todo_params)
    if @todo.save
      Pusher.trigger(
      "presence-project_#{@todo.project.id}",
      "update_todos",
      {action: "CREATE_TODO", todo_id: @todo.id}
       )
      render :show
    else
      render @todo.errors.full_messages, status: 400
    end
  end

  def index
    @todos = Project.find(params[:project_id]).todos
    render :index
  end

  def update
    @todo = Todo.find(todo_params[:id])
    if @todo.update(todo_params)
      Pusher.trigger(
      "presence-project_#{@todo.project.id}",
      "update_todos",
      {action: "UPDATE_TODO", todo_id: @todo.id}
       )
      render json: @todo
    else
      render json: ["Something went wrong"], status: 400
    end
  end

  def destroy
    @todo = Todo.find(params[:id])
    @todo.destroy
    Pusher.trigger(
    "presence-project_#{@todo.project.id}",
    "update_todos",
    {action: "DESTROY_TODO", todo_list_id: @todo.todo_list_id, todo_id: @todo.id}
     )
    render :show
  end

  def show
    @todo = Todo.find(params[:id])
    if @todo
      render :show
    else
      render json: ["To-do not found"]
    end
  end


  def todo_params
    params.require(:todos).permit(:title, :body, :todo_list_id, :author_id, :assign_to_id, :completion, :id)
  end

end

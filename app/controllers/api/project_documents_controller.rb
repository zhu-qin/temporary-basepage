class Api::ProjectDocumentsController < ApplicationController

  def create
    @project_document = ProjectDocument.new(doc_params)
    if @project_document.save
      render json: @project_document
    else
      render json: @project_document.errors.full_messages
    end
  end

  def index
    @project_documents = Project.find(params[:project_id]).project_documents
    render :index
  end

  def doc_params
    params.require(:project_documents).permit(:title, :body, :project_id)
  end

end
class DirectoriesController < ApplicationController
  def create
    directory = Directory.new(directory_params)

    if directory.save
      render json: directory, status: :created
    else
      render json: { errors: directory.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def show
    directory = Directory.find(params[:id])

    render json: {
      id: directory.id,
      name: directory.name,
      parent_id: directory.parent_id,
      subdirectories: directory.subdirectories.select(:id, :name),
      stored_files: directory.stored_files.select(:id, :name)
    }
  end

  private

  def directory_params
    params.require(:directory).permit(:name, :parent_id)
  end
end

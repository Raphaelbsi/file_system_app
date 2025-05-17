class StoredFilesController < ApplicationController
  def create
    stored_file = StoredFile.new(stored_file_params)

    if stored_file.save
      render json: stored_file, status: :created
    else
      render json: { errors: stored_file.errors.full_messages }, status: :unprocessable_entity
    end
  rescue => e
    puts "ERRO AO SALVAR STORED FILE: #{e.message}"
    puts e.backtrace.join("\n")
    Rails.logger.error(e.backtrace.join("\n"))
    render json: { error: "Erro interno: #{e.message}" }, status: :internal_server_error
  end

  private

  def stored_file_params
    params.require(:stored_file).permit(:name, :directory_id, :file)
  end
end

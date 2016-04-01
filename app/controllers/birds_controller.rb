class BirdsController < ApplicationController

  skip_before_filter :verify_authenticity_token 
  before_filter :validate_json, only: :create
  before_filter :validate_id, only: [:show, :destroy]

  def index
    output = Bird.all.only(:id, :name, :family, :continents, :visible, :added).collect {|bird| {'id': bird.id, 'name': bird.name, 'family': bird.family, 'continents': bird.continents, 'visible': bird.visible, 'added': bird.added}}
    render json: {"message": 'success', 'data': output}, status: :ok
  end

  def create
    inputs = params['bird']
    begin
      Bird.create!(inputs.symbolize_keys)  
    rescue StandardError => e
      render json: {"message": 'error'}, status: 400
    else
      render json: {"message": "success"}, status: :ok
    end  
  end

  def show
    bird = Bird.find(params['id'].to_i)
    if !bird.visible
      render json: {"message": "success"}, status: 200 
    else
      render json: {'id': bird.id, 'name': bird.name, 'family': bird.family, 'continents': bird.continents, 'visible': bird.visible, 'added': bird.added}
    end
  end

  def destroy
    Bird.find(params['id'].to_i).delete
    render nothing: true, status: :ok
  end


  def validate_id
    begin
      Bird.find(params['id'].to_i)
    rescue StandardError => e
      render json: {"message": "not found"}, status: 404
    end
  end

  def validate_json
    json_schema_path = Rails.root.join('config', 'schemas', 'post-bird-request.json').to_s
    if JSON::Validator.validate(json_schema_path, params['bird'].to_json)
      return false
    else
      render json: {"message": "validation failed"}, :status => 400
    end
  end
end

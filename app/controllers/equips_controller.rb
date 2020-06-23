class EquipsController < ApplicationController

  # before do
  #   login_required
  # end

  get '/equips' do
    login_required
      @equips = current_user.equips.all
      erb :"/equips/index"
  end

  get '/equips/new' do
    login_required
    @equips = current_user.equips.all
    @teams = current_user.teams.all
    erb :"equips/new"
  end

  post '/equips' do
    login_required
    sanitize_input(params[:equip])
    equip = current_user.equips.create(params[:equip])
    # character = current_user.characters.find_or_create_by(params[:character])
    # character.equips << equip
    # character.save
  
    flash[:message] = "Successfully created equip."
    redirect to "/equips/#{equip.id}"
  end

  get '/equips/:id' do
    login_required
    permission_required
    @equip = current_user.equips.find_by_id(params[:id])
    erb :"/equips/show"
  end

  get '/equips/:id/edit' do
    login_required
    permission_required
    @equip = current_user.equips.find_by_id(params[:id])
    @teams = current_user.teams.all
    erb :"/equips/edit"
  end 

  patch '/equips/:id' do 
    login_required
    permission_required
    sanitize_input(params[:equip])
    equip = current_user.equips.find_by_id(params[:id])
    equip.update(params[:equip])

    @characters = current_user.characters.find_or_create_by(params[:character])
    # if !params[:equip].empty?
    #     @character.equips << equip
    # end

    # flash[:message] = "Successfully updated equip."
    redirect to "/equips/#{equip.id}"
  end



  delete '/equips/:id' do
    login_required
    permission_required
    @equip = current_user.equips.find_by_id(params[:id])
    @equip.destroy
    redirect "equips"
  end 

  private

  def permission_required
    unless @equip = current_user.equips.find_by_id(params[:id])
      flash[:alerts] = ["You don't have permission"]
      redirect to "/equips"
    end 
  end


end
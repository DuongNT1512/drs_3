class Admin::LanguagesController < ApplicationController
  before_action :find_language, except: [:index, :new]
  before_action :verify_admin
  after_action :verify_authorized

  def index
    @search = language.search params[:q]
    @languages = @search.result.paginate page: params[:page], per_page: Settings.page
    authorize User
  end

  def new
    authorize User
    authorize Language
    @language = language.new
  end

  def create
    authorize current_user
    @language = language.new language_params
    if @language.save
      flash[:success] = t "success"
      redirect_to admin_languages_path
    else
      flash[:danger] = t "fail"
      render :new
    end
    authorize @language
  end

  def edit
    authorize current_user
    authorize @language
  end

  def show
    authorize current_user
    @search = @language.users.search params[:q]
    @users = @search.result.paginate page: params[:page], per_page: Settings.page
    @managers = User.all_manager
  end

  def update
    authorize current_user
    authorize @language
    if @language.update_attributes language_params
      flash.now[:success] = t "success"
    else
      flash[:danger] = t "fail"
    end
    redirect_to admin_languages_path
  end

  def destroy
    authorize @user
    authorize @language
    if @language.destroy
      flash[:success] = t "request.delete"
    else
      flash[:danger] = t "request.delete_fail"
    end
    redirect_to admin_languages_path
  end

  private
  def language_params
    params.require(:language).permit :name
  end

  def find_language
    @language = language.find_by id: params[:id]
    if @language.nil?
      flash[:danger] = t "language.empty"
      redirect_to admin_languages_path
    end
  end
end

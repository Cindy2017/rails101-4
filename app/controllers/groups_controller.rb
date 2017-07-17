class GroupsController < ApplicationController
  before_action :authenticate_user! , only: [:new, :create, :edit, :update, :destroy]
  def index
    @groups = Group.all
  end

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    @group.user = current_user

    if @group.save
      redirect_to groups_path
    else
      render :new
    end
  end

  def show
    @group = Group.find(params[:id])
  end

  def edit
    @group = Group.find(params[:id])

    if current_user != @group.suer
      redirect_to root_path, alert: "抱歉，你没有权限修改。"
    end
  end

  def update
    @group = Group.find(params[:id])

    if current_user != @group.suer
      redirect_to root_path, alert: "抱歉，你没有权限修改。"
    end

    if @group.update(group_params)
      redirect_to groups_path, notice: "修改成功！"
    else
      render :edit
    end
  end

  def destroy
    @group = Group.find(params[:id])

    if current_user != @group.suer
      redirect_to root_path, alert: "抱歉，你没有权限修改。"
    end
    
    @group.destroy
    flash[:alert] = "删除成功！"
    redirect_to groups_path
  end

  def group_params
    params.require(:group).permit(:title, :description)
  end
end

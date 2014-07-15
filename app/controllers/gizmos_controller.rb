class GizmosController < ApplicationController
  # before_filter :authenticate_user!

  def new
    content_type = params[:content_type]
    contentable_id = params[:contentable_id]
    contentable_type = params[:contentable_type]

    @url = "/admin/#{content_type}/new"
    @url += "?#{content_type}[contentable_id]=#{contentable_id}"
    @url += "&#{content_type}[contentable_type]=#{contentable_type}"

    respond_to do |format|
      format.js { render :template => 'gizmos/open_modal' }
    end
  end

  def edit_content
    content = Gizmo.find(params[:id]).content
    content_id = content.id
    content_type = content.class.to_s.underscore

    @url = "/admin/#{content_type}/#{content_id}/edit"
    @url += "?return_to=#{success_gizmos_url}"

    respond_to do |format|
      format.js { render :template => 'gizmos/open_modal' }
    end
  end

  def edit
    gizmo_id = Gizmo.find(params[:id]).pluck(:id)
    @url = "/admin/gizmo/#{gizmo_id}/edit"
    @url += "?return_to=#{success_gizmos_url}"

    respond_to do |format|
      format.js { render :template => 'gizmos/open_modal' }
    end
  end

  def destroy
    content = Gizmo.find(params[:id]).content
    content_id = content.id
    content_type = content.class.to_s.underscore

    @url = "/admin/#{content_type}/#{content_id}/delete";

    respond_to do |format|
      format.js
    end
  end

  def success
    respond_to do |format|
      format.html { render :layout => false }
    end
  end

  def move_up
    gizmo = Gizmo.find params[:id]
    gizmos = gizmo.with_same_contentable

    if gizmos.index(gizmo) > 0
      new_position = gizmos[gizmos.index(gizmo) - 1].position
      gizmos[gizmos.index(gizmo) - 1].update_attribute('position', gizmo.position)
      gizmo.update_attribute(:position, new_position)
    end
    gizmo.resort_siblings!

    redirect_to :back
  end

  def move_down
    gizmo = Gizmo.find params[:id]
    gizmos = gizmo.with_same_contentable

    if gizmos.index(gizmo) < gizmos.size - 1
      new_position = gizmos[gizmos.index(gizmo) + 1].position
      gizmos[gizmos.index(gizmo) + 1].update_attribute('position', gizmo.position)
      gizmo.update_attribute(:position, new_position)
    end
    gizmo.resort_siblings!

    redirect_to :back
  end

  def buttons_toggle
    ## set or unset cookie

    redirect_to :back
  end

end

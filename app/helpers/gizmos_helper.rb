module GizmosHelper

  def print_gizmos(contentable)
    if contentable.present?
      gizmos = get_gizmos(contentable)
      html = ''
      if gizmos.present?
        can_edit = current_user.present? # && current_user.show_row_buttons
        editable_class = can_edit ? 'admin-editable' : ''

        html = "<div class='gizmos-area'>"
        gizmos.each do |gizmo|
          styles = "background-color: ##{gizmo.background_color}" if gizmo.background_color.present?
          inner_html = ''

          if can_edit
            position = []
            if gizmos.size == 1
              position = ['first', 'last']
            elsif gizmo == gizmos.first
              position = ['first']
            elsif gizmo == gizmos.last
              position = ['last']
            end
            inner_html += render "gizmos/buttons", gizmo: gizmo, position: position
          end

          if gizmo.is_yield && @yield_gizmo.present?
            html += content_tag :div, class: ("gizmo-single yield-gizmo #{editable_class} colored"), style: styles do
              if can_edit || !gizmo.offline?
                inner_html += @yield_gizmo
              end
              inner_html.html_safe
            end

          elsif gizmo.content.present?
            content_type = gizmo.content_type.underscore.gsub('widget_','')
            colored = gizmo.background_color.present? ? 'colored' : 'not-colored'
            html += content_tag :div, :class => ("gizmo-single gizmo-#{content_type} #{editable_class} #{colored}"), :style => styles do
              if can_edit || !gizmo.offline?
                inner_html += render "widgets/#{content_type}", :content => gizmo.content, :contentable => contentable
              end
              inner_html.html_safe
            end
          end
        end
        html += "</div>"
      end
      html += "#{add_new_gizmo(contentable)}"
      html.html_safe
    end
  end

  def add_new_gizmo(contentable)
    render('gizmos/add', contentable: contentable) if current_user.present? && contentable.present? # && current_user.show_row_buttons
  end

  def get_gizmos(contentable)
    gizmos = contentable.gizmos.includes(:content).order_by_position
    gizmos = gizmos.online if current_user.blank?
    gizmos
  end

  def gizmo_buttons_toggle
    link_to fa_icon(:eye), buttons_toggle_gizmos_path, title: t('gizmos.gizmo_buttons_toggle'), class: 'admin-tooltip', :'data-no-turbolink' => true
  end

end

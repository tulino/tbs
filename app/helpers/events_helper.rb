module EventsHelper
  def calender_event
    Event.all.map { |a| a }.keep_if { |x| x.event_responses.last.event_status_id == 2 }
  end

  def event_status(event)
    if current_user.present? && current_user.admin?
      "<a href='#'  role='button' data-toggle='modal' data-target='#event-responses-modal' class='label show-event-responses label-#{event.event_responses.last.event_status.label_type}'>#{event.event_responses.last.event_status.status}</a>".html_safe
    elsif event.event_responses.last.event_status_id == 2
      "Onaylandı"
    else
      "İnceleniyor"
    end
  end

  def event_actions(event)
    if current_user.present? && current_user.admin?
      (link_to '<i class="fa fa-eye" title="Göster"></i>'.html_safe, event, :style=>'margin-right: 20px;') +
      (link_to '<i class="fa fa-pencil" title="Düzenle"></i>'.html_safe, edit_event_path(event), :style=>'margin-right: 20px;') +
      (link_to '<i class="fa fa-trash" title="Sil"></i>'.html_safe, event, method: :delete, data: { confirm: 'Etkinliği silmek istediğinize emin misiniz?' })
    end
  end
end

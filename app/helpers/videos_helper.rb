module VideosHelper
  # Indica si es el creador del video
  def is_video_owner? video
    video.user_id == current_user.id
  end

  def link_to_edit_video video
    link_to fa_icon('pencil'), edit_video_path(video), title: 'Editar', class: 'small btn btn-sm'
  end

  def link_to_remove_video video
    link_to fa_icon('trash'), video_path(video), method: :delete, title: 'Borrar', class: 'small btn btn-sm'
  end
end

module ApplicationHelper

  def spinner(class_name='spinner')
    image_tag 'ajax.gif', style: 'width: 14px;', class: class_name
  end

  def user_icon
    raw "<span class='glyphicon glyphicon-user'></span><span class='caret'></span>"
  end
end

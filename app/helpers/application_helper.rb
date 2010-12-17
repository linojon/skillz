module ApplicationHelper
  def body_id(name)
    content_for(:body_id){name}
  end
  
  def odd_even(object)
    { :id => "#{object.class.to_s.downcase}_#{object.id}", :class => "#{cycle('even', 'odd')}" }
  end
  
end

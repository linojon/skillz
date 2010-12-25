class String
  # when used like foo.to_json.with_js lets you surround direct javascript in % chars eg. { :bar => "%new google.map%"}
  def with_js
    self.gsub('"%', '').gsub('%"', '').html_safe
  end
  
end

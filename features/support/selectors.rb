module HtmlSelectorsHelper
  def selector_for(scope)
    case scope
    when /the body/
      "html > body"
    
    else
      begin
        #debugger
        # scope =~ /(?:the )?(.*)/
        # components = $1.split(/\s+/)
        #components.shift if components[0]=='the' #kludge, need regex
        #selector = "//*[@id='#{components.join('_')}']"
        #page.find(:xpath, selector)
        components = scope.gsub('"','').split
        components.shift if components[0]=='the'
        components.pop if ['area','box', 'tab'].include? components[-1]
        selector = "##{components.join('_')}".downcase
        page.find(selector)
        selector
      rescue Object => e
        raise "Can't find mapping from \"#{scope}\" to a selector.\n" +
          "Now, go and add a mapping in #{__FILE__}"
      end
    end
  end
end

World(HtmlSelectorsHelper)
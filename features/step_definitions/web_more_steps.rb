
# Then the list of people should look like:-
#  | Jane    |
#  | John    |
#  | Jordan |
# 
# Then /^the list of people should look like$/ do |expected_table|
#  expected_table.diff!(tableish('table#people tr','td.name'))
# end



When /^(?:|I )follow "([^"]*)" on the row containing "([^"]*)"(?: within "([^"]*)")?$/ do |link, text, scope|
  selector = ".//td[contains(.,'#{text}')]//.."
  with_scope(scope) do
    within( :xpath, selector) do
      click_link(link)
    end
  end
end

# When /^(?:|I )click the ([^"]*)(?: within "([^"]*)")?$/ do |element, scope|
#   # for clicking an element with js .click() on it, or wrapped in an <a> tag
#   with_scope(scope) do
#     find(selector_for(element)).click
#   end
# end

# li.find(:xpath, %{.//*[@class="#{klass}"]}).text

Then /^(?:|I )should see a "([^"]*)" dialog box$/ do |name|
  page.should have_xpath( ".//div[@role='dialog']//div[@id='#{name}']")
end

Then /^(?:|I )should see "([^"]*)" on the row containing "([^"]*)"(?: within "([^"]*)")?$/ do |text1, text, scope|
  selector = ".//td[contains(.,'#{text}')]//.."
  with_scope(scope) do
    within(:xpath, selector) do
      Then %{I should see "#{text1}"}
    end
  end
end

Then /^(?:|I )should see the following data(?: within "([^"]*)")?:$/ do |scope, table|
  # expects description of a object display in table where col 1 is label, col 2 is value
  #debugger
  with_scope(scope) do
    table.raw.each do |label, value|
      #debugger
      #Then %{I should see "#{hash['value']}" on the row containing "#{hash['label']}" within #{scope}}
      selector = ".//td[contains(.,'#{label}')]//.."
      within(:xpath, selector) do
        Then %{I should see "#{value}"}
      end
    end
  end  
end

Then /^(?:|I )should see the following table(?: within "([^"]*)")?:$/ do |scope, table|
  # expects description of a table which should contain each of the content, in any column order
  with_scope(scope) do
      # use .rows to not check header row
    table.raw.each do |array|
      match = array.collect {|cell| "contains(.,'#{cell}')"}.join(' and ')
      selector = ".//tr[#{match}]"
      page.should have_xpath( selector )
    end
  end  
end

Then /^(?:|I )should see the following table columns(?: within "([^"]*)")?:$/ do |scope, table|
  with_scope(scope) do
    table.transpose.raw.each do |array|
      match = array.collect {|cell| "contains(.,'#{cell}')"}.join(' and ')
      selector = ".//tr[#{match}]"
      page.should have_xpath( selector )
    end
  end
end

Then /^(?:|I )should not see the following table columns(?: within "([^"]*)")?:$/ do |scope, table|
  with_scope(scope) do
    table.transpose.raw.each do |array|
      match = array.collect {|cell| "contains(.,'#{cell}')"}.join(' and ')
      selector = ".//tr[#{match}]"
      page.should have_no_xpath( selector )
    end
  end
end

Then /^(?:|I )should see a link to "([^"]*)"(?: within "([^"]*)")?$/ do |link, selector|
  with_scope(selector) do
    page.should have_xpath( ".//a", :text => link)
  end
end

Then /^the row containing "([^"]*)"(?: within (.*)) is highlighted as "([^"]*)"?$/ do |text, scope, css|
  selector = ".//td[contains(.,'#{text}')]//..[@class and contains(@class,'#{css}')]"
  with_scope(selector_for(scope)) do
    page.should have_xpath(selector)
  end
end

Then /^debugger$/ do
  debugger
end


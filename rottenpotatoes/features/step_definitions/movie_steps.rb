# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    # each returned element will be a hash whose key is the table header.
    #movies_path(:movie => movie)
    @movie= Movie.create!(:title => movie["title"], :rating => movie["rating"], :release_date => movie["release_date"])   
    #MoviesController.create
    # you should arrange to add that movie to the database here.
  end
  #fail "Unimplemented"
end

Then /(.*) seed movies should exist/ do | n_seeds |
  Movie.count.should be n_seeds.to_i
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.body is the entire content of the page as a string.
  fail "Unimplemented"
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I press "(.*)" button/ do |button|
  click_button(button)
end

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
  ratings = rating_list.split(', ')
  ratings.each do |rating|
    uncheck ? uncheck("ratings[#{rating}]") : (check("ratings[#{rating}]"))
  end
  #@movie = Movie.where(rating_list)
  #end
end

#When ('I uncheck (.*)') do |rating_list|
#    rating_list.each do | rating1 |
#      check(rating1)
#    end
#  #fail "Unimplemented"
#end

Then /there should be (.*) movies that are (.*)/ do |n, rating_list|
  count = Movie.where(rating: rating_list).count
  #ratings = rating_list.split(',')
  #ratings.each do |rating|
   # count = count + Movie.where("ratings[#{rating}]").count
  #end
  #count.should be n.to_i
  puts Movie.with_ratings(rating_list)["title"]
end

Then /^(?:|I )should see this (.*)/ do |text|
  text1 = text.split(', ')
  text1.each do |text2|
    #if page.respond_to? :should
    page.should have_content(text2)
    #else
     # assert page.has_content?(text2)
    #end
  end
end

Then /^(?:|I )should not see this (.*)/ do |text|
  text1 = text.split(', ')
  text1.each do |text2|
    #if page.respond_to? :should
    page.should have_no_content(text2)
    #else
     # assert page.has_content?(text2)
    #end
  end
end

Then /I should see all the movies/ do
  # Make sure that all the movies in the app are visible in the table
  #@movie = Movie.all
  Movie.all.each do |movie|
    page.should have_content(movie["title"])
  end
  #expect(rows).to eq value 10
  #fail "Unimplemented"
end

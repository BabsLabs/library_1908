require 'minitest/autorun'
require 'minitest/pride'
require './lib/library'
require './lib/author'
require './lib/book'

class LibraryTest < Minitest::Test

  def setup
    @dpl = Library.new("Denver Public Library")
    @charlotte_bronte = Author.new({first_name: "Charlotte", last_name: "Bronte"})
    @harper_lee = Author.new({first_name: "Harper", last_name: "Lee"})
  end

  def test_it_exists
    assert_instance_of Library, @dpl
  end

  def test_attributes
    assert_equal "Denver Public Library", @dpl.name
    assert_equal [], @dpl.books
    assert_equal [], @dpl.authors
  end

  def test_can_add_authors
    @dpl.add_author(@charlotte_bronte)
    assert_equal [@charlotte_bronte], @dpl.authors

    @dpl.add_author(@harper_lee)
    assert_equal [@charlotte_bronte, @harper_lee], @dpl.authors
  end

  def test_authors_books_are_library_books_once_added
    jane_eyre = @charlotte_bronte.write("Jane Eyre", "October 16, 1847")
    professor = @charlotte_bronte.write("The Professor", "1857")
    villette = @charlotte_bronte.write("Villette", "1853")
    mockingbird = @harper_lee.write("To Kill a Mockingbird", "July 11, 1960")
    @dpl.add_author(@charlotte_bronte)
    @dpl.add_author(@harper_lee)
    assert_equal [jane_eyre, professor, villette, mockingbird], @dpl.books
  end

  def test_publication_timeframe
    @charlotte_bronte.write("Jane Eyre", "October 16, 1847")
    @charlotte_bronte.write("The Professor", "1857")
    @charlotte_bronte.write("Villette", "1853")
    @dpl.add_author(@charlotte_bronte)
    expected = {:start=>"1847", :end=>"1857"}
    assert_equal expected, @dpl.publication_time_frame_for(@charlotte_bronte)
  end

end

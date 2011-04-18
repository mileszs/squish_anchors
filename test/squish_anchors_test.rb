require 'test/unit'
require File.join(File.dirname(__FILE__), '../', 'lib/', 'squish_anchors')
class String; include SquishAnchors; end
class SquishAnchorsTest < Test::Unit::TestCase
  def test_squish_anchors_combines_multiple_adjacent_anchor_tags_with_identical_hrefs_in_a_string_into_one
    str = '<a href="/foo/bar"> This is</a>  <a href="/foo/bar">some mal </a> <a href="/foo/bar"> formed HTML content</a> from a JS wysiwig HTML editor'
    assert str.squish_anchors.scan(/<a\shref="\/foo\/bar">([^<]+)<\/a>/).size == 1
  end

  def test_squish_anchors_does_not_combine_multiple_adjacent_anchor_tags_with_different_hrefs_in_a_string_into_one
    str = '<a href="/foo/bar"> This is</a>  <a href="/foo/baz">some mal </a> <a href="/foo/bar/baz"> formed HTML content</a> from a JS wysiwig HTML editor'
    assert str.squish_anchors.scan(/<a\shref="(.*?)">([^<]+)<\/a>/).size > 1
  end

  def test_squish_anchors_does_not_affect_original_string
    orig_str = '<a href="/foo/bar"> This is</a>  <a href="/foo/baz">some mal </a> <a href="/foo/bar/baz"> formed HTML content</a> from a JS wysiwig HTML editor'
    str = orig_str.dup
    str.squish_anchors
    assert orig_str == str
  end

  def test_squish_anchors_should_handle_single_quoted_href_values
    str = "<a href='/foo/bar'> This is</a>  <a href='/foo/bar'>some mal </a> <a href='/foo/bar'> formed HTML content</a> from a JS wysiwig HTML editor"
    assert str.squish_anchors.scan(/<a\shref="\/foo\/bar">([^<]+)<\/a>/).size == 1
  end

  def test_squish_anchors_should_return_the_string_if_no_anchors_are_present
    str = "This string doesn't have any matching anchors"
    assert str.squish_anchors == str
  end
end

require 'test_helper'

class CommentTest < ActiveSupport::TestCase

  def setup
    @user = users(:michael)
    @micropost = @user.microposts.first
    @comment = Comment.new(content: "Lorem ipsum", micropost_id: @micropost.id)
  end

  test "comment should be valid" do
    assert @comment.valid?
  end

  test "micropost_id should be present" do
    @comment.micropost_id = nil
    assert_not @comment.valid?
  end

  test "content should be present" do
    @comment.content = ""
    assert_not @comment.valid?
  end

  test "content should not be longer than 140 characters" do
    @comment.content = "a" * 141
    assert_not @comment.valid?
  end
end

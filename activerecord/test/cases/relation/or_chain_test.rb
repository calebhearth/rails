require 'cases/helper'
require 'models/comment'

module ActiveRecord
  class WhereChainTest < ActiveRecord::TestCase
    fixtures :comments

    def test_where_or_where
      greetings = comments(:greetings)
      does_it_hurt = comments(:does_it_hurt)
      expected = [greetings, does_it_hurt]

      actual = Comment.where(id: greetings.id).or.where(body: does_it_hurt.body)

      assert_equal(expected, actual)
    end

    def test_some_scope_or_where
      expected = [comments(:greetings), comments(:more_greetings), comments(:does_it_hurt)]

      actual = Comment.for_first_post.or.where(id: comments(:does_it_hurt).id)

      assert_equal(expected, actual)
    end

    def test_where_or_some_scope
      expected = [comments(:greetings), comments(:more_greetings), comments(:does_it_hurt)]

      actual = Comment.where(id: comments(:does_it_hurt).id).or.for_first_post

      assert_equal(expected, actual)
    end
  end
end

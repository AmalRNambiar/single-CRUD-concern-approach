module CommentsHelper

	def nested_comments(comments)
	  comments.map do |comment, replies|
	    render(comment) + content_tag(:div, nested_comments(replies), class: "nested_comments collapse", id: "reply_#{comment.id}")
	  end.join.html_safe
	end

	def upvotes(comment)
		comment.get_upvotes.size.zero? ? nil : comment.get_upvotes.size
	end

	def downvotes(comment)
		comment.get_downvotes.size.zero? ? nil : comment.get_downvotes.size
	end

	def reply_count(comment)
		comment.children.count
	end

end

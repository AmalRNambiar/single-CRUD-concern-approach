module QuestionsHelper

	def progress(progress)
		case progress
		when 0..30
			{color: 'danger', bg: 'red'}
		when 31..69
			{color: 'yellow', bg: 'yellow'}
		when 70..100
			{color: 'success', bg: 'green'}
		else
			{color: 'grey', bg: 'grey'}
		end	
	end

	def option(index: nil, option: nil, progress: 0, color: nil)
		(<<-HTML
			<div class="col-md-4">
			  <div class="progress-group">
			    <span class="progress-text">#{index+1}. #{option}</span>
			    <div class="progress md progress-striped active">
			      <div class="progress-bar progress-bar-#{color}" style="width: #{progress}%"></div>
			    </div>
			  </div>
			</div>
		HTML
    ).html_safe
	end

	def color(progress)
		case progress
		when 0..30
		  'danger'
		when 31..69
			'yellow'
		when 70..100
			'success'
		else
			'grey'
		end	
	end

	def comments_count(question)
		question.comments_count
	end

end

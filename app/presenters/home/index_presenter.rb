class Home::IndexPresenter
  extend ActiveSupport::Memoizable

  def recent_tweet
    CacheTweet.last_tweets(3, 'rails_france').each { |tweet| tweet['text'] = tweet['text'].gsub(/http[s]?:\/\/(\S)*/, '<a href="\0" target="_blank" data-skip-pjax>\0</a>').html_safe }
  end

  def recent_questions
    Question.order('created_at DESC').limit(3)
  end

  def recent_jobs
    Job.where(:state => 'activated').limit(3)
  end

  def recent_events
    Event.limit(3)
  end

  def rails_projects
    [
     {:img => 'tutorys.png', :link => "https://www.tutorys.com", :title => 'Tutorys'},
     {:img => 'github.png', :link => 'https://github.com', :title => 'Github'},
     {:img => 'groupon.png', :link => "http://www.groupon.fr", :title => 'Groupon'},
     {:img => 'letitcast.png', :link => "https://letitcast.com", :title => 'Letitcast'},
     {:img => 'dimelo.png', :link => 'http://dimelo.com', :title => 'Dimelo'},
     {:img => 'linuxfr.png', :link => "http://linuxfr.org", :title => 'Linuxfr'},
     {:img => 'shopify.png', :link => "http://www.shopify.com", :title => 'Shopify'},
     {:img => 'tigerlily.png', :link => "http://www.tigerlilyapps.com", :title => 'Tigerlily'},
     {:img => 'twitter.png', :link => "http://twitter.com/", :title => 'twitter'},
     {:img => 'izibook.png', :link => "http://izibook.com/", :title => 'Izibook'},
     {:img => 'locomotive.png', :link => "http://locomotivecms.com", :title => 'Locomotive'}
    ]
  end

  memoize :recent_questions, :recent_jobs, :recent_events
end

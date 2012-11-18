class MapController < ApplicationController
  def index; end

  def users
    respond_to do |f|
      f.json do
        render json: User.select('username,latitude,longitude,slug').geocoded.map! {|o| o.attributes.merge(link: user_url(o["slug"]), title: o["username"],icon: view_context.image_path('map/users.png') )}
      end
    end
  end

  def jobs
    respond_to do |f|
      f.json do
        render json: Job.select('title,latitude,longitude,slug').with_state(:activated).map! {|o| o.attributes.merge(link: job_url(o["slug"]),icon: view_context.image_path('map/jobs.png'))}
      end
    end
  end

  def events
    respond_to do |f|
      f.json do
        render json: Event.select('title,slug,latitude,longitude').geocoded.where("date > ?", Time.now - 1.day).map! {|o| o.attributes.merge(link: event_url(o["slug"]), icon: view_context.image_path('map/events.png'))}
      end
    end
  end
end

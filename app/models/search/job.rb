class Search::Job < BasicActiveModel
  attr_accessor :freelance, :cdi, :cdd, :internship, :remote

  def execute
    jobs = Job.with_state(:activated)

    where = [:freelance, :cdi, :cdd, :internship].inject([]) do |a,b|
      a << "#{b} = 't'" if send(b)
      a
    end.join(' OR ')

    jobs = jobs.where(where) unless where.blank?
    jobs = jobs.order('created_at DESC')
    jobs
  end

  def initialize(attributes)
    attributes = attributes.each_pair {|k,v| attributes[k] = (v.to_i == 1 or v == "true" ? true : false)}
    super(attributes)
  end

end

class Search::Job < BasicActiveModel

  attr_accessor :freelance, :cdi, :cdd, :internship, :remote

  def execute
    jobs = Job.with_state(:activated)

    jobs = jobs.where(:freelance => true) if freelance
    jobs = jobs.where(:cdi => true) if cdi
    jobs = jobs.where(:cdd => true) if cdd
    jobs = jobs.where(:internship => true) if internship
    jobs
  end

  def initialize(attributes)
    attributes = attributes.each_pair {|k,v| attributes[k] = (v.to_i == 1 ? true : false)}
    super(attributes)
  end

end

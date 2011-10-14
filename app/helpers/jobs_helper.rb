module JobsHelper
  def link_to_company job
    return job.company unless job.url.present?
    link_to job.company, job.url
  end

  def format_contracts contracts
    contracts.each do |contract|
      Job.human_attribute_name(contract)
    end.join(', ')
  end
end

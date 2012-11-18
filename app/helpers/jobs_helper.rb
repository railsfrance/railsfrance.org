module JobsHelper
  def link_to_company job
    return job.company unless job.url.present?
    link_to job.company, job.url,:target => "_blank"
  end

  def format_contracts contracts
    contracts.map { |v| Job.human_attribute_name(v.to_sym) }.join(', ')
  end
end

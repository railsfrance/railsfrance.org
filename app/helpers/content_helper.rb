module ContentHelper
  def markdown(text)
    options = [:hard_wrap, :filter_html, :autolink, :no_intraemphasis, :fenced_code, :gh_blockcode, :no_image]
    syntax_highlighter(Redcarpet.new(text, *options).to_html).html_safe
  end

  def syntax_highlighter(html)
    doc = Nokogiri::HTML::DocumentFragment.parse(html)
    doc.css('pre[@lang]').each do |pre|
      lang = pre[:lang]
      code = pre.text.rstrip
      request = Net::HTTP.post_form(URI.parse('http://pygments.appspot.com/'), {'lang'=>lang, 'code'=>code})
      pre.replace request.body
    end
    doc.to_s
  end
end

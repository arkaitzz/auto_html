AutoHtml.add_filter(:link).with({}) do |text, options|
  require 'uri'
  require 'rinku'
  require 'rexml/document'
  option_short_link_name = options.delete(:short_link_name)
  attributes = Array(options).reject { |k,v| v.nil? }.map { |k, v| %{#{k}="#{REXML::Text::normalize(v)}"} }.join(' ')
  Rinku.auto_link(text, :all, attributes) do |url|
  page = MetaInspector.new(url)
  
    if option_short_link_name
      uri = URI.parse(URI.encode(url.strip))
      uri.query = nil
      uri.to_s
    else
      #url

      %{<div class="post_link_preview">
          <div class="link_resume">
            <div class="link_domain"><i class="icon-link"></i>#{page.host}</div>
            <div>
              <div class="link_image" style="background-image:url(#{page.image})"></div>
              <div class="link_title"><p>#{page.title}</p></div>
              <div class="link_desc"><p>#{page.description}</p></div>
            </div>
          </div>
        </div>}

    end
  end
end

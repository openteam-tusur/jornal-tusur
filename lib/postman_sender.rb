class PostmanSender

  attr_accessor :subject, :body, :emails

  def initialize options
    @subject = options[:subject]
    @body = options[:body].to_str
    @emails = options[:emails].flatten.delete_if(&:blank?).uniq if options[:emails].is_a? Array
    @emails = [options[:emails]] if options[:emails].is_a? String
  end

  def send_emails
    Postman::Client::Dispatcher.new(host: Settings['postman.url']).send_mail(
      subject: subject,
      body: body,
      # see http://stackoverflow.com/questions/9469825/why-uri-escape-fails-when-called-on-actionviewoutputbuffer
      emails: emails,
      slug: Settings['postman.slug']
    )
  end

end

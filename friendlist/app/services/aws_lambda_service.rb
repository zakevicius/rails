# frozen_string_literal: true

class AwsLambdaService
  def initialize(options)
    @client = Aws::Lambda::Client.new(
      region: options[:region],
      credentials: Aws::Credentials.new(Rails.application.secrets.aws_access_key, Rails.application.secrets.aws_secret_key),
    )
  end

  def invoke(function_name, options)
    resp = @client.invoke({
                            function_name: function_name,
                            payload: options.to_json
                          })

    JSON.parse(resp[:payload].read)
  end
end

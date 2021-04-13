# frozen_string_literal: true

class AwsS3Service
  def initialize(options)
    @s3 = Aws::S3::Resource.new(
      region: options[:region],
      credentials: Aws::Credentials.new(Rails.application.secrets.aws_access_key, Rails.application.secrets.aws_secret_key),
    )
  end

  def upload_file(data, filename, key)
    file = Tempfile.new(filename)
    file.binmode
    file << data.to_json
    file.rewind

    bucket = @s3.bucket('test-m-photo')
    bucket.put_object({
                        body: file,
                        key: key
                      })
  end
end
